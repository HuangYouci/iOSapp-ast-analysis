//
//  ChoiceView.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/3/25.
//

import SwiftUI

struct ChoiceView: View {
    
    @EnvironmentObject private var userData: UserData
    
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading){
                Text("志願選擇")
                    .font(.largeTitle)
                    .bold()
                Text("分發入學一百志願選填")
                    .foregroundStyle(Color(.systemGray))
            }
            .padding(.bottom, 10)
            ScrollView{
                ForEach(0..<100){ i in
                    if let department = userData.userData.choDept[i] {
                        HStack{
                            Text("#\(i+1)")
                                .frame(width: 40)
                            DepartmentListRowView(department: department, grade: UserGrade(id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!, dataName: "無資料", GsatCH: -1, GsatEN: -1, GsatMA: -1, GsatMB: -1, GsatSO: -1, GsatSC: -1, GsatEL: -1, AstMA: -1, AstMB: -1, AstPH: -1, AstCH: -1, AstBI: -1, AstHI: -1, AstGE: -1, AstSO: -1, SpecialType: -1, SpecialPercentage: -1))
                        }
                    }
                }
                HStack{
                    Spacer()
                }
            }
        }
        .padding()
        .navigationTitle("志願選填")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ChoiceView()
        .environmentObject(UserData())
}
