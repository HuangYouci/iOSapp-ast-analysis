//
//  DepartmentDetailView.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/3/21.
//

import SwiftUI

struct DepartmentDetailView: View {
    
    @EnvironmentObject private var departmentData: DepartmentData
    
    let department: Departments
    let grade: UserGrade
    
    var displayMore: Bool {
        return grade.id != UUID(uuidString: "00000000-0000-0000-0000-000000000000")!
    }
    
    var body: some View{
        
        VStack{
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
            Divider()
            ScrollView{
                VStack(alignment: .leading){
                    HStack(alignment: .center){
                        Image(systemName: "magnifyingglass")
                        Text("檢定標準")
                        Spacer()
                        if checkAllTestsPassed(SO: grade.GsatSO, goalSO: department.socialtest, SC: grade.GsatSC, goalSC: department.sciencetest, MB: grade.GsatMB, goalMB: department.mathbtest, MA: grade.GsatMA, goalMA: department.mathatest, EN: grade.GsatEN, goalEN: department.englishtest, CH: grade.GsatCH, goalCH: department.chinesetest) {
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
                                if displayMore {
                                    Text("你的")
                                }
                            }
                            .bold()
                            if !department.chinesetest.isEmpty {
                                VStack{
                                    Text("國文")
                                    Text(department.chinesetest)
                                    if displayMore {
                                        Text(turnToTestString(mine: grade.GsatCH, type: 0))
                                            .foregroundStyle(Color(checkTestPassed(you: grade.GsatCH, type: 0, goal: department.chinesetest) ? .green : .red))
                                    }
                                }
                            }
                            if !department.englishtest.isEmpty {
                                VStack{
                                    Text("英文")
                                    Text(department.englishtest)
                                    if displayMore {
                                        Text(turnToTestString(mine: grade.GsatEN, type: 1))
                                            .foregroundStyle(Color(checkTestPassed(you: grade.GsatEN, type: 1, goal: department.englishtest) ? .green : .red))
                                    }
                                }
                            }
                            if !department.mathatest.isEmpty {
                                VStack{
                                    Text("數Ａ")
                                    Text(department.mathatest)
                                    if displayMore {
                                        Text(turnToTestString(mine: grade.GsatMA, type: 2))
                                            .foregroundStyle(Color(checkTestPassed(you: grade.GsatMA, type: 2, goal: department.mathatest) ? .green : .red))
                                    }
                                }
                            }
                            if !department.mathbtest.isEmpty {
                                VStack{
                                    Text("數Ｂ")
                                    Text(department.mathbtest)
                                    if displayMore {
                                        Text(turnToTestString(mine: grade.GsatMB, type: 3))
                                            .foregroundStyle(Color(checkTestPassed(you: grade.GsatMB, type: 3, goal: department.mathbtest) ? .green : .red))
                                    }
                                }
                            }
                            if !department.sciencetest.isEmpty {
                                VStack{
                                    Text("自然")
                                    Text(department.sciencetest)
                                    if displayMore {
                                        Text(turnToTestString(mine: grade.GsatSC, type: 4))
                                            .foregroundStyle(Color(checkTestPassed(you: grade.GsatSC, type: 4, goal: department.sciencetest) ? .green : .red))
                                    }
                                }
                            }
                            if !department.socialtest.isEmpty {
                                VStack{
                                    Text("社會")
                                    Text(department.socialtest)
                                    if displayMore {
                                        Text(turnToTestString(mine: grade.GsatSO, type: 5))
                                            .foregroundStyle(Color(checkTestPassed(you: grade.GsatSO, type: 5, goal: department.socialtest) ? .green : .red))
                                    }
                                }
                            }
                            if !department.englishlistentest.isEmpty {
                                VStack{
                                    Text("英聽")
                                    Text(department.englishlistentest)
                                    if displayMore {
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
                    
                }
                .padding()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading){
                    HStack(alignment: .center){
                        Image(systemName: "line.3.horizontal.decrease")
                        Text("採計科目")
                        Spacer()
                    }
                    .bold()
                    .padding(.bottom, 10)
                    HStack{
                        Text("科目")
                        Spacer()
                        if displayMore {
                            Text("原始")
                                .frame(width: 50, alignment: .trailing)
                            Text("×")
                        }
                        Text("倍率")
                            .frame(width: 50, alignment: .trailing)
                        if displayMore {
                            Text("=")
                            Text("成績")
                                .frame(width: 60, alignment: .trailing)
                        }
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
                    
                    if displayMore {
                        
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
                                Text("加分")
                                Spacer()
                                Text(String(format: "%.2f", totalScore()))
                                Text("×")
                                Text(String(format: "%.2f", (Double(grade.SpecialPercentage)/100)+1))
                                    .frame(width: 50, alignment: .trailing)
                                Text("=")
                                Text(String(format: "%.2f", totalScore() * ( (Double(grade.SpecialPercentage)/100)+1 ) ))
                                    .frame(width: 60, alignment: .trailing)
                            }
                        }
                        
                    }
                    
                }
                .padding()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading){
                    HStack(alignment: .center){
                        Image(systemName: "person.crop.rectangle.stack")
                        Text("同分參酌")
                        Spacer()
                    }
                    .bold()
                    .padding(.bottom, 10)
                    HStack{
                        if !department.samecompare1.isEmpty {
                            VStack{
                                Text(department.samecompare1)
                            }
                        }
                        if !department.samecompare2.isEmpty {
                            Image(systemName: "arrow.right")
                            VStack{
                                Text(department.samecompare2)
                            }
                        }
                        if !department.samecompare3.isEmpty {
                            Image(systemName: "arrow.right")
                            VStack{
                                Text(department.samecompare3)
                            }
                        }
                        if !department.samecompare4.isEmpty {
                            Image(systemName: "arrow.right")
                            VStack{
                                Text(department.samecompare4)
                            }
                        }
                        if !department.samecompare5.isEmpty {
                            Image(systemName: "arrow.right")
                            VStack{
                                Text(department.samecompare5)
                            }
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading){
                    HStack(alignment: .center){
                        Image(systemName: "document")
                        Text("資訊")
                        Spacer()
                    }
                    .bold()
                    .padding(.bottom, 10)
                    HStack{
                        Text(department.info)
                        Spacer()
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .padding(20)
        .navigationTitle(department.fullname)
        
    }
                                 
    private func scoreGenerator(name: String, score: Int, multiplier: Double) -> some View {
        if multiplier > 0 {
            AnyView(
                HStack{
                    Text(name)
                    Spacer()
                    if displayMore {
                        Text("\(score)")
                        Text("×")
                    }
                    Text(String(format: "%.2f", multiplier))
                        .frame(width: 50, alignment: .trailing)
                    if displayMore {
                        Text("=")
                        Text(String(format: "%.2f", Double(score) * multiplier))
                            .frame(width: 60, alignment: .trailing)
                    }
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
                mine = -1
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
                mine = -1
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
                mine = -1
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
                mine = -1
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
                mine = -1
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
                mine = -1
            }
        }
        return you >= mine
    }
    
    private func checkAllTestsPassed(SO: Int, goalSO: String,
                                    SC: Int, goalSC: String,
                                    MB: Int, goalMB: String,
                                    MA: Int, goalMA: String,
                                    EN: Int, goalEN: String,
                                    CH: Int, goalCH: String) -> Bool {
        // type: 0 國文 1 英文 2 數Ａ 3 數Ｂ 4 自然 5 社會
        
        // 檢查每個科目的成績是否通過指定的 goal
        let passedCH = checkTestPassed(you: CH, type: 0, goal: goalCH) // 國文
        let passedEN = checkTestPassed(you: EN, type: 1, goal: goalEN) // 英文
        let passedMA = checkTestPassed(you: MA, type: 2, goal: goalMA) // 數A
        let passedMB = checkTestPassed(you: MB, type: 3, goal: goalMB) // 數B
        let passedSC = checkTestPassed(you: SC, type: 4, goal: goalSC) // 自然
        let passedSO = checkTestPassed(you: SO, type: 5, goal: goalSO) // 社會
        
        // MB 和 MA 只需其中一個通過
        let passedMath = passedMA || passedMB
        
        // 所有科目都需通過（數學只需 MA 或 MB 其中一個通過）
        return passedCH && passedEN && passedMath && passedSC && passedSO
    }
    
    private func totalScore() -> Double {
        return (department.gsatchineseMultiplier * Double(grade.GsatCH) + department.gsatenglishMultiplier * Double(grade.GsatEN) + department.gsatmathaMultiplier * Double(grade.GsatMA) + department.gsatmathbMultiplier * Double(grade.GsatMB) + department.gsatscienceMultiplier * Double(grade.GsatSC) + department.gsatsocialMultiplier * Double(grade.GsatSO) + department.mathaMultiplier * Double(grade.AstMA) + department.mathbMultiplier * Double(grade.AstMB) + department.physicsMultiplier * Double(grade.AstPH) + department.chemistryMultiplier * Double(grade.AstCH) + department.biologyMultiplier * Double(grade.AstBI) + department.historyMultiplier * Double(grade.AstHI) + department.geometryMultiplier * Double(grade.AstGE) + department.socialMultiplier * Double(grade.AstSO))
    }
    
    private func totalMultiplier() -> Double {
        return (department.gsatchineseMultiplier + department.gsatenglishMultiplier + department.gsatmathaMultiplier + department.gsatmathbMultiplier + department.gsatscienceMultiplier + department.gsatsocialMultiplier + department.mathaMultiplier + department.mathbMultiplier + department.physicsMultiplier + department.chemistryMultiplier + department.biologyMultiplier + department.historyMultiplier + department.geometryMultiplier + department.socialMultiplier)
    }
    
}

#Preview("無資料") {
    let emptyUUID = UUID(uuidString: "00000000-0000-0000-0000-000000000000")!
    let departmentData = DepartmentData()
    
    // 選擇隨機的 Department，如果 departments 為空則使用預設值
    let department = departmentData.departments.randomElement()!
    
    let emptyGrade = UserGrade(
        id: emptyUUID,
        dataName: "無資料",
        GsatCH: -1,
        GsatEN: -1,
        GsatMA: -1,
        GsatMB: -1,
        GsatSO: -1,
        GsatSC: -1,
        GsatEL: -1,
        AstMA: -1,
        AstMB: -1,
        AstPH: -1,
        AstCH: -1,
        AstBI: -1,
        AstHI: -1,
        AstGE: -1,
        AstSO: -1,
        SpecialType: 0,
        SpecialPercentage: 0
    )
    
    DepartmentDetailView(department: department, grade: emptyGrade)
        .environmentObject(departmentData)
}

#Preview("有資料") {
    let departmentData = DepartmentData()
    
    // 選擇隨機的 Department，如果 departments 為空則使用預設值
    let department = departmentData.departments[2]
    
    let grade = UserGrade(
        id: UUID(),
        dataName: "模擬成績",
        GsatCH: Int.random(in: 0...60),
        GsatEN: Int.random(in: 0...60),
        GsatMA: Int.random(in: 0...60),
        GsatMB: Int.random(in: 0...60),
        GsatSO: Int.random(in: 0...60),
        GsatSC: Int.random(in: 0...60),
        GsatEL: 3, // 固定為 3
        AstMA: Int.random(in: 0...60),
        AstMB: Int.random(in: 0...60),
        AstPH: Int.random(in: 0...60),
        AstCH: Int.random(in: 0...60),
        AstBI: Int.random(in: 0...60),
        AstHI: Int.random(in: 0...60),
        AstGE: Int.random(in: 0...60),
        AstSO: Int.random(in: 0...60),
        SpecialType: 0,
        SpecialPercentage: 0
    )
    
    DepartmentDetailView(department: department, grade: grade)
        .environmentObject(departmentData)
}
