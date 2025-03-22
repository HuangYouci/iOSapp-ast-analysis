//
//  ast_analysisApp.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/3/21.
//

import SwiftUI

@main
struct ast_analysisApp: App {
    
    @StateObject var userData: UserData = UserData()
    @StateObject var departmentData: DepartmentData = DepartmentData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userData)
                .environmentObject(departmentData)
        }
    }
}
