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
            case .purchased, .restored:
                let productID = transaction.payment.productIdentifier
                DispatchQueue.main.async {
                    if productID == "userpurchased" {
                        self.userPurchased = true
                    } else if productID == "com.huangyouci.ast_analysis.analyzeCount30" {
                        NotificationCenter.default.post(name: .didPurchaseAnalyzeCount, object: nil)
                    }
                }
                SKPaymentQueue.default().finishTransaction(transaction)
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
            default:
                break
            }
        }
    }

}
