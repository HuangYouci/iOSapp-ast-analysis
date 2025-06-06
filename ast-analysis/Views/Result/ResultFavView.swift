//
//  ResultFavView.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/6/5.
//

import SwiftUI

struct ResultFavView: View {
    
    @Binding var result: UserGrade
    
    @State private var depts: [Departments] = []
    
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
                            Text("校系數量")
                                .font(.caption)
                            Text("\(depts.count)")
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
                
                HStack{
                    Text("喜愛校系")
                    Spacer()
                    Text("\(depts.count) 個校系")
                }
                .font(.caption)
                .foregroundStyle(Color(.systemGray2))
                .padding(.vertical, 5)
                .padding(.horizontal)
                
                LazyVStack(alignment: .leading){
                    
                    ForEach(depts) { dept in
                        ResultDetailViewRowView(dept: dept, result: $result)
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
        .navigationTitle("最愛校系 - \(result.dataName)")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            update()
        }
        .onChange(of: result.favDept){ _ in
            update()
        }
    }
    
    private func update() {
        depts = {
            result.favDept.compactMap { code in
                result.analyse.first(where: { $0.code == code })
            }
            .sorted(by: { $0.calculatedPercent < $1.calculatedPercent })
        }()
    }
}
