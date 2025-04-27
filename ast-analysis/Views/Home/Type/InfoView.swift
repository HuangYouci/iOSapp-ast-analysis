//
//  InfoView.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/4/12.
//

import SwiftUI

struct InfoView: View{
    
    @EnvironmentObject private var userData: UserData
    @State private var safariItem: SafariItem?
    
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
                            Text("程式版本")
                                .font(.caption)
                            Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "")
                            .font(.title3)
                            .bold()
                        }
                        VStack{
                            Text("資料版本")
                                .font(.caption)
                            Text("\(LevelConstants.dataVersion) 年")
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
                
                VStack(alignment: .leading){
                    HStack{
                        Image("clearlogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .padding(.vertical, 5)
                        VStack(alignment: .leading){
                            Text("分科測驗分析")
                                .bold()
                                .font(.title3)
                            Text("由 YC 開發")
                            Text("ycdev@icloud.com")
                        }
                    }
                    Divider()
                        .padding(.vertical, 5)
                    HStack{
                        Text("程式版本")
                        Spacer()
                        Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "")
                            .foregroundStyle(Color(.systemGray))
                    }
                    Divider()
                        .padding(.vertical, 5)
                    HStack{
                        Text("校系資料")
                        Spacer()
                        Text("\(LevelConstants.dataVersion) 年")
                            .foregroundStyle(Color(.systemGray))
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: Color(.label).opacity(0.1),radius: 5)
                .padding(.horizontal)
                
                VStack(alignment: .leading){
                    Button {
                        safariItem = SafariItem(url: URL(string: "https://huangyouci.github.io/app/eula/")!)
                    } label: {
                        HStack{
                            Text("使用條款")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color(.systemGray))
                        }
                    }
                    Divider()
                        .padding(.vertical, 5)
                    Button {
                        safariItem = SafariItem(url: URL(string: "https://huangyouci.github.io/app/privacypolicy/")!)
                    } label: {
                        HStack{
                            Text("隱私政策")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color(.systemGray))
                        }
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: Color(.label).opacity(0.1),radius: 5)
                .padding(.horizontal)
                
            }
            .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
            .background(Color(.secondarySystemBackground))
            
        }
        .navigationTitle("程式資訊")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $safariItem) { item in
                    SafariView(url: item.url)
                }
        
    }
}

#Preview{
    InfoView()
        .environmentObject(UserData())
}
