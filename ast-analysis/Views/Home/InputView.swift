//
//  InputView.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/3/21.
//

import SwiftUI

struct InputView: View {
    
    @EnvironmentObject private var userData: UserData
    @EnvironmentObject private var departmentData: DepartmentData
    
    @Environment(\.dismiss) var dismiss
    
    @State private var editingPage: Int = 0
    @State private var editingGsatCH: String = ""
    @State private var editingGsatEN: String = ""
    @State private var editingGsatMA: String = ""
    @State private var editingGsatMB: String = ""
    @State private var editingGsatSC: String = ""
    @State private var editingGsatSO: String = ""
    @State private var editingAstMA: String = ""
    @State private var editingAstMB: String = ""
    @State private var editingAstPH: String = ""
    @State private var editingAstCH: String = ""
    @State private var editingAstBI: String = ""
    @State private var editingAstHI: String = ""
    @State private var editingAstGE: String = ""
    @State private var editingAstSO: String = ""
    @State private var editingGsatEL: Int = 0
    @State private var editingOtherSP: Int = 0
    @State private var isFinished: Bool = false
    @State private var editing: UserGrade = UserGrade(dataName: "", GsatCH: 0, GsatEN: 0, GsatMA: 0, GsatMB: 0, GsatSO: 0, GsatSC: 0, GsatEL: 0, AstMA: 0, AstMB: 0, AstPH: 0, AstCH: 0, AstBI: 0, AstHI: 0, AstGE: 0, AstSO: 0, SpecialType: 0, SpecialPercentage: 0)
    @State private var analyseStep: Int = 0
    
