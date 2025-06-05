//
//  ResultDeptView.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/6/4.
//

import SwiftUI
import Foundation

struct ResultDeptView: View {
    
    let department: Departments
    @Binding var grade: UserGrade
    
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
                        Image(systemName: "medal.star")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                        Text("錄取機率")
                        Spacer()
                    }
                    .bold()
                    .padding(.bottom, 10)
                    
                    switch (department.calculatedType){
                    case .notCaluclated:
                        VStack(alignment: .leading){
                            Text("--%")
                                .font(.title3)
                                .bold()
                                .padding(.bottom, 5)
                            Text("系統尚未計算本科系的錄取機率。")
                                .font(.caption)
                                .foregroundStyle(Color(.systemGray2))
                        }
                    case .normal:
                        VStack(alignment: .leading){
                            Text(String(format: "%.0f%%", department.calculatedPercent * 100))
                                .font(.title3)
                                .bold()
                                .padding(.bottom, 5)
                            switch(department.calculatedPercent * 100){
                            case 80...100:
                                Text("保底")
                                    .font(.caption)
                                    .foregroundColor(Color(red: 0.1, green: 0.6, blue: 0.2))
                            case 60..<80:
                                Text("安全")
                                    .font(.caption)
                                    .foregroundColor(Color(.systemGreen))
                            case 40..<60:
                                Text("一般")
                                    .font(.caption)
                                    .foregroundColor(Color.accentColor)
                            case 20..<40:
                                Text("進攻")
                                    .font(.caption)
                                    .foregroundColor(Color(.red))
                            default:
                                Text("夢幻")
                                    .font(.caption)
                                    .foregroundColor(Color(.purple))
                            }
                        }
                    case .nopass:
                        VStack(alignment: .leading){
                            Text("0%")
                                .font(.title3)
                                .bold()
                                .padding(.bottom, 5)
                            Text("未通過本科系檢定（" + checkAvailablity().joined(separator: "、") + "）")
                                .font(.caption)
                                .foregroundStyle(Color(.systemGray2))
                        }
                    case .nodata:
                        VStack(alignment: .leading){
                            Text("--%")
                                .font(.title3)
                                .bold()
                                .padding(.bottom, 5)
                            Text("沒有去年的錄取分數，因此無法計算。")
                                .font(.caption)
                                .foregroundStyle(Color(.systemGray2))
                        }
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading){
                    HStack(alignment: .center){
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                        Text("檢定標準")
                        Spacer()
                        if checkAllTestsPassed(SO: grade.GsatSO, goalSO: department.socialtest, SC: grade.GsatSC, goalSC: department.sciencetest, MB: grade.GsatMB, goalMB: department.mathbtest, MA: grade.GsatMA, goalMA: department.mathatest, EN: grade.GsatEN, goalEN: department.englishtest, CH: grade.GsatCH, goalCH: department.chinesetest, EL: grade.GsatEL, goalEL: department.englishlistentest) {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundStyle(Color(.green))
                            Text("檢定通過")
                        }
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
                                Text("你的")
                            }
                            .bold()
                            if !department.chinesetest.isEmpty {
                                VStack{
                                    Text("國文")
                                    Text(department.chinesetest)
                                    Text(turnToTestString(mine: grade.GsatCH, type: 0))
                                        .foregroundStyle(Color(checkTestPassed(you: grade.GsatCH, type: 0, goal: department.chinesetest) ? .green : .red))
                                }
                            }
                            if !department.englishtest.isEmpty {
                                VStack{
                                    Text("英文")
                                    Text(department.englishtest)
                                    Text(turnToTestString(mine: grade.GsatEN, type: 1))
                                        .foregroundStyle(Color(checkTestPassed(you: grade.GsatEN, type: 1, goal: department.englishtest) ? .green : .red))
                                }
                            }
                            if !department.mathatest.isEmpty {
                                VStack{
                                    Text("數Ａ")
                                    Text(department.mathatest)
                                    Text(turnToTestString(mine: grade.GsatMA, type: 2))
                                        .foregroundStyle(Color(checkTestPassed(you: grade.GsatMA, type: 2, goal: department.mathatest) ? .green : .red))
                                }
                            }
                            if !department.mathbtest.isEmpty {
                                VStack{
                                    Text("數Ｂ")
                                    Text(department.mathbtest)
                                    Text(turnToTestString(mine: grade.GsatMB, type: 3))
                                        .foregroundStyle(Color(checkTestPassed(you: grade.GsatMB, type: 3, goal: department.mathbtest) ? .green : .red))
                                }
                            }
                            if !department.sciencetest.isEmpty {
                                VStack{
                                    Text("自然")
                                    Text(department.sciencetest)
                                    Text(turnToTestString(mine: grade.GsatSC, type: 4))
                                        .foregroundStyle(Color(checkTestPassed(you: grade.GsatSC, type: 4, goal: department.sciencetest) ? .green : .red))
                                }
                            }
                            if !department.socialtest.isEmpty {
                                VStack{
                                    Text("社會")
                                    Text(department.socialtest)
                                    Text(turnToTestString(mine: grade.GsatSO, type: 5))
                                        .foregroundStyle(Color(checkTestPassed(you: grade.GsatSO, type: 5, goal: department.socialtest) ? .green : .red))
                                }
                            }
                            if !department.englishlistentest.isEmpty {
                                VStack{
                                    Text("英聽")
                                    Text(department.englishlistentest)
                                    switch grade.GsatEL {
                                    case 3:
                                        Text("A級")
                                            .foregroundStyle(Color(.green))
                                    case 2:
                                        Text("B級")
                                            .foregroundStyle(Color( department.englishlistentest == "A級" ? .red : .green))
                                    case 1:
                                        Text("C級")
                                            .foregroundStyle(Color( department.englishlistentest == "A級" || department.englishlistentest == "B級" ? .red : .green))
                                    default:
                                        Text("F級")
                                            .foregroundStyle(Color(.red))
                                    }
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
                        Text("原始")
                            .frame(width: 50, alignment: .trailing)
                        Text("×")
                        Text("倍率")
                            .frame(width: 50, alignment: .trailing)
                        Text("=")
                        Text("成績")
                            .frame(width: 60, alignment: .trailing)
                    }
                    .bold()
                    
                    scoreGenerator(name: "國文", score: grade.GsatCH, multiplier: department.gsatchineseMultiplier)
                    
                    scoreGenerator(name: "英文", score: grade.GsatEN, multiplier: department.gsatenglishMultiplier)
                    
                    scoreGenerator(name: "數Ａ", score: grade.GsatMA, multiplier: department.gsatmathaMultiplier)
                    
                    scoreGenerator(name: "數Ｂ", score: grade.GsatMB, multiplier: department.gsatmathbMultiplier)
                    
                    scoreGenerator(name: "自然", score: grade.GsatSC, multiplier: department.gsatscienceMultiplier)
                    
                    scoreGenerator(name: "社會", score: grade.GsatSO, multiplier: department.gsatsocialMultiplier)
                    
                    scoreGenerator(name: "數甲", score: grade.AstMA, multiplier: department.mathaMultiplier)
                    
                    scoreGenerator(name: "數乙", score: grade.AstMB, multiplier: department.mathbMultiplier)
                    
                    scoreGenerator(name: "物理", score: grade.AstPH, multiplier: department.physicsMultiplier)
                    
                    scoreGenerator(name: "化學", score: grade.AstCH, multiplier: department.chemistryMultiplier)
                    
                    scoreGenerator(name: "生物", score: grade.AstBI, multiplier: department.biologyMultiplier)
                    
                    scoreGenerator(name: "歷史", score: grade.AstHI, multiplier: department.historyMultiplier)
                    
                    scoreGenerator(name: "地理", score: grade.AstGE, multiplier: department.geometryMultiplier)
                    
                    scoreGenerator(name: "公民", score: grade.AstSO, multiplier: department.socialMultiplier)
                    
                    Divider()
                    
                    HStack{
                        Text("總成績")
                        Spacer()
                        Text(String(format: "%.2f", totalScore()))
                    }
                    
                    HStack{
                        Text("平均級分")
                        Spacer()
                        Text("÷")
                        Text(String(format: "%.2f", totalMultiplier()))
                            .frame(width: 50, alignment: .trailing)
                        Text("=")
                        Text(String(format: "%.2f", totalScore() / totalMultiplier()))
                            .frame(width: 60, alignment: .trailing)
                    }
                    
                    if grade.SpecialPercentage > 0 {
                        Divider()
                        HStack{
                            Text("加分總成績")
                            Spacer()
                            Text(String(format: "%.2f", totalScore()))
                            Text("×")
                            Text(String(format: "%.2f", (Double(grade.SpecialPercentage)/100)+1))
                                .frame(width: 50, alignment: .trailing)
                            Text("=")
                            Text(String(format: "%.2f", totalScoreAfterBonus()))
                                .frame(width: 60, alignment: .trailing)
                        }
                        HStack{
                            Text("加分平均級分")
                            Spacer()
                            Text("÷")
                            Text(String(format: "%.2f", department.resultTotalMultiplier))
                                .frame(width: 50, alignment: .trailing)
                            Text("=")
                            Text(String(format: "%.2f", totalScoreAfterBonus() / totalMultiplier()))
                                .frame(width: 60, alignment: .trailing)
                        }
                    }
                    
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
                        Image(systemName: "ruler")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                        Text("差距計算")
                        Spacer()
                    }
                    .bold()
                    .padding(.bottom, 10)
                    
                    if let resultScoreValue = Double(department.resultScore) {
                        let resultScoreAverage = resultScoreValue / department.resultTotalMultiplier
                        let resultScoreToNow = resultScoreAverage * totalMultiplier() // 去年分數轉換今年總分
                        let scoreDiff = resultScoreToNow - totalScore() // 差距總分
                        let scoreAverageDiff = scoreDiff / totalMultiplier() // 差距平均
                        
                        HStack{
                            Text("你的分數")
                            Spacer()
                            Text(String(format: "%.2f", totalScore()))
                            Text(String(format: "(%.2f)", totalScore()/totalMultiplier()))
                        }
                        HStack{
                            Text("目標分數")
                            if(resultScoreToNow != resultScoreValue){
                                Text("（經轉換）")
                            }
                            Spacer()
                            Text(String(format: "%.2f", resultScoreToNow))
                            Text(String(format: "(%.2f)", resultScoreToNow/totalMultiplier()))
                        }
                        Divider()
                        
                        if scoreDiff > 0 {
                            HStack {
                                Text("低於去年最低錄取分數")
                                Spacer()
                                Text(String(format: "%.2f", scoreDiff))
                                Text(String(format: "(%.2f)", scoreAverageDiff))
                            }
                        } else {
                            HStack {
                                Text("高於去年最低錄取分數")
                                Spacer()
                                Text(String(format: "%.2f", -scoreDiff))
                                Text(String(format: "(%.2f)", -scoreAverageDiff))
                            }
                        }
                        
                    } else {
                        HStack {
                            Text("無去年最低錄取分數資料")
                            Spacer()
                            Text("N/A")
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
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                Group {
                    if grade.favDept.contains(department.code){
                        Button {
                            grade.favDept.removeAll(where: { $0 == department.code })
                        } label: {
                            Image(systemName: "heart.fill")
                        }
                    } else {
                        Button {
                            grade.favDept.append(department.code)
                        } label: {
                            Image(systemName: "heart")
                        }
                    }
                }
            }
        }
    }
                                 
    private func scoreGenerator(name: String, score: Int, multiplier: Double) -> some View {
        if multiplier > 0 {
            AnyView(
                HStack{
                    Text(name)
                    Spacer()
                    Text("\(score)")
                    Text("×")
                    Text(String(format: "%.2f", multiplier))
                        .frame(width: 50, alignment: .trailing)
                    Text("=")
                    Text(String(format: "%.2f", Double(score) * multiplier))
                        .frame(width: 60, alignment: .trailing)
                }
                )
        } else {
            AnyView(EmptyView())
        }
    }
    
    private func turnToTestString(mine: Int, type: Int) -> String {
        
        // type: 0 國文 1 英文 2 數Ａ 3 數Ｂ 4 自然 5 社會
        switch type {
        case 5:
            if mine > LevelConstants.SOLevel1 {
                return "頂標"
            } else if mine > LevelConstants.SOLevel2 {
                return "前標"
            } else if mine > LevelConstants.SOLevel3 {
                return "均標"
            } else if mine > LevelConstants.SOLevel4 {
                return "後標"
            } else if mine > LevelConstants.SOLevel5 {
                return "底標"
            } else if mine > -1 {
                return "流標"
            } else {
                return "未考"
            }
        case 4:
            if mine > LevelConstants.SCLevel1 {
                return "頂標"
            } else if mine > LevelConstants.SCLevel2 {
                return "前標"
            } else if mine > LevelConstants.SCLevel3 {
                return "均標"
            } else if mine > LevelConstants.SCLevel4 {
                return "後標"
            } else if mine > LevelConstants.SCLevel5 {
                return "底標"
            } else if mine > -1 {
                return "流標"
            } else {
                return "未考"
            }
        case 3:
            if mine > LevelConstants.MBLevel1 {
                return "頂標"
            } else if mine > LevelConstants.MBLevel2 {
                return "前標"
            } else if mine > LevelConstants.MBLevel3 {
                return "均標"
            } else if mine > LevelConstants.MBLevel4 {
                return "後標"
            } else if mine > LevelConstants.MBLevel5 {
                return "底標"
            } else if mine > -1 {
                return "流標"
            } else {
                return "未考"
            }
        case 2:
            if mine > LevelConstants.MALevel1 {
                return "頂標"
            } else if mine > LevelConstants.MALevel2 {
                return "前標"
            } else if mine > LevelConstants.MALevel3 {
                return "均標"
            } else if mine > LevelConstants.MALevel4 {
                return "後標"
            } else if mine > LevelConstants.MALevel5 {
                return "底標"
            } else if mine > -1 {
                return "流標"
            } else {
                return "未考"
            }
        case 1:
            if mine > LevelConstants.ENLevel1 {
                return "頂標"
            } else if mine > LevelConstants.ENLevel2 {
                return "前標"
            } else if mine > LevelConstants.ENLevel3 {
                return "均標"
            } else if mine > LevelConstants.ENLevel4 {
                return "後標"
            } else if mine > LevelConstants.ENLevel5 {
                return "底標"
            } else if mine > -1 {
                return "流標"
            } else {
                return "未考"
            }
        default:
            if mine > LevelConstants.CHLevel1 {
                return "頂標"
            } else if mine > LevelConstants.CHLevel2 {
                return "前標"
            } else if mine > LevelConstants.CHLevel3 {
                return "均標"
            } else if mine > LevelConstants.CHLevel4 {
                return "後標"
            } else if mine > LevelConstants.CHLevel5 {
                return "底標"
            } else if mine > -1 {
                return "流標"
            } else {
                return "未考"
            }
        }
        
    }
    
    private func checkTestPassed(you: Int, type: Int, goal: String) -> Bool {
        // type: 0 國文 1 英文 2 數Ａ 3 數Ｂ 4 自然 5 社會
        var mine: Int = 0
        switch type {
        case 5:
            switch goal {
            case "頂標":
                mine = LevelConstants.SOLevel1
            case "前標":
                mine = LevelConstants.SOLevel2
            case "均標":
                mine = LevelConstants.SOLevel3
            case "後標":
                mine = LevelConstants.SOLevel4
            case "底標":
                mine = LevelConstants.SOLevel5
            default:
                mine = -2
            }
        case 4:
            switch goal {
            case "頂標":
                mine = LevelConstants.SCLevel1
            case "前標":
                mine = LevelConstants.SCLevel2
            case "均標":
                mine = LevelConstants.SCLevel3
            case "後標":
                mine = LevelConstants.SCLevel4
            case "底標":
                mine = LevelConstants.SCLevel5
            default:
                mine = -2
            }
        case 3:
            switch goal {
            case "頂標":
                mine = LevelConstants.MBLevel1
            case "前標":
                mine = LevelConstants.MBLevel2
            case "均標":
                mine = LevelConstants.MBLevel3
            case "後標":
                mine = LevelConstants.MBLevel4
            case "底標":
                mine = LevelConstants.MBLevel5
            default:
                mine = -2
            }
        case 2:
            switch goal {
            case "頂標":
                mine = LevelConstants.MALevel1
            case "前標":
                mine = LevelConstants.MALevel2
            case "均標":
                mine = LevelConstants.MALevel3
            case "後標":
                mine = LevelConstants.MALevel4
            case "底標":
                mine = LevelConstants.MALevel5
            default:
                mine = -2
            }
        case 1:
            switch goal {
            case "頂標":
                mine = LevelConstants.ENLevel1
            case "前標":
                mine = LevelConstants.ENLevel2
            case "均標":
                mine = LevelConstants.ENLevel3
            case "後標":
                mine = LevelConstants.ENLevel4
            case "底標":
                mine = LevelConstants.ENLevel5
            default:
                mine = -2
            }
        default:
            switch goal {
            case "頂標":
                mine = LevelConstants.CHLevel1
            case "前標":
                mine = LevelConstants.CHLevel2
            case "均標":
                mine = LevelConstants.CHLevel3
            case "後標":
                mine = LevelConstants.CHLevel4
            case "底標":
                mine = LevelConstants.CHLevel5
            default:
                mine = -2
            }
        }
        return you > mine
    }
    
    private func checkAllTestsPassed(SO: Int, goalSO: String,
                                    SC: Int, goalSC: String,
                                    MB: Int, goalMB: String,
                                    MA: Int, goalMA: String,
                                    EN: Int, goalEN: String,
                                    CH: Int, goalCH: String,
                                     EL: Int, goalEL: String) -> Bool {
        // type: 0 國文 1 英文 2 數Ａ 3 數Ｂ 4 自然 5 社會
        
        // 檢查每個科目的成績是否通過指定的 goal
        let passedCH = checkTestPassed(you: CH, type: 0, goal: goalCH) // 國文
        let passedEN = checkTestPassed(you: EN, type: 1, goal: goalEN) // 英文
        let passedMA = checkTestPassed(you: MA, type: 2, goal: goalMA) // 數A
        let passedMB = checkTestPassed(you: MB, type: 3, goal: goalMB) // 數B
        let passedSC = checkTestPassed(you: SC, type: 4, goal: goalSC) // 自然
        let passedSO = checkTestPassed(you: SO, type: 5, goal: goalSO) // 社會
        var passedEL = true
        
        if ((goalEL == "A級") && (EL != 3)) { passedEL = false }
        if ((goalEL == "B級") && (EL == 0 || EL == 1)) { passedEL = false }
        if ((goalEL == "C級") && (EL == 0)) { passedEL = false }
        
        // MB 和 MA 只需其中一個通過
        let passedMath = passedMA || passedMB
        
        // 所有科目都需通過（數學只需 MA 或 MB 其中一個通過）
        return passedCH && passedEN && passedMath && passedSC && passedSO && passedEL
    }
    
    private func totalScore() -> Double {
        return (department.gsatchineseMultiplier * Double(grade.GsatCH) + department.gsatenglishMultiplier * Double(grade.GsatEN) + department.gsatmathaMultiplier * Double(grade.GsatMA) + department.gsatmathbMultiplier * Double(grade.GsatMB) + department.gsatscienceMultiplier * Double(grade.GsatSC) + department.gsatsocialMultiplier * Double(grade.GsatSO) + department.mathaMultiplier * Double(grade.AstMA) + department.mathbMultiplier * Double(grade.AstMB) + department.physicsMultiplier * Double(grade.AstPH) + department.chemistryMultiplier * Double(grade.AstCH) + department.biologyMultiplier * Double(grade.AstBI) + department.historyMultiplier * Double(grade.AstHI) + department.geometryMultiplier * Double(grade.AstGE) + department.socialMultiplier * Double(grade.AstSO))
    }
    
    private func totalScoreAfterBonus() -> Double {
        // 1. 加權後的各科分數總和 (Weighted Sum of Scores)
        // 這部分的計算邏輯不變，因為乘以0倍率的科目自然不會貢獻分數
        let weightedSumOfScores = (
            department.gsatchineseMultiplier * Double(grade.GsatCH) +
            department.gsatenglishMultiplier * Double(grade.GsatEN) +
            department.gsatmathaMultiplier * Double(grade.GsatMA) +
            department.gsatmathbMultiplier * Double(grade.GsatMB) +
            department.gsatscienceMultiplier * Double(grade.GsatSC) +
            department.gsatsocialMultiplier * Double(grade.GsatSO) +
            department.mathaMultiplier * Double(grade.AstMA) +
            department.mathbMultiplier * Double(grade.AstMB) +
            department.physicsMultiplier * Double(grade.AstPH) +
            department.chemistryMultiplier * Double(grade.AstCH) +
            department.biologyMultiplier * Double(grade.AstBI) +
            department.historyMultiplier * Double(grade.AstHI) +
            department.geometryMultiplier * Double(grade.AstGE) +
            department.socialMultiplier * Double(grade.AstSO)
        )

        // 2. 計算用於加分的 "原始分數總和" (Raw Sum of Scores for Bonus Calculation)
        // 只有當該科目的倍率 > 0 時，才將其原始分數（算1倍）加入此總和
        var rawSumOfScoresForBonus: Double = 0.0

        if department.gsatchineseMultiplier > 0 {
            rawSumOfScoresForBonus += Double(grade.GsatCH)
        }
        if department.gsatenglishMultiplier > 0 {
            rawSumOfScoresForBonus += Double(grade.GsatEN)
        }
        if department.gsatmathaMultiplier > 0 {
            rawSumOfScoresForBonus += Double(grade.GsatMA)
        }
        if department.gsatmathbMultiplier > 0 {
            rawSumOfScoresForBonus += Double(grade.GsatMB)
        }
        if department.gsatscienceMultiplier > 0 {
            rawSumOfScoresForBonus += Double(grade.GsatSC)
        }
        if department.gsatsocialMultiplier > 0 {
            rawSumOfScoresForBonus += Double(grade.GsatSO)
        }
        if department.mathaMultiplier > 0 {
            rawSumOfScoresForBonus += Double(grade.AstMA)
        }
        if department.mathbMultiplier > 0 {
            rawSumOfScoresForBonus += Double(grade.AstMB)
        }
        if department.physicsMultiplier > 0 {
            rawSumOfScoresForBonus += Double(grade.AstPH)
        }
        if department.chemistryMultiplier > 0 {
            rawSumOfScoresForBonus += Double(grade.AstCH)
        }
        if department.biologyMultiplier > 0 {
            rawSumOfScoresForBonus += Double(grade.AstBI)
        }
        if department.historyMultiplier > 0 {
            rawSumOfScoresForBonus += Double(grade.AstHI)
        }
        if department.geometryMultiplier > 0 {
            rawSumOfScoresForBonus += Double(grade.AstGE)
        }
        if department.socialMultiplier > 0 {
            rawSumOfScoresForBonus += Double(grade.AstSO)
        }

        // 3. 加分百分比 (Bonus Percentage as a factor)
        // grade.SpecialPercentage 是 Int, 例如 25 代表 25%
        let bonusFactor = Double(grade.SpecialPercentage) / 100.0 // 將 25 轉換為 0.25

        // 4. 加分量 (Bonus Value based on the filtered raw scores)
        let bonusValue = rawSumOfScoresForBonus * bonusFactor

        // 5. 加分後的總分 (Weighted Sum of Scores + Bonus Value)
        let finalScoreAfterBonus = weightedSumOfScores + bonusValue

        return finalScoreAfterBonus
    }
    
    private func totalMultiplier() -> Double {
        return (department.gsatchineseMultiplier + department.gsatenglishMultiplier + department.gsatmathaMultiplier + department.gsatmathbMultiplier + department.gsatscienceMultiplier + department.gsatsocialMultiplier + department.mathaMultiplier + department.mathbMultiplier + department.physicsMultiplier + department.chemistryMultiplier + department.biologyMultiplier + department.historyMultiplier + department.geometryMultiplier + department.socialMultiplier)
    }
    
    private func checkAvailablity() -> [String] {
        var reason: [String] = []
        // 檢定
        switch department.chinesetest {
        case "頂標":
            if grade.GsatCH <= LevelConstants.CHLevel1 {
                reason.append("國文未達頂標")
            }
        case "前標":
            if grade.GsatCH <= LevelConstants.CHLevel2 {
                reason.append("國文未達前標")
            }
        case "均標":
            if grade.GsatCH <= LevelConstants.CHLevel3 {
                reason.append("國文未達均標")
            }
        case "後標":
            if grade.GsatCH <= LevelConstants.CHLevel4 {
                reason.append("國文未達後標")
            }
        case "底標":
            if grade.GsatCH <= LevelConstants.CHLevel5 {
                reason.append("國文未達底標")
            }
        default:
            break
        }
        switch department.englishtest {
        case "頂標":
            if grade.GsatEN <= LevelConstants.ENLevel1 {
                reason.append("英文未達頂標")
            }
        case "前標":
            if grade.GsatEN <= LevelConstants.ENLevel2 {
                reason.append("英文未達前標")
            }
        case "均標":
            if grade.GsatEN <= LevelConstants.ENLevel3 {
                reason.append("英文未達均標")
            }
        case "後標":
            if grade.GsatEN <= LevelConstants.ENLevel4 {
                reason.append("英文未達後標")
            }
        case "底標":
            if grade.GsatEN <= LevelConstants.ENLevel5 {
                reason.append("英文未達底標")
            }
        default:
            break
        }
        switch department.mathatest {
        case "頂標":
            if grade.GsatMA <= LevelConstants.MALevel1 {
                reason.append("數Ａ未達頂標")
            }
        case "前標":
            if grade.GsatMA <= LevelConstants.MALevel2 {
                reason.append("數Ａ未達前標")
            }
        case "均標":
            if grade.GsatMA <= LevelConstants.MALevel3 {
                reason.append("數Ａ未達均標")
            }
        case "後標":
            if grade.GsatMA <= LevelConstants.MALevel4 {
                reason.append("數Ａ未達後標")
            }
        case "底標":
            if grade.GsatMA <= LevelConstants.MALevel5 {
                reason.append("數Ａ未達底標")
            }
        default:
            break
        }
        switch department.mathbtest {
        case "頂標":
            if grade.GsatMB <= LevelConstants.MBLevel1 {
                reason.append("數Ｂ未達頂標")
            }
        case "前標":
            if grade.GsatMB <= LevelConstants.MBLevel2 {
                reason.append("數Ｂ未達前標")
            }
        case "均標":
            if grade.GsatMB <= LevelConstants.MBLevel3 {
                reason.append("數Ｂ未達均標")
            }
        case "後標":
            if grade.GsatMB <= LevelConstants.MBLevel4 {
                reason.append("數Ｂ未達後標")
            }
        case "底標":
            if grade.GsatMB <= LevelConstants.MBLevel5 {
                reason.append("數Ｂ未達底標")
            }
        default:
            break
        }
        switch department.sciencetest {
        case "頂標":
            if grade.GsatSC <= LevelConstants.SCLevel1 {
                reason.append("自然未達頂標")
            }
        case "前標":
            if grade.GsatSC <= LevelConstants.SCLevel2 {
                reason.append("自然未達前標")
            }
        case "均標":
            if grade.GsatSC <= LevelConstants.SCLevel3 {
                reason.append("自然未達均標")
            }
        case "後標":
            if grade.GsatSC <= LevelConstants.SCLevel4 {
                reason.append("自然未達後標")
            }
        case "底標":
            if grade.GsatSC <= LevelConstants.SCLevel5 {
                reason.append("自然未達底標")
            }
        default:
            break
        }
        switch department.socialtest {
        case "頂標":
            if grade.GsatSO <= LevelConstants.SOLevel1 {
                reason.append("社會未達頂標")
            }
        case "前標":
            if grade.GsatSO <= LevelConstants.SOLevel2 {
                reason.append("社會未達前標")
            }
        case "均標":
            if grade.GsatSO <= LevelConstants.SOLevel3 {
                reason.append("社會未達均標")
            }
        case "後標":
            if grade.GsatSO <= LevelConstants.SOLevel4 {
                reason.append("社會未達後標")
            }
        case "底標":
            if grade.GsatSO <= LevelConstants.SOLevel5 {
                reason.append("社會未達底標")
            }
        default:
            break
        }
        switch grade.GsatEL {
        case 3: // A級
            break
        case 2: // B級
            if (department.englishlistentest == "A級"){
                reason.append("英聽未達A級")
            }
        case 1: // C級
            if (department.englishlistentest == "A級"){
                reason.append("英聽未達A級")
            } else if ( department.englishlistentest == "B級" ) {
                reason.append("英聽未達B級")
            }
        default: // F級或其他
            if (department.englishlistentest == "A級"){
                reason.append("英聽未達A級")
            } else if ( department.englishlistentest == "B級" ) {
                reason.append("英聽未達B級")
            } else if ( department.englishlistentest == "C級" ) {
                reason.append("英聽未達C級")
            }
        }
        
        // 考試
        if department.gsatchineseMultiplier > 0 && grade.GsatCH < 0 {
            reason.append("未報考國文")
        }
        if department.gsatenglishMultiplier > 0 && grade.GsatEN < 0 {
            reason.append("未報考英文")
        }
        if department.gsatmathaMultiplier > 0 && grade.GsatMA < 0 {
            reason.append("未報考數Ａ")
        }
        if department.gsatmathbMultiplier > 0 && grade.GsatMB < 0 {
            reason.append("未報考數Ｂ")
        }
        if department.gsatscienceMultiplier > 0 && grade.GsatSC < 0 {
            reason.append("未報考自然")
        }
        if department.gsatsocialMultiplier > 0 && grade.GsatSO < 0 {
            reason.append("未報考社會")
        }
        // 分科測驗科目
        if department.mathaMultiplier > 0 && grade.AstMA < 0 {
            reason.append("未報考數甲")
        }
        if department.mathbMultiplier > 0 && grade.AstMB < 0 {
            reason.append("未報考數乙")
        }
        if department.physicsMultiplier > 0 && grade.AstPH < 0 {
            reason.append("未報考物理")
        }
        if department.chemistryMultiplier > 0 && grade.AstCH < 0 {
            reason.append("未報考化學")
        }
        if department.biologyMultiplier > 0 && grade.AstBI < 0 {
            reason.append("未報考生物")
        }
        if department.historyMultiplier > 0 && grade.AstHI < 0 {
            reason.append("未報考歷史")
        }
        if department.geometryMultiplier > 0 && grade.AstGE < 0 {
            reason.append("未報考地理")
        }
        if department.socialMultiplier > 0 && grade.AstSO < 0 {
            reason.append("未報考公民")
        }
        
        return reason
        
    }

}

#Preview {
    ResultDeptView(
        department: UserData.shared.userData.grade.first!.analyse[23],
        grade: .constant(UserData.shared.userData.grade.first!)
    )
}
