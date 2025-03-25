//
//  ContentView.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/3/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var departmentData: DepartmentData
    
    var body: some View {
        Group {
            GeometryReader { geometry in
                if geometry.size.width > geometry.size.height {
                    // 平板（橫向）
                    HomeView_pad()
                } else {
                    // 手機（直向）
                    TabView{
                        HomeView()
                            .tabItem {
                                Image(systemName: "square.and.pencil")
                                Text("主頁")
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
        }
    }
}

#Preview {
    ContentView()
}