    var body: some View {
        VStack(alignment: .leading){
            
            VStack(alignment: .leading){
                Text("成績輸入")
                    .font(.largeTitle)
                    .bold()
                Text("請輸入分科測驗與學測成績")
                    .foregroundStyle(Color(.systemGray))
            }
            
            Spacer()
                
            HStack{
                
                VStack(alignment: .leading){
                    
                    VStack(alignment: .leading){
                        Text("學測分數")
                            .font(.title2)
                            .bold()
                        Text("請輸入60級分制分數，未報考留空")
                            .foregroundStyle(Color(.systemGray))
                    }
                    .padding(.bottom, 20)
                    
                    HStack{
                        HStack{
                            Text("國文")
                            TextField("0~60 級分", text: $editingGsatCH)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        .padding(10)
                        .background(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(valdiateScore(editingGsatCH) ? .systemGray6 : .red), lineWidth: 1)
                        )
                        HStack{
                            Text("英文")
                            TextField("0~60 級分", text: $editingGsatEN)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        .padding(10)
                        .background(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(valdiateScore(editingGsatEN) ? .systemGray6 : .red), lineWidth: 1)
                        )
                    }
                    HStack{
                        HStack{
                            Text("數Ａ")
                            TextField("0~60 級分", text: $editingGsatMA)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        .padding(10)
                        .background(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(valdiateScore(editingGsatMA) ? .systemGray6 : .red), lineWidth: 1)
                        )
                        HStack{
                            Text("數Ｂ")
                            TextField("0~60 級分", text: $editingGsatMB)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        .padding(10)
                        .background(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(valdiateScore(editingGsatMB) ? .systemGray6 : .red), lineWidth: 1)
                        )
                    }
                    HStack{
                        HStack{
                            Text("自然")
                            TextField("0~60 級分", text: $editingGsatSC)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        .padding(10)
                        .background(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(valdiateScore(editingGsatSC) ? .systemGray6 : .red), lineWidth: 1)
                        )
                        HStack{
                            Text("社會")
                            TextField("0~60 級分", text: $editingGsatSO)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        .padding(10)
                        .background(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(valdiateScore(editingGsatSO) ? .systemGray6 : .red), lineWidth: 1)
                        )
                    }
                    
                    Spacer()
                    HStack{
                        Spacer()
                        Button{
                            withAnimation(.easeInOut){
                                editingPage = 1
                            }
                        } label: {
                            HStack{
                                Text("下一步")
                                Image(systemName: "chevron.right")
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(!valdiateScore(editingGsatMA) || !valdiateScore(editingGsatMB) || !valdiateScore(editingGsatEN) || !valdiateScore(editingGsatCH) || !valdiateScore(editingGsatSC) || !valdiateScore(editingGsatSO))
                    }
                }
                .inputCard()
                .disabled(editingPage != 0)
                
                VStack(alignment: .leading){
                    
                    VStack(alignment: .leading){
                        Text("分科分數")
                            .font(.title2)
                            .bold()
                        Text("請輸入60級分制分數，未報考留空")
                            .foregroundStyle(Color(.systemGray))
                    }
                    .padding(.bottom, 20)
                    
                    HStack{
                        HStack{
                            Text("數甲")
                            TextField("0~60 級分", text: $editingAstMA)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        .padding(10)
                        .background(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(valdiateScore(editingAstMA) ? .systemGray6 : .red), lineWidth: 1)
                        )
                        HStack{
                            Text("數乙")
                            TextField("0~60 級分", text: $editingAstMB)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        .padding(10)
                        .background(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(valdiateScore(editingAstMB) ? .systemGray6 : .red), lineWidth: 1)
                        )
                    }
                    HStack{
                        HStack{
                            Text("物理")
                            TextField("0~60 級分", text: $editingAstPH)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        .padding(10)
                        .background(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(valdiateScore(editingAstPH) ? .systemGray6 : .red), lineWidth: 1)
                        )
                        HStack{
                            Text("化學")
                            TextField("0~60 級分", text: $editingAstCH)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        .padding(10)
                        .background(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(valdiateScore(editingAstCH) ? .systemGray6 : .red), lineWidth: 1)
                        )
                    }
                    HStack{
                        HStack{
                            Text("生物")
                            TextField("0~60 級分", text: $editingAstBI)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        .padding(10)
                        .background(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(valdiateScore(editingAstBI) ? .systemGray6 : .red), lineWidth: 1)
                        )
                        HStack{
                            Text("歷史")
                            TextField("0~60 級分", text: $editingAstHI)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        .padding(10)
                        .background(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(valdiateScore(editingAstHI) ? .systemGray6 : .red), lineWidth: 1)
                        )
                    }
                    HStack{
                        HStack{
                            Text("地理")
                            TextField("0~60 級分", text: $editingAstGE)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        .padding(10)
                        .background(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(valdiateScore(editingAstGE) ? .systemGray6 : .red), lineWidth: 1)
                        )
                        HStack{
                            Text("公民")
                            TextField("0~60 級分", text: $editingAstSO)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        .padding(10)
                        .background(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(valdiateScore(editingAstSO) ? .systemGray6 : .red), lineWidth: 1)
                        )
                    }
                    
                    Spacer()
                    HStack{
                        Button{
                            withAnimation(.easeInOut){
                                editingPage = 0
                            }
                        } label: {
                            HStack{
                                Image(systemName: "chevron.left")
                                Text("上一步")
                            }
                        }
                        Spacer()
                        Button{
                            withAnimation(.easeInOut){
                                editingPage = 2
                                hideKeyboard()
                            }
                        } label: {
                            HStack{
                                Text("下一步")
                                Image(systemName: "chevron.right")
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(!valdiateScore(editingAstMA) || !valdiateScore(editingAstMB) || !valdiateScore(editingAstPH) || !valdiateScore(editingAstCH) || !valdiateScore(editingAstBI) || !valdiateScore(editingAstHI) || !valdiateScore(editingAstGE) || !valdiateScore(editingAstSO))
                    }
                }
                .inputCard()
                .disabled(editingPage != 1)
                
                VStack(alignment: .leading){
                    
                    VStack(alignment: .leading){
                        Text("其他項目")
                            .font(.title2)
                            .bold()
                        Text("請選擇")
                            .foregroundStyle(Color(.systemGray))
                    }
                    .padding(.bottom, 20)
                    
                    HStack{
                        Text("英聽")
                        Spacer()
                        Picker("", selection: $editingGsatEL){
                            Text("A級")
                                .tag(3)
                            Text("B級")
                                .tag(2)
                            Text("C級")
                                .tag(1)
                            Text("F級 / 未報考")
                                .tag(0)
                        }
                    }
                    .padding(10)
                    .background(Color(.systemBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemGray6), lineWidth: 1)
                    )
                    
                    HStack{
                        Text("身份")
                        Spacer()
                        Picker("", selection: $editingOtherSP){
                            Text("一般生 (+0%)")
                                .tag(0)
                            Section("原住民"){
                                Text("具語言認證原住民 (+35%)")
                                    .tag(1)
                                Text("無語言認證原住民 (+10%)")
                                    .tag(2)
                            }
                            Section("蒙藏僑生"){
                                Text("蒙藏生 (+25%)")
                                    .tag(3)
                                Text("僑生 (+25%)")
                                    .tag(4)
                            }
                            Section("政府外派人員子女"){
                                Text("返國就讀一學年內 (+25%)")
                                    .tag(5)
                                Text("返國就讀二學年內 (+15%)")
                                    .tag(6)
                                Text("返國就讀三學年內 (+10%)")
                                    .tag(7)
                            }
                            Section("境外優秀科技人才"){
                                Text("來臺就讀一學年內 (+25%)")
                                    .tag(8)
                                Text("來臺就讀二學年內 (+15%)")
                                    .tag(9)
                                Text("來臺就讀三學年內 (+10%)")
                                    .tag(10)
                            }
                            Section("退伍軍人"){
                                Text("服役五年退伍一年 (+25%)")
                                    .tag(11)
                                Text("服役五年退伍二年 (+20%)")
                                    .tag(12)
                                Text("服役五年退伍三年(+15%)")
                                    .tag(13)
                                Text("服役五年退伍五年(+10%)")
                                    .tag(14)
                                Text("服役四年退伍一年 (+20%)")
                                    .tag(15)
                                Text("服役四年退伍二年 (+15%)")
                                    .tag(16)
                                Text("服役四年退伍三年(+10%)")
                                    .tag(17)
                                Text("服役四年退伍五年(+5%)")
                                    .tag(18)
                                Text("服役三年退伍一年 (+15%)")
                                    .tag(19)
                                Text("服役三年退伍二年 (+10%)")
                                    .tag(20)
                                Text("服役三年退伍三年 (+5%)")
                                    .tag(21)
                                Text("服役三年退伍五年 (+3%)")
                                    .tag(22)
                                Text("服滿役期退伍三年 (+5%)")
                                    .tag(23)
                                Text("因公身障退伍三年 (+25%)")
                                    .tag(24)
                                Text("因病身障退伍三年 (+5%)")
                                    .tag(25)
                            }
                        }
                    }
                    .padding(10)
                    .background(Color(.systemBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemGray6), lineWidth: 1)
                    )
                    
                    Spacer()
                    HStack{
                        Button{
                            withAnimation(.easeInOut){
                                editingPage = 1
                            }
                        } label: {
                            HStack{
                                Image(systemName: "chevron.left")
                                Text("上一步")
                            }
                        }
                        Spacer()
                        Button{
                            isFinished = true
                            withAnimation(.easeInOut){
                                editingPage = 3
                            }
                            editing = UserGrade(dataName: "資料 #\(userData.userData.grade.count + 1)", GsatCH: returnScore(editingGsatCH), GsatEN: returnScore(editingGsatEN), GsatMA: returnScore(editingGsatMA), GsatMB: returnScore(editingGsatMB), GsatSO: returnScore(editingGsatSO), GsatSC: returnScore(editingGsatSC), GsatEL: editingGsatEL, AstMA: returnScore(editingAstMA), AstMB: returnScore(editingAstMB), AstPH: returnScore(editingAstPH), AstCH: returnScore(editingAstCH), AstBI: returnScore(editingAstBI), AstHI: returnScore(editingAstHI), AstGE: returnScore(editingAstGE), AstSO: returnScore(editingAstSO), SpecialType: editingOtherSP, SpecialPercentage: getPercentage(for: editingOtherSP))
                        } label: {
                            HStack{
                                Text("完成")
                                Image(systemName: "chevron.right")
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                .inputCard()
                .disabled(editingPage != 2)
                
                if isFinished {
                    VStack(alignment: .center){
                        Spacer()
                        VStack(spacing: 5){
                            Image(systemName: "clock")
                                .font(.largeTitle)
                                .foregroundStyle(Color(.accent))
                            Text("分析中")
                                .font(.title2)
                                .bold()
                            Text("請稍候")
                                .foregroundStyle(Color(.systemGray))
                                .padding(.bottom, 10)
                            ProgressView(value: ( Double(analyseStep) / 8.0 ))
                                .padding(.horizontal, 50)
                        }
                        Spacer()
                        HStack{
                            Spacer()
                        }
                    }
                    .inputCard()
                    .disabled(editingPage != 3)
                    .onAppear {
                        if analyseStep == 0 && userData.userData.analyzeCount > 0 {
                            Task {
                                await analyse()
                                userData.userData.grade.append(editing)
                                userData.userData.analyzeCount -= 1
                                withAnimation {
                                    editingPage = 4
                                }
                            }
                        } else {
                            editingPage = 0
                        }
                    }
                    VStack(alignment: .center){
                        
                        Spacer()
                        VStack(spacing: 5){
                            Image(systemName: "checkmark.circle")
                                .font(.largeTitle)
                                .foregroundStyle(Color(.accent))
                            Text("完成")
                                .font(.title2)
                                .bold()
                            Text("資料已登錄，請至分析頁查看分析結果")
                                .foregroundStyle(Color(.systemGray))
                            Text("分析次數已扣除，目前尚餘 \(userData.userData.analyzeCount) 次")
                                .foregroundStyle(Color(.systemGray))
                        }
                        Spacer()
                        HStack{
                            Spacer()
                            Button{
                                dismiss()
                                withAnimation(.easeInOut){
                                    editingPage = 0
                                    isFinished = false
                                }
                                analyseStep = 0
                            } label: {
                                HStack{
                                    Text("關閉此頁")
                                    Image(systemName: "xmark")
                                }
                            }
                            .buttonStyle(.borderedProminent)
                            Spacer()
                        }
                    }
                    .inputCard()
                    .disabled(editingPage != 4)
                }
                
            }
            .frame(width: 350, alignment: .leading)
            .offset(x: CGFloat(editingPage) * -358)
            .padding(.bottom)
            
            Spacer()
            
            HStack{
                Spacer()
            }
            
        }
        .padding()
    }
    
    private func valdiateScore(_ score: String) -> Bool {
        if score.isEmpty { return true } // 無成績
        guard let scoreInt = Int(score) else {
            return false // 不知輸入啥
        }
        return scoreInt >= 0 && scoreInt <= 60 // 是否正確輸入
    }
    
    private func returnScore(_ score: String) -> Int {
        if score.isEmpty {
            return -1
        }
        if let scoreInt = Int(score) {
            if scoreInt < 0 || scoreInt > 60 {
                return -1
            } else {
                return scoreInt
            }
        } else {
            return -1
        }
    }
    
    private func getPercentage(for type: Int) -> Int {
        switch type {
        case 0: // 一般生
            return 0
        case 1: // 具語言認證原住民
            return 35
        case 3, 4, 5, 8, 11, 24: // 蒙藏生、僑生、返國一學年、來臺一學年、服役五年退伍一年、因公身障退伍三年
            return 25
        case 12, 15: // 服役五年退伍二年、服役四年退伍一年
            return 20
        case 6, 9, 13, 16, 19: // 返國二學年、來臺二學年、服役五年退伍三年、服役四年退伍二年、服役三年退伍一年
            return 15
        case 2, 7, 10, 14, 17, 20: // 無語言認證原住民、返國三學年、來臺三學年、服役五年退伍五年、服役四年退伍三年、服役三年退伍二年
            return 10
        case 18, 21, 23, 25: // 服役四年退伍五年、服役三年退伍三年、服滿役期退伍三年、因病身障退伍三年
            return 5
        case 22: // 服役三年退伍五年
            return 3
        default:
            return 0 // 未定義的 tag 返回 0
        }
    }
    
    // 分析
    
    private func analyse() async {
        
        // 1. 先篩選通過之校系
        
        var departments = await analyseFilteredDepartments(departments: departmentData.departments, result: editing)
        analyseStep = 1
        
        // 2. 計算成績
        
        departments = await analyseCalculate(departments: departments, result: editing)
        analyseStep = 2
        
        // 3. 排序 (存於[0])
        
        await editing.analyse.append(analyseFilteredDepartments(departments: departments, result: editing))
        analyseStep = 3
        
        // 4. 計算五星 (存於[1~5])
        
        await editing.analyse.append(analyseStarsDepartments(departments: departments, result: editing, percentUp: 1.01, percentDown: 0.8))
        analyseStep = 4
        await editing.analyse.append(analyseStarsDepartments(departments: departments, result: editing, percentUp: 0.8, percentDown: 0.6))
        analyseStep = 5
        await editing.analyse.append(analyseStarsDepartments(departments: departments, result: editing, percentUp: 0.6, percentDown: 0.4))
        analyseStep = 6
        await editing.analyse.append(analyseStarsDepartments(departments: departments, result: editing, percentUp: 0.4, percentDown: 0.2))
        analyseStep = 7
        await editing.analyse.append(analyseStarsDepartments(departments: departments, result: editing, percentUp: 0.2, percentDown: 0))
        analyseStep = 8
    }
    
    private func analyseFilteredDepartments(departments: [Departments], result: UserGrade) async -> [Departments] {
        
        let filteredDepartments: [Departments] = departments.filter { department in
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
                        mine = -2
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
                        mine = -2
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
                        mine = -2
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
                        mine = -2
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
                        mine = -2
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
                        mine = -2
                    }
                }
                return you > mine // 有篩選再多
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
                if department.gsatchineseMultiplier > 0 && result.GsatCH < 0 {
                    return false // 國文採計但未報考
                }
                if department.gsatenglishMultiplier > 0 && result.GsatEN < 0 {
                    return false // 英文採計但未報考
                }
                if department.gsatmathaMultiplier > 0 && result.GsatMA < 0 {
                    return false // 數A採計但未報考
                }
                if department.gsatmathbMultiplier > 0 && result.GsatMB < 0 {
                    return false // 數B採計但未報考
                }
                if department.gsatscienceMultiplier > 0 && result.GsatSC < 0 {
                    return false // 自然採計但未報考
                }
                if department.gsatsocialMultiplier > 0 && result.GsatSO < 0 {
                    return false // 社會採計但未報考
                }
                // 分科測驗科目
                if department.mathaMultiplier > 0 && result.AstMA < 0 {
                    return false // 數甲採計但未報考
                }
                if department.mathbMultiplier > 0 && result.AstMB < 0 {
                    return false // 數乙採計但未報考
                }
                if department.physicsMultiplier > 0 && result.AstPH < 0 {
                    return false // 物理採計但未報考
                }
                if department.chemistryMultiplier > 0 && result.AstCH < 0 {
                    return false // 化學採計但未報考
                }
                if department.biologyMultiplier > 0 && result.AstBI < 0 {
                    return false // 生物採計但未報考
                }
                if department.historyMultiplier > 0 && result.AstHI < 0 {
                    return false // 歷史採計但未報考
                }
                if department.geometryMultiplier > 0 && result.AstGE < 0 {
                    return false // 地理採計但未報考
                }
                if department.socialMultiplier > 0 && result.AstSO < 0 {
                    return false // 公民採計但未報考
                }
                return true // 所有採計科目都報考
            }()
            
            // 學測科目、英聽和 multiplier 條件都需通過
            return passedTests && passedEL && passedMultipliers
        }
        return filteredDepartments
        
    }
    
    private func analyseCalculate(departments: [Departments], result: UserGrade) async -> [Departments] {
        return departments.map { department in
            var newDepartment = department
            newDepartment.calculatedPercent = directCalculateChance(department: department, grade: editing)
            return newDepartment
        }
    }
    
    private func directCalculateChance(department: Departments, grade: UserGrade) -> Double {
        let departmentScore: Double = (Double(department.resultScore) ?? 1.0) / department.resultTotalMultiplier
        let candidateScore: Double = (((department.gsatchineseMultiplier * Double(grade.GsatCH) + department.gsatenglishMultiplier * Double(grade.GsatEN) + department.gsatmathaMultiplier * Double(grade.GsatMA) + department.gsatmathbMultiplier * Double(grade.GsatMB) + department.gsatscienceMultiplier * Double(grade.GsatSC) + department.gsatsocialMultiplier * Double(grade.GsatSO) + department.mathaMultiplier * Double(grade.AstMA) + department.mathbMultiplier * Double(grade.AstMB) + department.physicsMultiplier * Double(grade.AstPH) + department.chemistryMultiplier * Double(grade.AstCH) + department.biologyMultiplier * Double(grade.AstBI) + department.historyMultiplier * Double(grade.AstHI) + department.geometryMultiplier * Double(grade.AstGE) + department.socialMultiplier * Double(grade.AstSO)) * ( (Double(grade.SpecialPercentage) / 100 ) + 1 )) / (department.gsatchineseMultiplier + department.gsatenglishMultiplier + department.gsatmathaMultiplier + department.gsatmathbMultiplier + department.gsatscienceMultiplier + department.gsatsocialMultiplier + department.mathaMultiplier + department.mathbMultiplier + department.physicsMultiplier + department.chemistryMultiplier + department.biologyMultiplier + department.historyMultiplier + department.geometryMultiplier + department.socialMultiplier))
        // let fullScore: Double = 60.0
        let sigmaFraction: Double = 0.1
        let sigma = sigmaFraction * departmentScore
            
        // 確保 sigma 不為 0
        guard sigma > 0 else {
            return candidateScore >= departmentScore ? 1.0 : 0.0
        }
        
        // 計算 z 值
        let z = (candidateScore - departmentScore) / sigma
        
        // 計算標準常態分布的 CDF (normalCDF 的邏輯)
        let zAbs = abs(z)
        let p = 0.2316419
        let a1 = 0.319381530
        let a2 = -0.356563782
        let a3 = 1.781477937
        let a4 = -1.821255978
        let a5 = 1.330274429
        
        let t = 1.0 / (1.0 + p * zAbs)
        let t2 = t * t
        let t3 = t2 * t
        let t4 = t3 * t
        let t5 = t4 * t
        
        let poly = a1 * t + a2 * t2 + a3 * t3 + a4 * t4 + a5 * t5
        let z2 = zAbs * zAbs
        let phi = 1.0 - (1.0 / sqrt(2.0 * .pi)) * exp(-z2 / 2.0) * poly
        
        // 如果 z < 0，利用對稱性
        let probability = z < 0 ? 1.0 - phi : phi
        
        return probability
    }
    
    private func analyseSortedDepartments(departments: [Departments], result: UserGrade) async -> [Departments] {
        return departments.sorted {
            return $0.calculatedPercent > $1.calculatedPercent
        }
    }
    
    private func analyseStarsDepartments(departments: [Departments], result: UserGrade, percentUp: Double, percentDown: Double) async -> [Departments] {
        return departments.filter { department in
            let percent = department.calculatedPercent
            return percent >= percentDown && percent < percentUp
        }
    }
    
}

#Preview {
    InputView()
        .environmentObject(UserData())
        .environmentObject(DepartmentData())
}
