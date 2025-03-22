//
//  ResultView.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/3/22.
//

import SwiftUI

struct ResultView: View {
    
    @EnvironmentObject private var userData: UserData
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                    Text("所有分析結果")
                        .font(.largeTitle)
                        .bold()
                    Text("共 \(userData.userData.grade.count) 筆分析資料")
                        .foregroundStyle(Color(.systemGray))
                }
                .padding()
                ScrollView{
                    FlowLayout{
                        ForEach(userData.userData.grade) { item in
                            NavigationLink(destination: EachResultView(resultID: item.id)){
                                VStack(alignment: .leading){
                                    HStack{
                                        Text(item.dataName)
                                            .font(.title3)
                                            .bold()
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundStyle(Color(.systemGray2))
                                    }
                                    Divider()
                                        .padding(.bottom, 5)
                                    FlowLayout{
                                        if item.GsatCH >= 0 {
                                            Text("國文 \(item.GsatCH)")
                                                .padding(5)
                                                .background(Color(.systemGray5))
                                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                        }
                                        if item.GsatEN >= 0 {
                                            Text("英文 \(item.GsatEN)")
                                                .padding(5)
                                                .background(Color(.systemGray5))
                                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                        }
                                        if item.GsatMA >= 0 {
                                            Text("數Ａ \(item.GsatMA)")
                                                .padding(5)
                                                .background(Color(.systemGray5))
                                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                        }
                                        if item.GsatMB >= 0 {
                                            Text("數Ｂ \(item.GsatMB)")
                                                .padding(5)
                                                .background(Color(.systemGray5))
                                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                        }
                                        if item.GsatSC >= 0 {
                                            Text("自然 \(item.GsatSC)")
                                                .padding(5)
                                                .background(Color(.systemGray5))
                                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                        }
                                        if item.GsatSO >= 0 {
                                            Text("社會 \(item.GsatSO)")
                                                .padding(5)
                                                .background(Color(.systemGray5))
                                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                        }
                                        if item.GsatEL >= 0 {
                                            switch item.GsatEL {
                                            case 3:
                                                Text("英聽 A")
                                                    .padding(5)
                                                    .background(Color(.systemGray5))
                                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                            case 2:
                                                Text("英聽 B")
                                                    .padding(5)
                                                    .background(Color(.systemGray5))
                                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                            case 1:
                                                Text("英聽 C")
                                                    .padding(5)
                                                    .background(Color(.systemGray5))
                                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                            default:
                                                Text("英聽 F")
                                                    .padding(5)
                                                    .background(Color(.systemGray5))
                                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                            }
                                        }
                                        if item.AstMA >= 0 {
                                            Text("數甲 \(item.AstMA)")
                                                .padding(5)
                                                .background(Color(.systemGray5))
                                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                        }
                                        if item.AstMB >= 0 {
                                            Text("數乙 \(item.AstMB)")
                                                .padding(5)
                                                .background(Color(.systemGray5))
                                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                        }
                                        if item.AstPH >= 0 {
                                            Text("物理 \(item.AstPH)")
                                                .padding(5)
                                                .background(Color(.systemGray5))
                                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                        }
                                        if item.AstCH >= 0 {
                                            Text("化學 \(item.AstCH)")
                                                .padding(5)
                                                .background(Color(.systemGray5))
                                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                        }
                                        if item.AstBI >= 0 {
                                            Text("生物 \(item.AstBI)")
                                                .padding(5)
                                                .background(Color(.systemGray5))
                                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                        }
                                        if item.AstHI >= 0 {
                                            Text("歷史 \(item.AstHI)")
                                                .padding(5)
                                                .background(Color(.systemGray5))
                                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                        }
                                        if item.AstGE >= 0 {
                                            Text("地理 \(item.AstGE)")
                                                .padding(5)
                                                .background(Color(.systemGray5))
                                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                        }
                                        if item.AstSO >= 0 {
                                            Text("公民 \(item.AstSO)")
                                                .padding(5)
                                                .background(Color(.systemGray5))
                                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                        }
                                    }
                                }
                                .scoreCard()
                                .padding(.horizontal)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.top, 10)
                }
                Spacer()
            }
        }
    }
    
}

#Preview {
    ResultView()
        .environmentObject(UserData())
}
