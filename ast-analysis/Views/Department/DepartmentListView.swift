//
//  DepartmentListView.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/3/22.
//

import SwiftUI

struct DepartmentListView: View {
    
    @EnvironmentObject private var userData: UserData
    let departments: [Departments]
    let grade: UserGrade
    let title: String
    
    @State private var showFilter: Bool = false
    @State private var searchText: String = ""
    @State private var searchFilter: [String] = []
    
    private var filteredDepartments: [Departments] {
        departments.filter { department in
            
            let matchesSearchText = searchText.isEmpty || department.fullname.contains(searchText) || department.code.contains(searchText)
            
            let matchesFilter = searchFilter.isEmpty || searchFilter.contains { filter in
                department.fullname.contains(filter)
            }
            
            // 結合條件：同時滿足搜尋框和篩選器
            return matchesSearchText && matchesFilter
        }
    }
    
    var body: some View{
        VStack(alignment: .leading, spacing: 0){
            
            HStack{
                Text(title)
                    .font(.largeTitle)
                    .bold()
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            
            VStack{
                VStack(alignment: .leading){
                    HStack(alignment: .center){
                        VStack{
                            Text("校系數量")
                                .font(.caption)
                            Text("\(departments.count)")
                            .font(.title3)
                            .bold()
                        }
                        
                        if (filteredDepartments.count < departments.count){
                            VStack{
                                Text("已篩選校系")
                                    .font(.caption)
                                Text("\(filteredDepartments.count)")
                                    .font(.title3)
                                    .bold()
                            }
                        }
                        if (!searchText.isEmpty) {
                            VStack{
                                Text("搜尋字詞")
                                    .font(.caption)
                                Text("\(searchText)")
                                    .font(.title3)
                                    .bold()
                                    .lineLimit(1)
                            }
                        }
                        if searchFilter.count > 0 {
                            VStack{
                                Text("篩選器")
                                    .font(.caption)
                                Text("\(searchFilter.count)")
                                    .font(.title3)
                                    .bold()
                            }
                        }
                        Spacer()
                        
                    }
                    HStack{
                        TextField("搜尋關鍵字或代碼", text: $searchText)
                            .padding(10)
                            .background(Color(.systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(.systemGray6), lineWidth: 2)
                            )
                        Button {
                            showFilter = true
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .padding(10)
                                .background(Color(.systemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(.systemGray6), lineWidth: 2)
                                )
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
            
            ScrollView {
                
                Color.clear
                .padding(.bottom, 5)
                
                LazyVStack{
                    ForEach(filteredDepartments) { department in
                        DepartmentListRowView(department: department, grade: grade)
                    }
                }
                .padding()
            }
            .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
            .background(Color(.secondarySystemBackground))
        }
        .sheet(isPresented: $showFilter){
            DepartmentListFilterView(searchFilter: $searchFilter)
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack{
        DepartmentListView(departments: DepartmentData().departments, grade: UserGrade(id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!, dataName: "無資料", GsatCH: -1, GsatEN: -1, GsatMA: -1, GsatMB: -1, GsatSO: -1, GsatSC: -1, GsatEL: -1, AstMA: -1, AstMB: -1, AstPH: -1, AstCH: -1, AstBI: -1, AstHI: -1, AstGE: -1, AstSO: -1, SpecialType: -1, SpecialPercentage: -1), title: "測試")
    }
}

struct DepartmentListFilterView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var searchFilter: [String]
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                VStack(alignment: .leading){
                    Text("篩選器")
                        .font(.title)
                        .bold()
                    Text("已啟用 \(searchFilter.count) 個篩選")
                        .foregroundStyle(Color(.systemGray))
                }
                .padding(.bottom)
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
            }
            ScrollView{
                VStack(alignment: .leading){
                    Text("大學")
                        .font(.caption)
                        .foregroundStyle(Color(.systemGray2))
                        .padding(.vertical, 5)
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
                    Text("科系")
                        .font(.caption)
                        .foregroundStyle(Color(.systemGray2))
                        .padding(.vertical, 5)
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
                    .padding(1)
                }
            }
        }
        .padding()
    }
    
    private func filterItem(_ option: String) -> some View {
        Text(option)
            .padding(10)
            .background(Color( searchFilter.contains(option) ? .systemGray5 : .systemBackground ))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.systemGray6), lineWidth: 2)
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

struct DepartmentListRowView: View {
    
    let department: Departments
    let grade: UserGrade
    @EnvironmentObject private var userData: UserData
    @State private var isAddChoice: Bool = false
    @State private var targetChoiceOrder: String = ""
    
    var body: some View {
        NavigationLink(destination: DepartmentDetailView(department: department, grade: grade)){
            HStack{
                Text(department.fullname)
                Spacer()
            }
            .padding()
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: Color(.label).opacity(0.1),radius: 5)
            .contextMenu {
                Button(action: {
                    if userData.userData.favDept.contains(where: { $0.id == department.id }) {
                        userData.userData.favDept.removeAll { $0.id == department.id }
                    } else {
                        userData.userData.favDept.append(department)
                    }
                }) {
                    if userData.userData.favDept.contains(where: { $0.id == department.id }) {
                        Label("移除最愛", systemImage: "heart.fill")
                    } else {
                        Label("加入最愛", systemImage: "heart")
                    }
                }
                Button(action: {
                    if let index = userData.userData.choDept.firstIndex(where: { $0?.id == department.id }) {
                        userData.userData.choDept[index] = nil
                        } else {
                        isAddChoice = true
                    }
                }) {
                    if userData.userData.choDept.contains(where: { $0?.id == department.id }) {
                        Label("移除志願", systemImage: "minus")
                    } else {
                        Label("加入志願", systemImage: "plus")
                    }
                }
            } preview: {
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
                    Divider()
                    VStack(alignment: .leading){
                        HStack(alignment: .center){
                            Image(systemName: "magnifyingglass")
                            Text("檢定標準")
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
                    VStack(alignment: .leading){
                        HStack(alignment: .center){
                            Image(systemName: "line.3.horizontal.decrease")
                            Text("採計科目")
                        }
                        .bold()
                        .padding(.bottom, 10)
                        
                        HStack{
                            VStack{
                                Text("科目")
                                Text("倍率")
                            }
                            .bold()
                            
                            if !department.gsatchinese.isEmpty {
                                VStack{
                                    Text("國文")
                                    Text(department.gsatchinese)
                                }
                            }
                            if !department.gsatenglish.isEmpty {
                                VStack{
                                    Text("英文")
                                    Text(department.gsatenglish)
                                }
                            }
                            if !department.gsatmatha.isEmpty {
                                VStack{
                                    Text("數Ａ")
                                    Text(department.gsatmatha)
                                }
                            }
                            if !department.gsatmathb.isEmpty {
                                VStack{
                                    Text("數Ｂ")
                                    Text(department.gsatmathb)
                                }
                            }
                            if !department.gsatscience.isEmpty {
                                VStack{
                                    Text("自然")
                                    Text(department.gsatscience)
                                }
                            }
                            if !department.gsatsocial.isEmpty {
                                VStack{
                                    Text("社會")
                                    Text(department.gsatsocial)
                                }
                            }
                            if !department.matha.isEmpty {
                                VStack{
                                    Text("數甲")
                                    Text(department.matha)
                                }
                            }
                            if !department.mathb.isEmpty {
                                VStack{
                                    Text("數乙")
                                    Text(department.mathb)
                                }
                            }
                            if !department.physics.isEmpty {
                                VStack{
                                    Text("物理")
                                    Text(department.physics)
                                }
                            }
                            if !department.chemistry.isEmpty {
                                VStack{
                                    Text("化學")
                                    Text(department.chemistry)
                                }
                            }
                            if !department.biology.isEmpty {
                                VStack{
                                    Text("生物")
                                    Text(department.biology)
                                }
                            }
                            if !department.history.isEmpty {
                                VStack{
                                    Text("歷史")
                                    Text(department.history)
                                }
                            }
                            if !department.geometry.isEmpty {
                                VStack{
                                    Text("地理")
                                    Text(department.geometry)
                                }
                            }
                            if !department.social.isEmpty {
                                VStack{
                                    Text("公民")
                                    Text(department.social)
                                }
                            }
                            
                        }
                        
                    }
                    .padding()
                    Divider()
                        .padding(.bottom, 5)
                    
                    if let position = userData.userData.choDept.firstIndex(where: { $0?.id == department.id }){
                        Text("本科系在志願序 #\(position+1)")
                    } else {
                        Text("本科系未在志願序中")
                    }
                }
                .frame(width: 350)
                .padding()
            }
            .alert("加入志願", isPresented: $isAddChoice){
                TextField("志願序（1-100）", text: $targetChoiceOrder)
                        .keyboardType(.numberPad)
                Button("確定") {
                    if let index = Int(targetChoiceOrder), index >= 1, index <= 100 {
                        userData.userData.choDept[index-1] = department
                    }
                    // 重置狀態
                    targetChoiceOrder = ""
                    isAddChoice = false
                }
                Button("取消", role: .cancel) {
                    targetChoiceOrder = ""
                    isAddChoice = false
                }
            } message: {
                Text("請輸入要加入的志願序（1-100），若該志願序有校系，將會取代它。")
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
