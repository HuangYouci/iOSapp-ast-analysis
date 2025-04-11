//
//  InfoView.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/4/12.
//

import SwiftUI

struct InfoView: View{
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
                            Text("程式版本")
                                .font(.caption)
                            Text("\(LevelConstants.programVersion)")
                            .font(.title3)
                            .bold()
                        }
                        VStack{
                            Text("資料版本")
                                .font(.caption)
                            Text("\(LevelConstants.dataVersion)年")
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
                
                Text("感謝您使用本程式，本程式是由 YC DEV 所開發之分科測驗分析，可協助您檢閱與分析分科測驗校系資料。資料源自大學考試入學分發委員會，且僅供參考，最新資料以官方為主。使用本程式代表您已同意使用者條款 ( https://huangyouci.github.io/app/eula ) 與隱私權政策 ( https://huangyouci.github.io/app/privacypolicy )，若有其他問題，可來信開發者信箱 ( ycdev@icloud.com )。本程式的版本是 \(LevelConstants.programVersion)，資料年份是 \(LevelConstants.dataVersion) 年。")
                .padding(.horizontal)
                
            }
            .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
            .background(Color(.secondarySystemBackground))
            
        }
        .navigationTitle("程式資訊")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview{
    InfoView()
        .environmentObject(UserData())
}
