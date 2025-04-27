import StoreKit

@MainActor
class IAPManager: NSObject, ObservableObject {
    static let shared = IAPManager()
    
    @Published var userPurchased = false
    @Published var products: [SKProduct] = []

    private let productIDs: Set<String> = [
        "userpurchased",
        "com.huangyouci.ast_analysis.analyzeCount30"
    ]
    
    override init() {
        super.init()
        fetchProducts()
        SKPaymentQueue.default().add(self)
    }
    
    func fetchProducts() {
        let request = SKProductsRequest(productIdentifiers: productIDs)
        request.delegate = self
        request.start()
    }
    
    func purchaseProduct(withID id: String) {
        guard let product = products.first(where: { $0.productIdentifier == id }) else { return }
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func priceString(for id: String) -> String {
        guard let product = products.first(where: { $0.productIdentifier == id }) else { return "N/A" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = product.priceLocale
        return formatter.string(from: product.price) ?? "N/A"
    }
}

extension Notification.Name {
    static let didPurchaseAnalyzeCount = Notification.Name("didPurchaseAnalyzeCount")
}

extension IAPManager: SKProductsRequestDelegate, SKPaymentTransactionObserver {
    nonisolated func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.async {
            self.products = response.products
        }
    }
    
    nonisolated func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                let productID = transaction.payment.productIdentifier
                DispatchQueue.main.async {
                    if productID == "userpurchased" {
                        self.userPurchased = true
                    } else if productID == "com.huangyouci.ast_analysis.analyzeCount30" {
                        NotificationCenter.default.post(name: .didPurchaseAnalyzeCount, object: nil)
                    }
                }
                WebhookLog().logA(title: "購買操作", description: "使用者進行的購買操作", color: 0x1aff6e, fields: [("商品 ID","\(transaction.payment.productIdentifier)"),("狀態","成功購買")])
                SKPaymentQueue.default().finishTransaction(transaction)
            case .restored:
                let productID = transaction.payment.productIdentifier
                DispatchQueue.main.async {
                    if productID == "userpurchased" {
                        self.userPurchased = true
                    } else if productID == "com.huangyouci.ast_analysis.analyzeCount30" {
                        NotificationCenter.default.post(name: .didPurchaseAnalyzeCount, object: nil)
                    }
                }
                WebhookLog().logA(title: "購買操作", description: "使用者進行的購買操作", color: 0xebc334, fields: [("商品 ID","\(transaction.payment.productIdentifier)"),("狀態","成功還原")])
                SKPaymentQueue.default().finishTransaction(transaction)
            case .failed:
                WebhookLog().logA(title: "購買操作", description: "使用者進行的購買操作", color: 0xeb4634, fields: [("商品 ID","\(transaction.payment.productIdentifier)"),("狀態","失敗")])
                SKPaymentQueue.default().finishTransaction(transaction)
            default:
                break
            }
        }
    }

}
