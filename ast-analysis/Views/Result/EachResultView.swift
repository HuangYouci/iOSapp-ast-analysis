//
//  EachResultView.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/3/22.
//

import SwiftUI

struct EachResultView: View {
    let resultID: UUID
    
    @EnvironmentObject var departmentData: DepartmentData
    @EnvironmentObject var userData: UserData
    @Environment(\.dismiss) var dismiss
    
    @State private var editNameField: String = ""
    @State private var expandedInfo: Bool = false
    @State private var confirmEdit: Bool = false
    @State private var editName: Bool = false
    @State private var shouldDelete: Bool = false
    
    private var result: UserGrade {
        userData.userData.grade.first { $0.id == resultID }!
    }
    
    var body: some View {
        
        let filteredDepartments: [Departments] = departmentData.departments.filter { department in
            // 內嵌 checkTestPassed 邏輯
            let checkTestPassed: (Int, Int, String) -> Bool = { you, type, goal in
                // type: 0 國文 1 英文 2 數Ａ 3 數Ｂ 4 自然 5 社會
                var mine: Int = 0
                switch type {
                case 5: // 社會
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
                case 4: // 自然
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
                case 3: // 數B
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
                case 2: // 數A
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
                case 1: // 英文
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
                default: // 國文
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
                return you >= mine // 有篩選再多
            }
            
            // 內嵌 checkAllTestsPassed 邏輯
            // 檢查學測科目是否通過
            let passedCH = checkTestPassed(result.GsatCH, 0, department.chinesetest) // 國文
            let passedEN = checkTestPassed(result.GsatEN, 1, department.englishtest) // 英文
            let passedMA = checkTestPassed(result.GsatMA, 2, department.mathatest)   // 數A
            let passedMB = checkTestPassed(result.GsatMB, 3, department.mathbtest)   // 數B
            let passedSC = checkTestPassed(result.GsatSC, 4, department.sciencetest) // 自然
            let passedSO = checkTestPassed(result.GsatSO, 5, department.socialtest)  // 社會
            
            // MB 和 MA 只需其中一個通過
            let passedMath = passedMA || passedMB
            
            // 所有科目都需通過（數學只需 MA 或 MB 其中一個通過）
            let passedTests = passedCH && passedEN && passedMath && passedSC && passedSO
            
            // 檢查英聽
            let passedEL: Bool
            if department.englishlistentest.isEmpty {
                passedEL = true // 無英聽要求，自動通過
            } else {
                switch result.GsatEL {
                case 3: // A級
                    passedEL = true
                case 2: // B級
                    passedEL = (department.englishlistentest != "A級")
                case 1: // C級
                    passedEL = (department.englishlistentest != "A級" && department.englishlistentest != "B級")
                default: // F級或其他
                    passedEL = false
                }
            }
            
            // 新增篩選條件：檢查所有 multiplier > 0 的科目，其分數必須 > 0
            let passedMultipliers: Bool = {
                // 學測科目
                if department.gsatchineseMultiplier > 0 && result.GsatCH <= -1 {
                    return false // 國文採計但未報考
                }
                if department.gsatenglishMultiplier > 0 && result.GsatEN <= -1 {
                    return false // 英文採計但未報考
                }
                if department.gsatmathaMultiplier > 0 && result.GsatMA <= -1 {
                    return false // 數A採計但未報考
                }
                if department.gsatmathbMultiplier > 0 && result.GsatMB <= -1 {
                    return false // 數B採計但未報考
                }
                if department.gsatscienceMultiplier > 0 && result.GsatSC <= -1 {
                    return false // 自然採計但未報考
                }
                if department.gsatsocialMultiplier > 0 && result.GsatSO <= -1 {
                    return false // 社會採計但未報考
                }
                // 分科測驗科目
                if department.mathaMultiplier > 0 && result.AstMA <= -1 {
                    return false // 數甲採計但未報考
                }
                if department.mathbMultiplier > 0 && result.AstMB <= -1 {
                    return false // 數乙採計但未報考
                }
                if department.physicsMultiplier > 0 && result.AstPH <= -1 {
                    return false // 物理採計但未報考
                }
                if department.chemistryMultiplier > 0 && result.AstCH <= -1 {
                    return false // 化學採計但未報考
                }
                if department.biologyMultiplier > 0 && result.AstBI <= -1 {
                    return false // 生物採計但未報考
                }
                if department.historyMultiplier > 0 && result.AstHI <= -1 {
                    return false // 歷史採計但未報考
                }
                if department.geometryMultiplier > 0 && result.AstGE <= -1 {
                    return false // 地理採計但未報考
                }
                if department.socialMultiplier > 0 && result.AstSO <= -1 {
                    return false // 公民採計但未報考
                }
                return true // 所有採計科目都報考
            }()
            
            // 學測科目、英聽和 multiplier 條件都需通過
            return passedTests && passedEL && passedMultipliers
        }
        
        VStack {
            VStack(alignment: .leading) {
                HStack{
                    if editName {
                        TextField(result.dataName, text: $editNameField)
                            .font(.title3)
                            .bold()
                    } else {
                        Text(result.dataName)
                            .font(.title3)
                            .bold()
                    }
                    Spacer()
                    Image(systemName: expandedInfo ? "chevron.right" : "chevron.down")
                        .foregroundStyle(Color(.systemGray2))
                }
                Divider()
                if expandedInfo {
                    Text("學科能力測驗")
                        .font(.caption)
                        .foregroundStyle(Color(.systemGray2))
                        .padding(.vertical, 5)
                    FlowLayout{
                        HStack{
                            Text("國文")
                            if result.GsatCH >= 0 { Text("\(result.GsatCH) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                        }
                        HStack{
                            Text("英文")
                            if result.GsatEN >= 0 { Text("\(result.GsatEN) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                        }
                        HStack{
                            Text("數Ａ")
                            if result.GsatMA >= 0 { Text("\(result.GsatMA) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                        }
                        HStack{
                            Text("數Ｂ")
                            if result.GsatMB >= 0 { Text("\(result.GsatMB) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                        }
                        HStack{
                            Text("自然")
                            if result.GsatSC >= 0 { Text("\(result.GsatSC) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                        }
                        HStack{
                            Text("社會")
                            if result.GsatSO >= 0 { Text("\(result.GsatSO) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                        }
                    }
                    Text("英語聽力測驗")
                        .font(.caption)
                        .foregroundStyle(Color(.systemGray2))
                        .padding(.vertical, 5)
                    switch result.GsatEL {
                    case 3:
                        Text("A 級")
                    case 2:
                        Text("B 級")
                    case 1:
                        Text("C 級")
                    default:
                        Text("F 級 / 未報考").foregroundStyle(Color(.systemGray))
                    }
                    Text("分科測驗")
                        .font(.caption)
                        .foregroundStyle(Color(.systemGray2))
                        .padding(.vertical, 5)
                    FlowLayout{
                        HStack{
                            Text("數甲")
                            if result.AstMA >= 0 { Text("\(result.AstMA) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                        }
                        HStack{
                            Text("數乙")
                            if result.AstMB >= 0 { Text("\(result.AstMB) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                        }
                        HStack{
                            Text("物理")
                            if result.AstPH >= 0 { Text("\(result.AstPH) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                        }
                        HStack{
                            Text("化學")
                            if result.AstCH >= 0 { Text("\(result.AstCH) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                        }
                        HStack{
                            Text("生物")
                            if result.AstBI >= 0 { Text("\(result.AstBI) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                        }
                        HStack{
                            Text("歷史")
                            if result.AstHI >= 0 { Text("\(result.AstHI) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                        }
                        HStack{
                            Text("地理")
                            if result.AstGE >= 0 { Text("\(result.AstGE) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                        }
                        HStack{
                            Text("公民")
                            if result.AstSO >= 0 { Text("\(result.AstSO) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                        }
                    }
                    if result.SpecialPercentage > 0 {
                        Text("身份加分")
                            .font(.caption)
                            .foregroundStyle(Color(.systemGray2))
                            .padding(.vertical, 5)
                        Text("\(result.SpecialPercentage) %")
                            .bold()
                    }
                    Text("資料操作")
                        .font(.caption)
                        .foregroundStyle(Color(.systemGray2))
                        .padding(.vertical, 5)
                    HStack{
                        if editName {
                            Button {
                                if let index = userData.userData.grade.firstIndex(where: { $0.id == resultID }) {
                                    userData.userData.grade[index].dataName = editNameField
                                }
                                dismiss()
                            } label: {
                                Image(systemName: "checkmark")
                                Text("儲存資料名稱")
                            }
                        } else {
                            Button {
                                editName = true
                            } label: {
                                Image(systemName: "pencil")
                                Text("變更資料名稱")
                            }
                        }
                        Spacer()
                        if confirmEdit {
                            Button(role: .destructive) {
                                shouldDelete = true
                                dismiss()
                            } label: {
                                Text("確定刪除？")
                                    .bold()
                                Image(systemName: "trash")
                            }
                        } else {
                            Button(role: .destructive) {
                                confirmEdit = true
                            } label: {
                                Text("刪除")
                                Image(systemName: "trash")
                            }
                        }
                    }
                } else {
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            
                                HStack{
                                    Text("國文")
                                    if result.GsatCH >= 0 { Text("\(result.GsatCH) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                }
                                HStack{
                                    Text("英文")
                                    if result.GsatEN >= 0 { Text("\(result.GsatEN) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                }
                                HStack{
                                    Text("數Ａ")
                                    if result.GsatMA >= 0 { Text("\(result.GsatMA) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                }
                                HStack{
                                    Text("數Ｂ")
                                    if result.GsatMB >= 0 { Text("\(result.GsatMB) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                }
                                HStack{
                                    Text("自然")
                                    if result.GsatSC >= 0 { Text("\(result.GsatSC) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                }
                                HStack{
                                    Text("社會")
                                    if result.GsatSO >= 0 { Text("\(result.GsatSO) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                }
                            
                            switch result.GsatEL {
                            case 3:
                                Text("A 級")
                            case 2:
                                Text("B 級")
                            case 1:
                                Text("C 級")
                            default:
                                Text("F 級 / 未報考").foregroundStyle(Color(.systemGray))
                            }
                            
                            
                                HStack{
                                    Text("數甲")
                                    if result.AstMA >= 0 { Text("\(result.AstMA) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                }
                                HStack{
                                    Text("數乙")
                                    if result.AstMB >= 0 { Text("\(result.AstMB) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                }
                                HStack{
                                    Text("物理")
                                    if result.AstPH >= 0 { Text("\(result.AstPH) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                }
                                HStack{
                                    Text("化學")
                                    if result.AstCH >= 0 { Text("\(result.AstCH) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                }
                                HStack{
                                    Text("生物")
                                    if result.AstBI >= 0 { Text("\(result.AstBI) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                }
                                HStack{
                                    Text("歷史")
                                    if result.AstHI >= 0 { Text("\(result.AstHI) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                }
                                HStack{
                                    Text("地理")
                                    if result.AstGE >= 0 { Text("\(result.AstGE) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                }
                                HStack{
                                    Text("公民")
                                    if result.AstSO >= 0 { Text("\(result.AstSO) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                }
                            
                            Text("加分")
                                .font(.caption)
                                .foregroundStyle(Color(.systemGray2))
                            Text("\(result.SpecialPercentage) %")
                                .bold()
                            
                        }
                    }
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
            .onTapGesture {
                withAnimation(.easeInOut){
                    expandedInfo.toggle()
                }
            }
            Spacer()
            NavigationLink(destination: DepartmentListView(departments: filteredDepartments, grade: result, title: "所有通過檢定之校系")){
                VStack{
                    HStack{
                        Text("所有通過檢定之校系")
                            .font(.title3)
                            .bold()
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(Color(.systemGray2))
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
        }
        .padding()
        .navigationTitle("分析結果")
        .onDisappear {
            if shouldDelete {
                if let index = userData.userData.grade.firstIndex(where: { $0.id == resultID }) {
                    userData.userData.grade.remove(at: index)
                }
            }
        }
    }
}

#Preview {
    return EachResultView(resultID: UserData().userData.grade.first!.id)
        .environmentObject(UserData()) // 提供 EnvironmentObject
}
