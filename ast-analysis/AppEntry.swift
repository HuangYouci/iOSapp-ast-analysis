//
//  ast_analysisApp.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/3/21.
//

import SwiftUI
import GoogleMobileAds

class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    MobileAds.shared.start(completionHandler: nil)

    return true
  }
}

@main
struct ast_analysisApp: App {
    
    @StateObject var userData: UserData = UserData()
    @StateObject var departmentData: DepartmentData = DepartmentData()
    @StateObject var iapManager: IAPManager = IAPManager()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userData)
                .environmentObject(departmentData)
                .environmentObject(iapManager)
        }
    }
}
