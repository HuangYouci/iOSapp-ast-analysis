import StoreKit

@MainActor
class IAPManager: NSObject, ObservableObject {
    static let shared = IAPManager()
    
    @Published var userPurchased = false
    @Published var product: SKProduct?
    
    private let productID = "userpurchased"
    
    override init() {
        super.init()
        fetchProducts()
        SKPaymentQueue.default().add(self)
    }
    
    func fetchProducts() {
        let request = SKProductsRequest(productIdentifiers: [productID])
        request.delegate = self
        request.start()
    }
    
    func purchaseProduct() {
        guard let product = product else { return }
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func priceString() -> String {
        guard let product = product else { return "N/A" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = product.priceLocale
        return formatter.string(from: product.price) ?? "N/A"
    }
}

extension IAPManager: SKProductsRequestDelegate, SKPaymentTransactionObserver {
    nonisolated func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if let fetchedProduct = response.products.first {
            DispatchQueue.main.async {
                self.product = fetchedProduct
            }
        }
    }
    
    nonisolated func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                DispatchQueue.main.async {
                    self.userPurchased = true
                }
                SKPaymentQueue.default().finishTransaction(transaction)
            case .restored:
                DispatchQueue.main.async {
                    self.userPurchased = true
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
