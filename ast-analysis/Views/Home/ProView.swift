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
        VStack{
            VStack(alignment: .leading){
                HStack{
                    VStack(alignment: .leading){
                        Text("付費用戶")
                            .font(.largeTitle)
                            .bold()
                        Text("享無限分析次數")
                            .foregroundStyle(Color(.systemGray))
                            .padding(.bottom, 5)
                    }
                    Spacer()
                    Button {
                        iapManager.restorePurchases()
                    } label: {
                        Text("恢復購買")
                    }
                }
                
                VStack(alignment: .leading){
                    Text("目前分析次數")
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 5)
                    Text("\(userData.userData.analyzeCount)")
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
                .padding(.bottom, 10)
                
                if iapManager.userPurchased {
                    VStack(alignment: .leading){
                        Text("付費用戶")
                            .font(.title2)
                            .bold()
                            .padding(.bottom, 5)
                        Label("無限次分析次數", systemImage: "checkmark")
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
                } else {
                    Button {
                        iapManager.purchaseProduct()
                    } label: {
                        VStack(alignment: .leading){
                            if let product = iapManager.product {
                                Text(product.localizedTitle)
                                    .font(.title2)
                                    .bold()
                                    .padding(.bottom, 5)
                                Label("無限次分析次數", systemImage: "checkmark")
                                    .foregroundStyle(Color(.systemGray))
                                Label("支持開發", systemImage: "checkmark")
                                    .foregroundStyle(Color(.systemGray))
                                    .padding(.bottom, 5)
                                Text("購買")
                                    .font(.caption)
                                    .foregroundStyle(Color(.systemGray))
                                Text("\(iapManager.priceString())")
                                    .font(.title2)
                                    .bold()
                            } else {
                                Text("載入中...")
                            }
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
                    .disabled(iapManager.product == nil)
                    .buttonStyle(.plain)
                }
                
                
                Spacer()
                
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
            .onChange(of: iapManager.userPurchased) { newValue in
                if newValue {
                    userData.userData.analyzeCount = 10000000
                }
            }
        }
        .navigationTitle("付費用戶")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview{
    ProView()
        .environmentObject(UserData())
        .environmentObject(IAPManager())
}
