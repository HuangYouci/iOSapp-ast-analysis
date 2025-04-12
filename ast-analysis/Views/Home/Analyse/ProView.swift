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
                
                FlowLayout{
                    
                    // 單次付費
                    
                    if let product = iapManager.products.first(where: { $0.productIdentifier == "com.huangyouci.ast_analysis.analyzeCount30" }) {
                        Button {
                            iapManager.purchaseProduct(withID: product.productIdentifier)
                        } label: {
                            VStack(alignment: .leading){
                                Text(product.localizedTitle)
                                    .font(.title2)
                                    .bold()
                                    .padding(.bottom, 5)
                                Label("100 次分析次數", systemImage: "checkmark")
                                    .foregroundStyle(Color(.systemGray))
                                Label("優惠選擇", systemImage: "checkmark")
                                    .foregroundStyle(Color(.systemGray))
                                Label("支持開發", systemImage: "checkmark")
                                    .foregroundStyle(Color(.systemGray))
                                    .padding(.bottom, 5)
                                Text("購買")
                                    .font(.caption)
                                    .foregroundStyle(Color(.systemGray))
                                Text(iapManager.priceString(for: product.productIdentifier))
                                    .font(.title2)
                                    .bold()
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(.systemGray6), lineWidth: 2)
                            )
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
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.systemGray6), lineWidth: 2)
                        )
                        .shadow(color: Color(.label).opacity(0.1),radius: 5)
                    } else if let proProduct = iapManager.products.first(where: { $0.productIdentifier == "userpurchased" }) {
                        Button {
                            iapManager.purchaseProduct(withID: proProduct.productIdentifier)
                        } label: {
                            VStack(alignment: .leading){
                                Text(proProduct.localizedTitle)
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
                                Text("購買")
                                    .font(.caption)
                                    .foregroundStyle(Color(.systemGray))
                                Text(iapManager.priceString(for: proProduct.productIdentifier))
                                    .font(.title2)
                                    .bold()
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(.systemGray6), lineWidth: 2)
                            )
                            .shadow(color: Color(.label).opacity(0.1),radius: 5)
                        }
                        .buttonStyle(.plain)
                    }

                    // 恢復購買
                    
                    Button {
                        iapManager.restorePurchases()
                    } label: {
                        VStack(alignment: .leading){
                            Text("恢復購買")
                                .font(.title2)
                                .bold()
                                .padding(.bottom, 5)
                            Label("嘗試復原購買", systemImage: "checkmark")
                                .foregroundStyle(Color(.systemGray))
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.systemGray6), lineWidth: 2)
                        )
                        .shadow(color: Color(.label).opacity(0.1),radius: 5)
                    }
                    .buttonStyle(.plain)
                    
                }
                .padding(.horizontal)
                
            }
            .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
            .background(Color(.secondarySystemBackground))
            
            VStack(alignment: .leading){
                
                HStack{
                    Spacer()
                    Text("購買前，請詳閱")
                    Link("使用條款", destination: URL(string: "https://huangyouci.github.io/app/eula/")!)
                    Text("及")
                    Link("隱私政策", destination: URL(string: "https://huangyouci.github.io/app/privacypolicy/")!)
                    Spacer()
                }
                
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
