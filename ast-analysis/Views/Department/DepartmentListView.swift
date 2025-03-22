//
//  DepartmentListView.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/3/22.
//

import SwiftUI

struct DepartmentListView: View {
    
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
        VStack(alignment: .leading){
            VStack(alignment: .leading){
                Text(title)
                    .font(.largeTitle)
                    .bold()
                Text("共 \(filteredDepartments.count) 個校系")
                    .foregroundStyle(Color(.systemGray))
            }
            .padding()
            
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
            .padding(.horizontal)
            
            ScrollView {
                LazyVStack{
                    ForEach(filteredDepartments) { item in
                        NavigationLink(destination: DepartmentDetailView(department: item, grade: grade)){
                            HStack{
                                Text(item.fullname)
                                Spacer()
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(.systemGray6), lineWidth: 2)
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
        }
        .sheet(isPresented: $showFilter){
            DepartmentListFilterView(searchFilter: $searchFilter)
        }
    }
}

#Preview {
    NavigationStack{
        DepartmentListView(departments: DepartmentData().departments, grade: UserGrade(id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!, dataName: "無資料", GsatCH: -1, GsatEN: -1, GsatMA: -1, GsatMB: -1, GsatSO: -1, GsatSC: -1, GsatEL: -1, AstMA: -1, AstMB: -1, AstPH: -1, AstCH: -1, AstBI: -1, AstHI: -1, AstGE: -1, AstSO: -1, SpecialType: -1, SpecialPercentage: -1), title: "測試")
    }
}

struct DepartmentListFilterView: View {
    
    @Binding var searchFilter: [String]
    
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading){
                Text("篩選器")
                    .font(.title)
                    .bold()
                Text("已啟用 \(searchFilter.count) 個篩選")
                    .foregroundStyle(Color(.systemGray))
            }
            .padding(.bottom)
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
                        filterItem("國立陽明交通大學")
                        filterItem("國立清華大學")
                        filterItem("國立政治大學")
                        filterItem("國立中央大學")
                        filterItem("國立中興大學")
                        filterItem("國立中正大學")
                        filterItem("國立中山大學")
                        filterItem("國立臺北大學")
                        filterItem("國立臺灣師範大學")
                        filterItem("國立彰化師範大學")
                        filterItem("國立高雄師範大學")
                        filterItem("國立臺灣海洋大學")
                        filterItem("國立暨南國際大學")
                        filterItem("國立高雄大學")
                        filterItem("國立東華大學")
                        filterItem("國立屏東大學")
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
