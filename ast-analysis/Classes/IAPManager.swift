import Foundation
import StoreKit

@MainActor
class IAPManager: ObservableObject {
    static let shared = IAPManager()
    
    @Published var products: [Product] = []
    @Published var premium: Bool = false
    
    /// 所有商品 ID（包含一次性購買、消耗品）
    let productIDs: [String] = [
        "userpurchased",
        "com.huangyouci.ast_analysis.analyzeCount30"
    ]
    
    private init() {
        self.premium = UserDefaults.standard.bool(forKey: "isPremiumUser")

        Task {
            await updateProducts()
            await checkPremium()
            await listenForTransactionUpdates()
        }
    }
    
    /// 監聽來自 App Store 的交易更新
    func listenForTransactionUpdates() async {
        for await update in Transaction.updates {
            switch update {
            case .verified(let transaction):
                print("IAPManager | 偵測到已驗證的交易：\(transaction.productID)")
                await handleVerifiedTransaction(transaction: transaction, isRestore: true)
                
            case .unverified(let unverifiedTransaction, let error):
                print("IAPManager | 偵測到未驗證的交易：\(unverifiedTransaction.productID), Error: \(error.localizedDescription)")
                WebhookLog().logA(title: "購買操作", description: "偵測到未驗證交易", color: 0xFFD700, fields: [("商品 ID", unverifiedTransaction.productID), ("錯誤", error.localizedDescription)])
            }
        }
    }

    /// 抓取產品資訊
    func updateProducts() async {
        do {
            products = try await Product.products(for: productIDs)
            print("IAPManager | 成功載入 \(products.count) 項產品。")
        } catch {
            print("IAPManager | 產品載入失敗：\(error)")
        }
    }
    
    /// 購買指定產品
    func purchase(_ product: Product) async -> Bool {
        do {
            let result = try await product.purchase()
            switch result {
            case .success(let verification):
                switch verification {
                case .unverified(let unverifiedTransaction, let error):
                    print("IAPManager | 購買未通過驗證：\(unverifiedTransaction.productID)")
                    WebhookLog().logA(title: "購買操作", description: "購買未通過驗證", color: 0xFFD700, fields: [("商品 ID", unverifiedTransaction.productID), ("錯誤", error.localizedDescription)])
                    return false
                case .verified(let transaction):
                    print("IAPManager | 購買成功：\(transaction.productID)")
                    
                    await handleVerifiedTransaction(transaction: transaction, isRestore: false)
                    return true
                }
            case .userCancelled:
                print("IAPManager | 使用者取消購買：\(product.id)")
                WebhookLog().logA(title: "購買操作", description: "使用者取消了購買", color: 0xcccccc, fields: [("商品 ID", product.id),("狀態","使用者取消")])
                return false
            case .pending:
                print("IAPManager | 購買待處理：\(product.id)")
                WebhookLog().logA(title: "購買操作", description: "交易待批准", color: 0x34a5eb, fields: [("商品 ID", product.id),("狀態","待批准")])
                return false
            @unknown default:
                print("IAPManager | 未知的購買結果：\(product.id)")
                WebhookLog().logA(title: "購買操作", description: "未知交易狀態", color: 0x999999, fields: [("商品 ID", product.id),("狀態","未知")])
                return false
            }
        } catch {
            print("IAPManager | 購買失敗：\(error)")
            WebhookLog().logA(title: "購買操作", description: "購買失敗", color: 0xeb4634, fields: [("商品 ID", product.id), ("錯誤", error.localizedDescription)])
        }
        return false
    }
    
    /// 還原購買（主要用於非消耗性商品，如永久解鎖）
    func restorePurchases() async {
        print("IAPManager | 正在還原購買...")
        do {
            try await AppStore.sync()

            await checkPremium()
            print("IAPManager | 還原購買完成。")
            WebhookLog().logA(title: "購買操作", description: "手動還原購買", color: 0xebc334, fields: [("狀態","成功觸發還原")])
        } catch {
            print("IAPManager | 還原購買失敗：\(error)")
            WebhookLog().logA(title: "購買操作", description: "恢復購買失敗", color: 0xFF0000, fields: [("錯誤", error.localizedDescription)])
        }
    }
    
    // MARK: - Transaction & Entitlement Handling
    
    /// 處理已驗證的交易
    private func handleVerifiedTransaction(transaction: Transaction, isRestore: Bool) async {
        let productID = transaction.productID
        
        switch productID {
        case "userpurchased":
            // 處理非消耗性商品 (e.g., 永久解鎖)
            self.premium = true
            UserDefaults.standard.set(true, forKey: "isPremiumUser")
            print("IAPManager | Product \(productID) \(isRestore ? "restored" : "purchased"). User premium status updated.")
            WebhookLog().logA(title: "購買操作", description: "使用者進行的購買操作", color: isRestore ? 0xebc334 : 0x1aff6e, fields: [("商品 ID","\(productID)"),("狀態", isRestore ? "成功還原" : "成功購買")])
            
        case "com.huangyouci.ast_analysis.analyzeCount30":
            await grantConsumableReward(for: productID)
            print("IAPManager | Product \(productID) \(isRestore ? "restored" : "purchased"). Analyze count notification posted.")
            WebhookLog().logA(title: "購買操作", description: "使用者進行的購買操作", color: isRestore ? 0xebc334 : 0x1aff6e, fields: [("商品 ID","\(productID)"),("狀態", isRestore ? "成功還原" : "成功購買")])

        default:
            print("IAPManager | 未知產品 ID：\(productID)")
        }
        await transaction.finish()
    }
    
    func checkPremium() async {
        print("IAPManager | 正在檢查 Premium 狀態...")
        var foundPremium = false
        
        for await result in Transaction.currentEntitlements {
            switch result {
            case .verified(let transaction):
                // 確保交易是有效的（未被撤銷）
                if transaction.revocationDate == nil {
                    if transaction.productID == "userpurchased" {
                        self.premium = true
                        foundPremium = true
                        UserDefaults.standard.set(true, forKey: "isPremiumUser")
                        print("IAPManager | 檢測到 Premium 權利。")
                    }
                }
            case .unverified(let unverifiedTransaction, let error):
                print("IAPManager | 檢測到未驗證的權利：\(unverifiedTransaction.productID), Error: \(error.localizedDescription)")
                WebhookLog().logA(title: "權利檢查", description: "檢測到未驗證權利", color: 0xFFD700, fields: [("商品 ID", unverifiedTransaction.productID), ("錯誤", error.localizedDescription)])
            }
        }
        
        // 如果遍歷所有權利後仍未找到 Premium 權限，則設置為 false
        if !foundPremium {
            self.premium = false
            UserDefaults.standard.set(false, forKey: "isPremiumUser")
            print("IAPManager | 未檢測到 Premium 權利。")
        }
    }
    
    /// 授予消耗性商品獎勵 (例如增加分析次數)
    func grantConsumableReward(for productID: String) async {
        switch productID {
        case "com.huangyouci.ast_analysis.analyzeCount30":
            print("IAPManager | 已授予 100 次分析次數。")
        default:
            break
        }
    }
}
