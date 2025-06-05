//
//  ProView.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/3/25.
//

import SwiftUI

struct ProView: View{
    @StateObject private var iapManager: IAPManager = IAPManager.shared
    @StateObject private var userData: UserData = UserData.shared
    
    var body: some View {
        VStack(spacing: 0){
            
            HStack{
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 1)
            
            VStack{
                VStack(alignment: .leading){
                    HStack(alignment: .center){
                        VStack{
                            Text("分析次數")
                                .font(.caption)
                            Text(iapManager.premium ? "∞" : "\(userData.userData.analyzeCount)")
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
                
                // 購買商品
                HStack{
                    Text("次數購買")
                        .font(.caption)
                        .foregroundStyle(Color(.systemGray2))
                        .padding(.vertical, 5)
                    Spacer()
                }
                .padding(.horizontal)
                FlowLayout {
                    
                    // 單次付費
                    
                    if let product = iapManager.products.first(where: { $0.id == "com.huangyouci.ast_analysis.analyzeCount30" } ){
                        Button {
                            Task {
                                _ = await iapManager.purchase(product)
                            }
                        } label: {
                            VStack(alignment: .leading, spacing: 10){
                                HStack(alignment: .bottom){
                                    Text(product.displayName)
                                        .font(.title3)
                                        .bold()
                                }
                                VStack(alignment: .leading){
                                    Text("- 單次獲得分析次數")
                                    Text("- 優惠選擇")
                                    Text("- 支持開發")
                                }
                                .foregroundStyle(Color(.systemGray))
                                VStack(alignment: .leading){
                                    Text("購買")
                                        .font(.caption)
                                        .foregroundStyle(Color(.systemGray))
                                    Text(product.displayPrice)
                                        .font(.title2)
                                        .bold()
                                }
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: Color(.label).opacity(0.1),radius: 5)
                        }
                        .buttonStyle(.plain)
                    }
                    
                    // 付費用戶
                    if iapManager.premium {
                        VStack(alignment: .leading, spacing: 10){
                            HStack(alignment: .bottom){
                                Text("付費用戶")
                                    .font(.title3)
                                    .bold()
                            }
                            VStack(alignment: .leading){
                                Text("- 無限次分析次數")
                                Text("- 刪程式後可復原")
                                Text("- 支持開發")
                            }
                            .foregroundStyle(Color(.systemGray))
                            VStack(alignment: .leading){
                                Text("")
                                    .font(.caption)
                                    .foregroundStyle(Color(.systemGray))
                                Text("已購買")
                                    .font(.title2)
                                    .bold()
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: Color(.label).opacity(0.1),radius: 5)
                    } else if let product = iapManager.products.first(where: {$0.id == "userpurchased"}) {
                        
                        Button {
                            Task {
                                _ = await iapManager.purchase(product)
                            }
                        } label: {
                            VStack(alignment: .leading, spacing: 10){
                                HStack(alignment: .bottom){
                                    Text(product.displayName)
                                        .font(.title3)
                                        .bold()
                                }
                                VStack(alignment: .leading){
                                    Text("- 無限次分析次數")
                                    Text("- 刪程式後可復原")
                                    Text("- 支持開發")
                                }
                                .foregroundStyle(Color(.systemGray))
                                VStack(alignment: .leading){
                                    Text("購買")
                                        .font(.caption)
                                        .foregroundStyle(Color(.systemGray))
                                    Text(product.displayPrice)
                                        .font(.title2)
                                        .bold()
                                }
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: Color(.label).opacity(0.1),radius: 5)
                        }
                        .buttonStyle(.plain)
                    }
                    
                }
                .padding(.horizontal)
                
                // 恢復購買
                HStack{
                    Text("恢復購買")
                        .font(.caption)
                        .foregroundStyle(Color(.systemGray2))
                        .padding(.vertical, 5)
                    Spacer()
                }
                .padding(.horizontal)
                Button {
                    Task {
                        await iapManager.restorePurchases()
                    }
                } label: {
                    VStack(alignment: .leading, spacing: 20){
                        HStack(alignment: .bottom){
                            Text("恢復購買")
                                .font(.title3)
                                .bold()
                            Spacer()
                            Image(systemName: "restart.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(Color(.accent))
                        }
                        VStack(alignment: .leading){
                            Text("此功能可回復您之前所做的購買項目")
                                .foregroundStyle(Color(.systemGray))
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: Color(.label).opacity(0.1),radius: 5)
                }
                .buttonStyle(.plain)
                .padding(.horizontal)
                
                // 提示
                HStack{
                    Text("")
                        .font(.caption)
                        .foregroundStyle(Color(.systemGray2))
                        .padding(.vertical, 5)
                    Spacer()
                }
                .padding(.horizontal)
                TipView(keyName: "shopinfo",
                        title: "購買說明",
                        content: """
                        ※ 購買前，請務必詳閱使用條款及隱私政策與本提示。
                        - 「100 次分析次數」說明 
                        100 次分析次數原則上僅適用於目前版本，雖然本程式不會刻意清除，但隨著大版本更新，在有其必要的情況下，不保證次數留存。
                        - 「無限次分析次數（付費方案）」說明
                        購買無限次分析次數（付費方案）可至少在本年度分科測驗放榜前無限次使用分析功能，在有其必要的情況下（包括但不限於考招規則改變、程式政策改變等），在下個學年度資料更新時可能無法再使用。
                        
                        ※ 購買後若有疑問，請來信詢問。
                        """)
                
                Color.clear
                    .padding(.bottom, 5)
                
            }
            .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
            .background(Color(.secondarySystemBackground))
            
            VStack(alignment: .leading){
                
                NavigationLink(destination: InfoView()){
                    HStack{
                        Spacer()
                        Text("購買前，請詳閱使用條款及隱私政策")
                        Spacer()
                    }
                }
                .buttonStyle(.plain)
                
                HStack{
                    Spacer()
                }
            }
            .padding()
            
        }
        .navigationTitle("付費用戶")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview{
    ProView()
}
