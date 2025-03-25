import SwiftUI
import GoogleMobileAds

// 獎勵廣告 ViewModel
class RewardedAdViewModel: NSObject, ObservableObject, FullScreenContentDelegate {
    @Published var isAdLoaded = false
    private var rewardedAd: RewardedAd?
    
    // 自動切換測試與正式環境的廣告單元 ID
    private let adUnitID: String = {
        #if DEBUG
        return "ca-app-pub-3940256099942544/1712485313" // 測試廣告 ID
        #else
        return "ca-app-pub-4733744894615858/2955521739" // 你的正式廣告 ID
        #endif
    }()
    
    override init() {
        super.init()
        loadRewardedAd()
    }
    
    func loadRewardedAd() {
        RewardedAd.load(with: adUnitID, request: Request()) { [weak self] ad, error in
            if let error = error {
                print("獎勵廣告載入失敗: \(error.localizedDescription)")
                self?.isAdLoaded = false
            } else {
                self?.rewardedAd = ad
                self?.rewardedAd?.fullScreenContentDelegate = self
                self?.isAdLoaded = true
            }
        }
    }
    
    func showAd(from rootViewController: UIViewController, onReward: @escaping () -> Void) {
        if let ad = rewardedAd {
            ad.present(from: rootViewController) {
                print("用戶獲得獎勵！")
                onReward()
            }
        } else {
            print("廣告尚未準備好")
        }
    }
    
    // 廣告播放完畢或關閉時，重新載入下一個廣告
    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        loadRewardedAd()
    }
}
