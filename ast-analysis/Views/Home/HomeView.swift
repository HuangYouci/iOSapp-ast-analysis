//
//  HomeView.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/3/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var userData: UserData = UserData.shared
    @StateObject private var adViewModel = RewardedAdViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            
            HStack{
                Text("分科測驗分析")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                NavigationLink(destination: InfoView()){
                    Image(systemName: "info.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color(.label).opacity(0.5))
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            
            VStack{
                VStack(alignment: .leading){
                    HStack(alignment: .center){
                        VStack{
                            Text({
                                let now = Date()
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "MMM"
                                dateFormatter.timeZone = TimeZone.current // 可選
                                return dateFormatter.string(from: now)
                            }())
                            .font(.caption)
                            Text({
                                let now = Date()
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "dd"
                                dateFormatter.timeZone = TimeZone.current // 可選
                                return dateFormatter.string(from: now)
                            }())
                            .font(.title3)
                            .bold()
                        }
                        .padding(1)
                        .foregroundStyle(Color(.red))
                        Circle()
                            .fill(Color(.label).opacity(0.5))
                            .frame(width: 5, height: 5)
                            .padding(.horizontal, 3)
                        VStack{
                            Text("分科倒數")
                                .font(.caption)
                            Text({
                                let components = Calendar.current.dateComponents([.day], from: Date(), to: Date(timeIntervalSince1970: 1752163200))
                                
                                if let days = components.day {
                                    if days > 0 {
                                        return "\(days)"
                                    } else {
                                        return "--"
                                    }
                                } else {
                                    return "??"
                                }
                            }())
                            .font(.title3)
                            .bold()
                        }
                        VStack{
                            Text("成績公布")
                                .font(.caption)
                            Text({
                                let components = Calendar.current.dateComponents([.day], from: Date(), to: Date(timeIntervalSince1970: 1753718400))
                                
                                if let days = components.day {
                                    if days > 0 {
                                        return "\(days)"
                                    } else {
                                        return "--"
                                    }
                                } else {
                                    return "??"
                                }
                            }())
                            .font(.title3)
                            .bold()
                        }
                        Spacer()
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
                .background(Color(.systemBackground))
                .clipShape(
                    .rect(
                        topLeadingRadius: 0,
                        bottomLeadingRadius: 20,
                        bottomTrailingRadius: 20,
                        topTrailingRadius: 0
                    )
                )
            }
            .background(Color(.secondarySystemBackground))
            
            ScrollView{
                
                Color.clear
                    .padding(.bottom, 5)

                NavigationLink(destination: InputView()){
                    VStack(alignment: .leading, spacing: 20){
                        HStack(alignment: .bottom){
                            Text("成績輸入")
                                .font(.title3)
                            Spacer()
                            Image(systemName: "square.and.pencil")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(Color(.accent))
                        }
                        Text(IAPManager.shared.premium ? "付費用戶 - 無限次分析啟用中" : "尚餘 \(userData.userData.analyzeCount) 次分析次數")
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: Color(.label).opacity(0.1),radius: 5)
                }
                .buttonStyle(.plain)
                .disabled(userData.userData.analyzeCount < 1 && !IAPManager.shared.premium)
                .padding(.horizontal)
                
                NavigationLink(destination: ResultListView()){
                    VStack(alignment: .leading, spacing: 20){
                        HStack(alignment: .center){
                            Text("分析結果")
                                .font(.title3)
                            Text("\(userData.userData.grade.count) 筆分析結果")
                            Spacer()
                            Image(systemName: "chart.line.text.clipboard")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(Color(.accent))
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: Color(.label).opacity(0.1),radius: 5)
                    .padding(.horizontal)
                }
                .buttonStyle(.plain)
                
                NavigationLink(destination: ListView()){
                    VStack(alignment: .leading, spacing: 20){
                        HStack(alignment: .center){
                            Text("校系清單")
                                .font(.title3)
                            Text("\(DepartmentData.shared.departments.count) 個校系")
                            Spacer()
                            Image(systemName: "doc.text")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(Color(.accent))
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: Color(.label).opacity(0.1),radius: 5)
                    .padding(.horizontal)
                }
                .buttonStyle(.plain)
                
                HStack{
                    
                    Button{
                        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                           let rootViewController = scene.windows.first?.rootViewController {
                            adViewModel.showAd(from: rootViewController) {
                                userData.userData.analyzeCount += 1
                            }
                        }
                    } label: {
                        VStack(alignment: .leading, spacing: 20){
                            HStack(alignment: .bottom){
                                Text("分析次數")
                                    .font(.title3)
                                Spacer()
                                Image(systemName: "play.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color(.accent))
                            }
                            Text(adViewModel.isAdLoaded ? "觀看廣告以獲得" : "廣告尚未準備好")
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: Color(.label).opacity(0.1),radius: 5)
                    }
                    .buttonStyle(.plain)
                    .disabled(!adViewModel.isAdLoaded)
                    
                    NavigationLink(destination: ProView()){
                        VStack(alignment: .leading, spacing: 20){
                            HStack(alignment: .bottom){
                                Text("付費用戶")
                                    .font(.title3)
                                Spacer()
                                Image(systemName: "crown")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color(.accent))
                            }
                            Text(IAPManager.shared.premium ? "感謝成為付費用戶" : "獲得無限分析次數")
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: Color(.label).opacity(0.1),radius: 5)
                    }
                    .buttonStyle(.plain)
                    
                }
                .padding(.horizontal)
                
                HStack{
                    Text("")
                        .font(.caption)
                        .foregroundStyle(Color(.systemGray2))
                        .padding(.vertical, 5)
                    Spacer()
                }
                .padding(.horizontal)
                
                // TIPS
                TipView(keyName: "decliamier",
                        title: "免責聲明",
                        content: "本程式之校系資料來自大學考試入學分發委員會，錄取機率計算皆為往年資料與模型推估。所有資料僅供參考，填志願之前請再三思考。使用後，代表您同意使用者條款以及隱私政策。若需查看詳細條款，請點擊右上方「i」進入網站查閱。（您可透過提示右方的「x」來關閉這些提示）")
                
                TipView(keyName: "distAnalysis",
                        title: "差距分析",
                        content: "還沒考分科測驗也可以落點分析！以現有學測成績分析離目標校系的差距，快試試「差距分析」！（輸入完成績後，於結果頁點入結果之功能入口）")
                
                TipView(keyName: "choiceDeptEntry",
                        title: "模擬志願選填",
                        content: "您可為每個結果模擬設置 100 個志願以及設置最愛校系，每個結果的志願校系與最愛校系皆為獨立。")
                
                TipView(keyName: "suggestion",
                        title: "功能反饋",
                        content: "若您有功能建議或問題反饋，請來信至 ycdev@icloud.com")
                
            }
            .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
            .background(Color(.secondarySystemBackground))
            
        }
        .navigationTitle("分科測驗分析")
        .toolbar(.hidden)
    }
    
}

#Preview {
    HomeView()
}
