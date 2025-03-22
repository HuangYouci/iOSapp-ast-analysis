//
//  ContentView.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/3/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var departmentData: DepartmentData
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab){
            InputView()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("輸入")
                }
                .tag(0)
            ResultView()
                .tabItem {
                    Image(systemName: "chart.line.text.clipboard.fill")
                    Text("結果")
                }
                .tag(1)
            ListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("列表")
                }
                .tag(2)
        }
    }
}

#Preview {
    ContentView()
}
