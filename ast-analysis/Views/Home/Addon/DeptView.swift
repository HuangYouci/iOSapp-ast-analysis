//
//  DeptView.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/6/4.
//

import SwiftUI
import Foundation

struct DeptView: View {
    
    let department: Departments
    
    var body: some View{
        
        VStack(spacing: 0){
            
            HStack{
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 1)
            
            VStack{
                VStack(alignment: .leading){
                    HStack{
                        VStack(alignment: .leading){
                            Text(department.schoolname)
                            Text(department.departmentname)
                                .font(.title2)
                                .bold()
                        }
                        Spacer()
                        Text(department.code)
                            .padding(5)
                            .background(Color(.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 5))
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
                    HStack(alignment: .center){
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                        Text("檢定標準")
                        Spacer()
                    }
                    .bold()
                    .padding(.bottom, 10)
                    if department.chinesetest.isEmpty && department.englishtest.isEmpty && department.mathatest.isEmpty && department.mathbtest.isEmpty && department.socialtest.isEmpty && department.sciencetest.isEmpty && department.englishlistentest.isEmpty {
                        Text("無檢定標準")
                    } else {
                        HStack{
                            VStack{
                                Text("科目")
                                Text("檢定")
                            }
                            .bold()
                            if !department.chinesetest.isEmpty {
                                VStack{
                                    Text("國文")
                                    Text(department.chinesetest)
                                }
                            }
                            if !department.englishtest.isEmpty {
                                VStack{
                                    Text("英文")
                                    Text(department.englishtest)
                                }
                            }
                            if !department.mathatest.isEmpty {
                                VStack{
                                    Text("數Ａ")
                                    Text(department.mathatest)
                                }
                            }
                            if !department.mathbtest.isEmpty {
                                VStack{
                                    Text("數Ｂ")
                                    Text(department.mathbtest)
                                }
                            }
                            if !department.sciencetest.isEmpty {
                                VStack{
                                    Text("自然")
                                    Text(department.sciencetest)
                                }
                            }
                            if !department.socialtest.isEmpty {
                                VStack{
                                    Text("社會")
                                    Text(department.socialtest)
                                }
                            }
                            if !department.englishlistentest.isEmpty {
                                VStack{
                                    Text("英聽")
                                    Text(department.englishlistentest)
                                }
                            }
                        }
                    }
                    
                }
                .padding()
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading){
                    HStack(alignment: .center){
                        Image(systemName: "line.3.horizontal.decrease")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                        Text("採計科目")
                        Spacer()
                    }
                    .bold()
                    .padding(.bottom, 10)
                    HStack{
                        Text("科目")
                        Spacer()
                        Text("倍率")
                            .frame(width: 50, alignment: .trailing)
                    }
                    .bold()
                    
                    scoreGenerator(name: "國文", multiplier: department.gsatchineseMultiplier)
                    
                    scoreGenerator(name: "英文", multiplier: department.gsatenglishMultiplier)
                    
                    scoreGenerator(name: "數Ａ", multiplier: department.gsatmathaMultiplier)
                    
                    scoreGenerator(name: "數Ｂ", multiplier: department.gsatmathbMultiplier)
                    
                    scoreGenerator(name: "自然", multiplier: department.gsatscienceMultiplier)
                    
                    scoreGenerator(name: "社會", multiplier: department.gsatsocialMultiplier)
                    
                    scoreGenerator(name: "數甲", multiplier: department.mathaMultiplier)
                    
                    scoreGenerator(name: "數乙", multiplier: department.mathbMultiplier)
                    
                    scoreGenerator(name: "物理", multiplier: department.physicsMultiplier)
                    
                    scoreGenerator(name: "化學", multiplier: department.chemistryMultiplier)
                    
                    scoreGenerator(name: "生物", multiplier: department.biologyMultiplier)
                    
                    scoreGenerator(name: "歷史", multiplier: department.historyMultiplier)
                    
                    scoreGenerator(name: "地理", multiplier: department.geometryMultiplier)
                    
                    scoreGenerator(name: "公民", multiplier: department.socialMultiplier)
                    
                }
                .padding()
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading){
                    HStack(alignment: .center){
                        Image(systemName: "document.badge.clock")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                        Text("篩選結果")
                        Spacer()
                    }
                    .bold()
                    .padding(.bottom, 10)
                    if department.resultCombineArray.isEmpty {
                        Text("無資料")
                            .foregroundStyle(Color(.systemGray2))
                    } else {
                        HStack{
                            VStack{
                                Text("科目")
                                Text("倍率")
                            }
                            .bold()
                            ForEach(department.resultCombineArray, id: \.0) { subject, score in
                                VStack{
                                    Text(subject)
                                    Text(String(format: "%.2f", score))
                                }
                            }
                        }
                        Divider()
                        HStack{
                            Text("最低錄取分數")
                            Spacer()
                            Text(String(format: "%.2f", Double(department.resultScore) ?? 1.0))
                        }
                        HStack{
                            Text("平均級分")
                            Spacer()
                            Text("÷")
                            Text(String(format: "%.2f", department.resultTotalMultiplier))
                                .frame(width: 50, alignment: .trailing)
                            Text("=")
                            Text(String(format: "%.2f", (Double(department.resultScore) ?? 1.0) / department.resultTotalMultiplier))
                                .frame(width: 60, alignment: .trailing)
                        }
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading){
                    HStack(alignment: .center){
                        Image(systemName: "person.crop.rectangle.stack")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                        Text("同分參酌")
                        Spacer()
                    }
                    .bold()
                    .padding(.bottom, 10)
                    HStack{
                        if !department.samecompare1.isEmpty {
                            Text(department.samecompare1)
                        }
                        if !department.samecompare2.isEmpty {
                            Text("→")
                            Text(department.samecompare2)
                        }
                        if !department.samecompare3.isEmpty {
                            Text("→")
                            Text(department.samecompare3)
                        }
                        if !department.samecompare4.isEmpty {
                            Text("→")
                            Text(department.samecompare4)
                        }
                        if !department.samecompare5.isEmpty {
                            Text("→")
                            Text(department.samecompare5)
                        }
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading){
                    HStack(alignment: .center){
                        Image(systemName: "document")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                        Text("資訊")
                        Spacer()
                    }
                    .bold()
                    .padding(.bottom, 10)
                    HStack{
                        if department.info.isEmpty {
                            Text("無資料")
                                .foregroundStyle(Color(.systemGray2))
                        } else {
                            Text(department.info)
                        }
                        Spacer()
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
            }
            .padding(.horizontal)
            .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
            .background(Color(.secondarySystemBackground))
            
        }
        .navigationTitle(department.fullname)
        .navigationBarTitleDisplayMode(.inline)
    }
                                 
    private func scoreGenerator(name: String, multiplier: Double) -> some View {
        if multiplier > 0 {
            AnyView(
                HStack{
                    Text(name)
                    Spacer()
                    Text(String(format: "%.2f", multiplier))
                }
                )
        } else {
            AnyView(EmptyView())
        }
    }
    
}

#Preview {
    DeptView(department: UserData.shared.userData.grade.first!.analyse[23])
}
