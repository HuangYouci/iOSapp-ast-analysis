//
//  EachResultView.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/3/22.
//

import SwiftUI

struct ResultDetailView: View {
    
    // 輸入 Result ID、得到 Result
    let result: UserGrade
    
    // 傳入 UserData
    @StateObject var userData: UserData = UserData.shared

    // 上一步
    @Environment(\.dismiss) var dismiss
    
    // UI 功能：改名、展開、刪除
    @State private var editNameField: String = ""           // 變更資料名稱
    @State private var expandedInfo: Bool = false           // 是否展開操作選單
    @State private var confirmEdit: Bool = false            // 是否確定刪除
    @State private var editName: Bool = false               // 更名暫存
    @State private var shouldDelete: Bool = false           // 刪除後消失刪除
    @State private var searchText: String = ""              // 搜尋關鍵詞
    @State private var showFilter: Bool = false             // 是否打開篩選器
    @State private var searchFilter: [String] = []          // 搜尋學校詞
    @State private var searchScore: Double = 0              // 搜尋機率低標
    @State private var fullDepts: [Departments] = []
    @State private var nodataDepts: [Departments] = []
    @State private var nopassDepts: [Departments] = []
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            HStack{
                if editName {
                    TextField(result.dataName, text: $editNameField)
                        .font(.largeTitle)
                        .bold()
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            
            VStack{
                VStack(alignment: .leading){
                    HStack(alignment: .center){
                        VStack(alignment: .leading) {
                            if expandedInfo {
                                Text("學科能力測驗")
                                    .font(.caption)
                                    .foregroundStyle(Color(.systemGray2))
                                    .padding(.vertical, 5)
                                FlowLayout{
                                    HStack{
                                        Text("國文")
                                        if result.GsatCH >= 0 { Text("\(result.GsatCH)").bold() } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                    }
                                    HStack{
                                        Text("英文")
                                        if result.GsatEN >= 0 { Text("\(result.GsatEN)").bold() } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                    }
                                    HStack{
                                        Text("數Ａ")
                                        if result.GsatMA >= 0 { Text("\(result.GsatMA)").bold() } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                    }
                                    HStack{
                                        Text("數Ｂ")
                                        if result.GsatMB >= 0 { Text("\(result.GsatMB)").bold() } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                    }
                                    HStack{
                                        Text("自然")
                                        if result.GsatSC >= 0 { Text("\(result.GsatSC)").bold() } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                    }
                                    HStack{
                                        Text("社會")
                                        if result.GsatSO >= 0 { Text("\(result.GsatSO)").bold() } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
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
                                        if result.AstMA >= 0 { Text("\(result.AstMA)").bold() } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                    }
                                    HStack{
                                        Text("數乙")
                                        if result.AstMB >= 0 { Text("\(result.AstMB)").bold() } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                    }
                                    HStack{
                                        Text("物理")
                                        if result.AstPH >= 0 { Text("\(result.AstPH)").bold() } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                    }
                                    HStack{
                                        Text("化學")
                                        if result.AstCH >= 0 { Text("\(result.AstCH)").bold() } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                    }
                                    HStack{
                                        Text("生物")
                                        if result.AstBI >= 0 { Text("\(result.AstBI)").bold() } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                    }
                                    HStack{
                                        Text("歷史")
                                        if result.AstHI >= 0 { Text("\(result.AstHI)").bold() } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                    }
                                    HStack{
                                        Text("地理")
                                        if result.AstGE >= 0 { Text("\(result.AstGE)").bold() } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                    }
                                    HStack{
                                        Text("公民")
                                        if result.AstSO >= 0 { Text("\(result.AstSO)").bold() } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
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
                                            if let index = userData.userData.grade.firstIndex(where: { $0.id == result.id }) {
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
                                    HStack(spacing: 10){
                                        
                                        VStack{
                                            Text("國文")
                                                .font(.caption)
                                            if result.GsatCH >= 0 { Text("\(result.GsatCH)").bold().font(.title3) } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                        }
                                        VStack{
                                            Text("英文")
                                                .font(.caption)
                                            if result.GsatEN >= 0 { Text("\(result.GsatEN)").bold().font(.title3) } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                        }
                                        VStack{
                                            Text("數Ａ")
                                                .font(.caption)
                                            if result.GsatMA >= 0 { Text("\(result.GsatMA)").bold().font(.title3) } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                        }
                                        VStack{
                                            Text("數Ｂ")
                                                .font(.caption)
                                            if result.GsatMB >= 0 { Text("\(result.GsatMB)").bold().font(.title3) } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                        }
                                        VStack{
                                            Text("自然")
                                                .font(.caption)
                                            if result.GsatSC >= 0 { Text("\(result.GsatSC)").bold().font(.title3) } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                        }
                                        VStack{
                                            Text("社會")
                                                .font(.caption)
                                            if result.GsatSO >= 0 { Text("\(result.GsatSO)").bold().font(.title3) } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                        }
                                        
                                        VStack{
                                            Text("英聽")
                                                .font(.caption)
                                            switch result.GsatEL {
                                            case 3:
                                                Text("A 級")
                                                    .bold().font(.title3)
                                            case 2:
                                                Text("B 級")
                                                    .bold().font(.title3)
                                            case 1:
                                                Text("C 級")
                                                    .bold().font(.title3)
                                            default:
                                                Text("F 級 / 未報考").foregroundStyle(Color(.systemGray))
                                            }
                                        }
                                        
                                        VStack{
                                            Text("數甲")
                                                .font(.caption)
                                            if result.AstMA >= 0 { Text("\(result.AstMA)").bold().font(.title3) } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                        }
                                        VStack{
                                            Text("數乙")
                                                .font(.caption)
                                            if result.AstMB >= 0 { Text("\(result.AstMB)").bold().font(.title3) } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                        }
                                        VStack{
                                            Text("物理")
                                                .font(.caption)
                                            if result.AstPH >= 0 { Text("\(result.AstPH)").bold().font(.title3) } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                        }
                                        VStack{
                                            Text("化學")
                                                .font(.caption)
                                            if result.AstCH >= 0 { Text("\(result.AstCH)").bold().font(.title3) } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                        }
                                        VStack{
                                            Text("生物")
                                                .font(.caption)
                                            if result.AstBI >= 0 { Text("\(result.AstBI)").bold().font(.title3) } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                        }
                                        VStack{
                                            Text("歷史")
                                                .font(.caption)
                                            if result.AstHI >= 0 { Text("\(result.AstHI)").bold().font(.title3) } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                        }
                                        VStack{
                                            Text("地理")
                                                .font(.caption)
                                            if result.AstGE >= 0 { Text("\(result.AstGE)").bold().font(.title3) } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                        }
                                        VStack{
                                            Text("公民")
                                                .font(.caption)
                                            if result.AstSO >= 0 { Text("\(result.AstSO)").bold().font(.title3) } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                        }
                                        
                                        VStack{
                                            Text("加分")
                                                .font(.caption)
                                            Text("\(result.SpecialPercentage) %")
                                                .bold()
                                                .font(.title3)
                                        }
                                        
                                    }
                                }
                            }
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut){
                                expandedInfo.toggle()
                            }
                        }
                    }
                    HStack{
                        TextField("搜尋校系關鍵字或代碼", text: $searchText)
                            .padding(10)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(.systemGray6), lineWidth: 2)
                            )
                            .onSubmit {
                                updateDepts()
                            }
                            .submitLabel(.search)
                        Button {
                            showFilter = true
                        } label: {
                            HStack{
                                Image(systemName: "line.3.horizontal.decrease")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                if (searchScore > 0 || !searchFilter.isEmpty){
                                    Text("已啟用")
                                }
                            }
                            .padding(10)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(.systemGray6), lineWidth: 2)
                            )
                        }
                        .onChange(of: showFilter){ result in
                            if (!result){
                                updateDepts()
                            }
                        }
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
                
                // MARK: - FUNC AND TIPS
                VStack{
                    HStack{
                        Spacer()
                        VStack{
                            Image(systemName: "heart")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(Color.accentColor)
                            Text("最愛校系")
                                .font(.callout)
                            Text("(開發中)")
                                .font(.callout)
                                .foregroundStyle(Color(.systemGray))
                        }
                        Divider()
                        VStack{
                            Image(systemName: "doc.richtext.zh")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(Color.accentColor)
                            Text("志願校系")
                                .font(.callout)
                            Text("(開發中)")
                                .font(.callout)
                                .foregroundStyle(Color(.systemGray))
                        }
                        Divider()
                        NavigationLink(destination: GuessDetailView(grade: result)){
                            VStack{
                                Image(systemName: "ruler")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                Text("差距分析")
                                    .font(.callout)
                            }
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: Color(.label).opacity(0.1),radius: 5)
                    .padding(.horizontal)
                    .buttonStyle(.plain)
                    
                    TipView(keyName: "resultFuncTips",
                            title: "結果功能",
                            content: "您可為每個結果設置「最愛校系」，也可設定一百個模擬的「志願校系」。「差距分析」提供您在分數尚未到齊時的預估差距。")
                    TipView(keyName: "resultMoreTips",
                            title: "結果操作",
                            content: "點一下標題分數列可展開更多選單，在該選單能清楚看到各科級分，也可為結果命名以及刪除結果。")
                    TipView(keyName: "resultDeclaimier",
                            title: "分析結果",
                            content: "錄取機率分析僅供參考，分科志願填寫無需過於斟酌，按自己喜歡依序填寫即可。僅能計算去年有資料的校系之錄取機率分析。點一下上方分數列可以開啟／關閉更多功能選單。")
                    TipView(keyName: "lagtips",
                            title: "大量資料",
                            content: "在沒有任何篩選器下，本頁面會顯示全部約兩千筆資料，快速滑動可能會導致卡頓。請斟酌啟用篩選器！")
                    
                }
                .padding(.top, 15)
                
                // MARK: - FULL RESULT
                HStack{
                    Text("校系列表")
                    Spacer()
                    Text("\(fullDepts.count) 個校系")
                }
                .font(.caption)
                .foregroundStyle(Color(.systemGray2))
                .padding(.vertical, 5)
                .padding(.horizontal)
                
                LazyVStack(alignment: .leading){
                    ForEach(fullDepts) { dept in
                        NavigationLink(destination: ResultDeptView(department: dept, grade: result)){
                            ResultDetailViewRowFullView(dept: dept, result: result)
                        }
                        .buttonStyle(.plain)
                        if dept.id != fullDepts.last?.id {
                            Divider()
                                .padding(.vertical, 3)
                        }
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: Color(.label).opacity(0.1),radius: 5)
                .padding(.horizontal)
                
                // MARK: - NODATA
                
                HStack{
                    Text("無資料校系")
                    Spacer()
                    Text("\(nodataDepts.count) 個校系")
                }
                .font(.caption)
                .foregroundStyle(Color(.systemGray2))
                .padding(.vertical, 5)
                .padding(.horizontal)
                
                LazyVStack(alignment: .leading){
                    ForEach(nodataDepts) { dept in
                        NavigationLink(destination: ResultDeptView(department: dept, grade: result)){
                            ResultDetailViewRowNodataView(dept: dept, result: result)
                        }
                        .buttonStyle(.plain)
                        if dept.id != nodataDepts.last?.id {
                            Divider()
                                .padding(.vertical, 3)
                        }
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: Color(.label).opacity(0.1),radius: 5)
                .padding(.horizontal)
                
                // MARK: - NOPASS
                
                HStack{
                    Text("未通過檢定")
                        .font(.caption)
                        .foregroundStyle(Color(.systemGray2))
                        .padding(.vertical, 5)
                    Spacer()
                    Text("\(nopassDepts.count) 個校系")
                }
                .font(.caption)
                .foregroundStyle(Color(.systemGray2))
                .padding(.vertical, 5)
                .padding(.horizontal)
                
                LazyVStack(alignment: .leading){
                    ForEach(nopassDepts) { dept in
                        NavigationLink(destination: ResultDeptView(department: dept, grade: result)){
                            ResultDetailViewRowNopassView(dept: dept, result: result)
                        }
                        .buttonStyle(.plain)
                        if dept.id != nopassDepts.last?.id {
                            Divider()
                                .padding(.vertical, 3)
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
        .navigationTitle(result.dataName)
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            if shouldDelete {
                if let index = userData.userData.grade.firstIndex(where: { $0.id == result.id }) {
                    userData.userData.grade.remove(at: index)
                }
            }
        }
        .onAppear {
            updateDepts()
        }
        .sheet(isPresented: $showFilter){
            ResultDetailViewFilterView(searchFilter: $searchFilter, searchScore: $searchScore)
        }
        
    }
    
    private func updateDepts() {
        
        fullDepts = result.analyse.filter { dept in
            let matchType = (dept.calculatedType == .normal)
            let matchText = searchText.isEmpty || dept.fullname.contains(searchText) || dept.code.contains(searchText)
            let matchFilter = searchFilter.isEmpty || searchFilter.contains { filter in dept.fullname.contains(filter)}
            let matchScore = dept.calculatedPercent >= searchScore
            return matchType && matchText && matchFilter && matchScore
        }
        
        nodataDepts = result.analyse.filter { dept in
            let matchType = (dept.calculatedType == .nodata)
            let matchText = searchText.isEmpty || dept.fullname.contains(searchText) || dept.code.contains(searchText)
            let matchFilter = searchFilter.isEmpty || searchFilter.contains { filter in dept.fullname.contains(filter)}
            return matchType && matchText && matchFilter
        }
        
        nopassDepts = result.analyse.filter { dept in
            let matchType = (dept.calculatedType == .nopass)
            let matchText = searchText.isEmpty || dept.fullname.contains(searchText) || dept.code.contains(searchText)
            let matchFilter = searchFilter.isEmpty || searchFilter.contains { filter in dept.fullname.contains(filter)}
            return matchType && matchText && matchFilter
        }
    }
}

struct ResultDetailViewRowFullView: View {
    let dept: Departments
    let result: UserGrade
    var body: some View {
        HStack(spacing: 15){
            VStack(alignment: .leading){
                Text(dept.schoolname)
                Text(dept.departmentname)
            }
            Spacer()
            VStack(alignment: .trailing){
                Text(String(format: "%.0f%%", dept.calculatedPercent * 100))
                    .monospaced()
                switch(dept.calculatedPercent * 100){
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
            Image(systemName: "chevron.right")
                .resizable()
                .scaledToFit()
                .frame(height: 10)
                .foregroundStyle(Color(.systemGray3))
        }
        .contentShape(Rectangle())
    }
}

struct ResultDetailViewRowNodataView: View {
    let dept: Departments
    let result: UserGrade
    var body: some View {
        HStack(spacing: 15){
            VStack(alignment: .leading){
                Text(dept.schoolname)
                Text(dept.departmentname)
            }
            Spacer()
            VStack(alignment: .trailing){
                Text("--")
                    .monospaced()
                Text("無資料")
                    .font(.caption)
                    .foregroundColor(Color(.systemGray))
            }
            Image(systemName: "chevron.right")
                .resizable()
                .scaledToFit()
                .frame(height: 10)
                .foregroundStyle(Color(.systemGray3))
        }
        .contentShape(Rectangle())
    }
}

struct ResultDetailViewRowNopassView: View {
    let dept: Departments
    let result: UserGrade
    var body: some View {
        HStack(spacing: 15){
            VStack(alignment: .leading){
                Text(dept.schoolname)
                Text(dept.departmentname)
            }
            Spacer()
            VStack(alignment: .trailing){
                Text("--")
                    .monospaced()
                Text("未過檢定")
                    .font(.caption)
                    .foregroundColor(Color(.systemGray))
            }
            Image(systemName: "chevron.right")
                .resizable()
                .scaledToFit()
                .frame(height: 10)
                .foregroundStyle(Color(.systemGray3))
        }
        .contentShape(Rectangle())
    }
}

struct ResultDetailViewFilterView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var searchFilter: [String]
    @Binding var searchScore: Double
    
    @State private var tempSliderValue: Double = 0.0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15){
            Color.clear.frame(height: 5)
            
            ZStack{
                HStack{
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(Color(.systemGray2))
                    }
                }
                HStack{
                    Spacer()
                    Text("篩選器")
                        .font(.title2)
                        .bold()
                    Spacer()
                }
            }
            .padding(.horizontal)
            
            ScrollView{
                VStack(alignment: .leading, spacing: 15){
                    
                    Divider()
                        .padding(.horizontal)
                    
                    Text("錄取機率")
                        .bold()
                        .font(.title3)
                        .padding(.horizontal)
                    HStack(spacing: 5){
                        Slider(
                            value: $tempSliderValue,
                            in: 0.0...1.0,
                            step: 0.01
                        ) { editing in
                            if (!editing){
                                searchScore = tempSliderValue
                            }
                        }
                        Text(String(format: "%.0f%%", tempSliderValue*100))
                            .monospaced()
                        Text("以上")
                    }
                    .padding(.horizontal)
                    
                    Divider()
                        .padding(.horizontal)
                    
                    Text("學校")
                        .bold()
                        .font(.title3)
                        .padding(.horizontal)
                    FlowLayout{
                        filterItem("國立臺灣大學")
                        filterItem("國立成功大學")
                        filterItem("國立清華大學")
                        filterItem("國立陽明交通大學")
                        filterItem("國立政治大學")
                        filterItem("國立中山大學")
                        filterItem("國立中興大學")
                        filterItem("國立中正大學")
                        filterItem("國立中央大學")
                        filterItem("國立臺灣師範大學")
                        filterItem("國立臺北大學")
                        filterItem("國立高雄大學")
                        filterItem("國立嘉義大學")
                        filterItem("國立東華大學")
                        filterItem("國立暨南國際大學")
                        filterItem("國立彰化師範大學")
                        filterItem("國立高雄師範大學")
                        filterItem("國立臺灣海洋大學")
                        filterItem("國立宜蘭大學")
                        filterItem("國立聯合大學")
                        filterItem("國立屏東大學")
                        filterItem("國立臺中教育大學")
                        filterItem("國立臺北教育大學")
                        filterItem("國立臺南大學")
                        filterItem("國立臺東大學")
                        filterItem("國立體育大學")
                        filterItem("國立臺灣藝術大學")
                        filterItem("國立臺灣體育運動大學")
                        filterItem("國立臺南藝術大學")
                        filterItem("國立金門大學")

                        // 私立大學
                        filterItem("臺北醫學大學")
                        filterItem("長庚大學")
                        filterItem("輔仁大學")
                        filterItem("東吳大學")
                        filterItem("中原大學")
                        filterItem("東海大學")
                        filterItem("淡江大學")
                        filterItem("逢甲大學")
                        filterItem("中國醫藥大學")
                        filterItem("高雄醫學大學")
                        filterItem("中山醫學大學")
                        filterItem("中國文化大學")
                        filterItem("靜宜大學")
                        filterItem("大同大學")
                        filterItem("元智大學")
                        filterItem("大葉大學")
                        filterItem("中華大學")
                        filterItem("義守大學")
                        filterItem("銘傳大學")
                        filterItem("世新大學")
                        filterItem("實踐大學")
                        filterItem("長榮大學")
                        filterItem("南華大學")
                        filterItem("玄奘大學")
                        filterItem("真理大學")
                        filterItem("慈濟大學")
                        filterItem("佛光大學")
                        filterItem("亞洲大學")
                        filterItem("馬偕醫學院")
                        filterItem("康寧大學")
                    }
                    .padding(.horizontal)
                    
                    Divider()
                        .padding(.horizontal)
                    
                    Text("科系")
                        .bold()
                        .font(.title3)
                        .padding(.horizontal)
                    FlowLayout{
                        filterItem("醫學系")
                        filterItem("牙醫學系")
                        filterItem("藥學系")
                        filterItem("電機")
                        filterItem("資訊")
                        filterItem("法律")
                        filterItem("財務")
                        filterItem("企業管理")
                        filterItem("經濟")
                        filterItem("土木")
                        filterItem("機械")
                        filterItem("材料")
                        filterItem("公費")
                    }
                    .padding(.horizontal)
                    
                    Divider()
                        .padding(.horizontal)
                    
                    HStack{
                        Spacer()
                        Button {
                            searchScore = 0
                            searchFilter = []
                        } label: {
                            Text("清除所有篩選器")
                                .padding(5)
                                .padding(.horizontal)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.horizontal)
                        Spacer()
                    }
                }
            }
        }
        .onAppear {
            tempSliderValue = searchScore
        }
    }
    
    private func filterItem(_ option: String) -> some View {
        HStack{
            Text(option)
        }
        .padding(10)
        .clipShape(Capsule())
        .overlay(
            Group{
                if searchFilter.contains(option) {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.accentColor, lineWidth: 2)
                } else {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray5), lineWidth: 1)
                }
            }
        )
        .onTapGesture {
            if searchFilter.contains(option) {
                searchFilter.removeAll { $0 == option }
            } else {
                searchFilter.append(option)
            }
        }
    }
}

#Preview {
    NavigationStack{
        ResultDetailView(result: UserData().userData.grade.first!)
    }
}

