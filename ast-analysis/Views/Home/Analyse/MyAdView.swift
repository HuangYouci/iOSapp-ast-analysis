//
//  NoAdShowView.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/3/25.
//

import SwiftUI

struct MyAdView: View {
    
    // --------------- //
    // EnvironmentObject
    @EnvironmentObject var userData: UserData
    // StateObject
    // Binding
    // State
    @State private var isAdCompleted: Bool = false
    @State private var remainingSeconds: Int = 60
    @State private var timer: Timer? = nil
    // --------------- //
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            VStack(alignment: .leading){
                Text("廣告")
                    .font(.largeTitle)
                    .bold()
                Text(isAdCompleted ? "廣告觀看完成，分析次數已新增，您可關閉此頁面" : "剩餘 \(remainingSeconds) 秒")
                    .foregroundStyle(Color(.systemGray))
            }
            ScrollView{
                VStack(alignment: .leading){
                    Text("若有開啟阻擋廣告程式，請關閉以支持永續開發。")
                    Text("歡迎試用我的其他 Apps！")
                        .bold()
                    Text("- 模擬面試：AI 面試練習")
                    Text("- 吳維庭：照片位置紀錄")
                    Text("- 學測個申分析")
                    Text("- ClassMate：課表、課程管理")
                    Text("請至 App Store 搜尋下載")
                    Text("( 廣告洽談: ycdev@icloud.com )")
                }
            }
            HStack{
                Spacer()
            }
            
        }
        .padding()
        .onAppear {
            startTimer()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    private func startTimer() {
        // 建立 timer，1 秒更新一次
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { t in
            if remainingSeconds > 0 {
                remainingSeconds -= 1
            } else {
                isAdCompleted = true
                userData.userData.analyzeCount += 1
                t.invalidate()  // 停止計時器
            }
        }
    }
    
}

#Preview {
    MyAdView()
        .environmentObject(UserData())
}
