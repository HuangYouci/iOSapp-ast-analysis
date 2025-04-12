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
        VStack(spacing: 0){
            
            HStack{
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 1)
            
            VStack{
                VStack(alignment: .leading){
                    HStack(alignment: .center){
                        VStack{
                            Text("已填寫志願")
                                .font(.caption)
                            Text("\(userData.userData.choDept.compactMap { $0 }.count) / 100")
                            .font(.title3)
                            .bold()
                            .lineLimit(1)
                        }
                        VStack{
                            Text("第一志願")
                                .font(.caption)
                            Text({
                                if let department = userData.userData.choDept[0] {
                                    return department.fullname
                                } else {
                                    return "尚未設置"
                                }
                            }())
                            .font(.title3)
                            .bold()
                        }
                        Spacer()
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
                
                ForEach(0..<100){ i in
                    if let department = userData.userData.choDept[i] {
                        HStack{
                            Text("#\(i+1)")
                                .frame(width: 40)
                            DepartmentListRowView(department: department, grade: UserGrade(id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!, dataName: "無資料", GsatCH: -1, GsatEN: -1, GsatMA: -1, GsatMB: -1, GsatSO: -1, GsatSC: -1, GsatEL: -1, AstMA: -1, AstMB: -1, AstPH: -1, AstCH: -1, AstBI: -1, AstHI: -1, AstGE: -1, AstSO: -1, SpecialType: -1, SpecialPercentage: -1))
                        }
                        .padding(.horizontal)
                    }
                }
                HStack{
                    Spacer()
                }
            }
            .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
            .background(Color(.secondarySystemBackground))
            
        }
        .navigationTitle("志願選填")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ChoiceView()
        .environmentObject(UserData())
}
