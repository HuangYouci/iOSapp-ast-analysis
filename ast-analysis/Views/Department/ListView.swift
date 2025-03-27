//
//  ListView.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/3/23.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject private var departmentData: DepartmentData
    var body: some View{
        DepartmentListView(departments: departmentData.departments, grade: UserGrade(id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!, dataName: "無資料", GsatCH: -1, GsatEN: -1, GsatMA: -1, GsatMB: -1, GsatSO: -1, GsatSC: -1, GsatEL: -1, AstMA: -1, AstMB: -1, AstPH: -1, AstCH: -1, AstBI: -1, AstHI: -1, AstGE: -1, AstSO: -1, SpecialType: -1, SpecialPercentage: -1), title: "科系列表")
            .toolbar(.hidden)
    }
}
