//
//  ProView.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/3/25.
//

import SwiftUI

struct ProView: View{
    @EnvironmentObject private var iapManager: IAPManager
    @EnvironmentObject private var userData: UserData
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
                            Text("\(userData.userData.analyzeCount)")
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
                
                HStack{
                    Text("分析次數購買")
                        .font(.caption)
                        .foregroundStyle(Color(.systemGray2))
                        .padding(.vertical, 5)
                    Spacer()
                }
                .padding(.horizontal)
                
                FlowLayout{
                    
                    // 單次付費
                    
                    if let product = iapManager.products.first(where: { $0.productIdentifier == "com.huangyouci.ast_analysis.analyzeCount30" }) {
                        Button {
                            iapManager.purchaseProduct(withID: product.productIdentifier)
                        } label: {
                            VStack(alignment: .leading, spacing: 10){
                                HStack(alignment: .bottom){
                                    Text(product.localizedTitle)
                                        .font(.title3)
                                        .bold()
                                }
                                VStack(alignment: .leading){
                                    Text("- 單次獲得分析次數")
                                        .foregroundStyle(Color(.systemGray))
                                    Text("- 優惠選擇")
                                        .foregroundStyle(Color(.systemGray))
                                    Text("- 支持開發")
                                        .foregroundStyle(Color(.systemGray))
                                }
                                VStack(alignment: .leading){
                                    Text("購買")
                                        .font(.caption)
                                        .foregroundStyle(Color(.systemGray))
                                    Text(iapManager.priceString(for: product.productIdentifier))
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
                    if iapManager.userPurchased {
                        // 已購買 UI
                        VStack(alignment: .leading){
                            Text("付費用戶")
                                .font(.title2)
                                .bold()
                                .padding(.bottom, 5)
                            Label("無限次分析次數", systemImage: "checkmark")
                                .foregroundStyle(Color(.systemGray))
                            Label("刪程式後可復原", systemImage: "checkmark")
                                .foregroundStyle(Color(.systemGray))
                            Label("支持開發", systemImage: "checkmark")
                                .foregroundStyle(Color(.systemGray))
                                .padding(.bottom, 5)
                            Text("")
                                .font(.caption)
                                .foregroundStyle(Color(.systemGray))
                            Text("已購買")
                                .font(.title2)
                                .bold()
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: Color(.label).opacity(0.1),radius: 5)
                    } else if let proProduct = iapManager.products.first(where: { $0.productIdentifier == "userpurchased" }) {
                        Button {
                            iapManager.purchaseProduct(withID: proProduct.productIdentifier)
                        } label: {
                            VStack(alignment: .leading, spacing: 10){
                                HStack(alignment: .bottom){
                                    Text(proProduct.localizedTitle)
                                        .font(.title3)
                                        .bold()
                                }
                                VStack(alignment: .leading){
                                    Text("- 無限次分析次數")
                                        .foregroundStyle(Color(.systemGray))
                                    Text("- 永久有效可恢復")
                                        .foregroundStyle(Color(.systemGray))
                                    Text("- 支持開發")
                                        .foregroundStyle(Color(.systemGray))
                                }
                                VStack(alignment: .leading){
                                    Text("購買")
                                        .font(.caption)
                                        .foregroundStyle(Color(.systemGray))
                                    Text(iapManager.priceString(for: proProduct.productIdentifier))
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
                
                
                HStack{
                    Text("恢復購買")
                        .font(.caption)
                        .foregroundStyle(Color(.systemGray2))
                        .padding(.vertical, 5)
                    Spacer()
                }
                .padding(.horizontal)

                // 恢復購買
                
                Button {
                    iapManager.restorePurchases()
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
        .onChange(of: iapManager.userPurchased) { newValue in
            if newValue {
                userData.userData.analyzeCount = 1000000
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .didPurchaseAnalyzeCount)) { _ in
            userData.userData.analyzeCount += 100
        }
        
    }
}

#Preview{
    ProView()
        .environmentObject(UserData())
        .environmentObject(IAPManager())
}
