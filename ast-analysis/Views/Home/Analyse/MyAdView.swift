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
    @State private var remainingSeconds: Int = 30
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
                Image("ad")
                    .resizable()
                    .scaledToFit()
                Text("( 廣告洽談: ycdev@icloud.com )")
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
