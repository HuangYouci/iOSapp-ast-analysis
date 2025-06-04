//
//  ListView.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/3/23.
//

import SwiftUI

struct ListView: View {
    // 上一步
    @Environment(\.dismiss) var dismiss
    
    // UI 功能：改名、展開、刪除
    @State private var searchText: String = ""              // 搜尋關鍵詞
    @State private var showFilter: Bool = false             // 是否打開篩選器
    @State private var searchFilter: [String] = []          // 搜尋學校詞
    @State private var depts: [Departments] = []
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            HStack{
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 1)
            
            VStack{
                VStack(alignment: .leading){
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
                                if (!searchFilter.isEmpty){
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
                    
                    TipView(keyName: "lagtips",
                            title: "大量資料",
                            content: "在沒有任何篩選器下，本頁面會顯示全部約兩千筆資料，快速滑動可能會導致卡頓。請斟酌啟用篩選器！")
                    
                }
                .padding(.top, 15)
                
                // MARK: - FULL RESULT
                HStack{
                    Text("校系列表")
                    Spacer()
                    Text("\(depts.count) 個校系")
                }
                .font(.caption)
                .foregroundStyle(Color(.systemGray2))
                .padding(.vertical, 5)
                .padding(.horizontal)
                
                LazyVStack(alignment: .leading){
                    ForEach(depts) { dept in
                        NavigationLink(destination: DeptView(department: dept)){
                            ListViewRowView(dept: dept)
                        }
                        .buttonStyle(.plain)
                        if dept.id != depts.last?.id {
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
        .navigationTitle("校系列表")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            updateDepts()
        }
        .sheet(isPresented: $showFilter){
            ListViewFilterView(searchFilter: $searchFilter)
        }
        
    }
    
    private func updateDepts() {
        
        depts = DepartmentData.shared.departments.filter { dept in
            let matchText = searchText.isEmpty || dept.fullname.contains(searchText) || dept.code.contains(searchText)
            let matchFilter = searchFilter.isEmpty || searchFilter.contains { filter in dept.fullname.contains(filter)}
            return matchText && matchFilter
        }
        
    }
}

struct ListViewRowView: View {
    let dept: Departments
    var body: some View {
        HStack(spacing: 15){
            VStack(alignment: .leading){
                Text(dept.schoolname)
                Text(dept.departmentname)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .resizable()
                .scaledToFit()
                .frame(height: 10)
                .foregroundStyle(Color(.systemGray3))
        }
        .contentShape(Rectangle())
    }
}

struct ListViewFilterView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var searchFilter: [String]
    
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
    ListView()
}
