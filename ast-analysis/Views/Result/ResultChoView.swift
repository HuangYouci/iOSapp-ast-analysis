//
//  ResultChoView.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/6/5.
//

import SwiftUI

struct ResultChoView: View {
    
    @Binding var result: UserGrade
    
    private var depts: [Departments] {
        result.favDept.compactMap { code in
            result.analyse.first(where: { $0.code == code })
        }
    }
    
    private var deptsFirst: Departments? {
        let d = result.favDept.compactMap { code in
            result.analyse.first(where: { $0.code == code })
        }
        return d.first
    }
    
    private var deptsPossibleRange: [Int] {
        let d = result.favDept.compactMap { code in
            result.analyse.first(where: { $0.code == code })
        }
        var resultIndices: [Int] = []
        var startIndex: Int? = nil
        for (index, dept) in d.enumerated() {
            let percent = dept.calculatedPercent
            if startIndex == nil {
                if percent >= 0.45 {
                    startIndex = index
                    resultIndices.append(index)
                }
            } else {
                if percent >= 0.45 && percent < 0.60 {
                    resultIndices.append(index)
                } else {
                    return resultIndices
                }
            }
        }
        return resultIndices
    }
    
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
                            Text("志願數量")
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
                    Text("志願校系")
                    Spacer()
                    Text("\(depts.count) 個校系")
                }
                .font(.caption)
                .foregroundStyle(Color(.systemGray2))
                .padding(.vertical, 5)
                .padding(.horizontal)
                
                LazyVStack(alignment: .leading){
                    
                    ForEach(depts.indices, id: \.self) { index in
                        
                        HStack(spacing: 10){
                            VStack{
                                if (index != 0){
                                    Button {
                                        result.favDept.swapAt(index, index-1)
                                    } label: {
                                        Image(systemName: "chevron.up")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 15)
                                            .foregroundStyle(Color(.systemGray2))
                                    }
                                }
                                if (index == 0){
                                    Text("\(index+1)")
                                        .frame(width: 25)
                                        .monospaced()
                                        .foregroundStyle(Color.accentColor)
                                } else if (deptsPossibleRange.contains(index)){
                                    Text("\(index+1)")
                                        .frame(width: 25)
                                        .monospaced()
                                        .foregroundStyle(Color(.systemGreen))
                                } else {
                                    Text("\(index+1)")
                                        .frame(width: 25)
                                        .monospaced()
                                }
                                if (index+1 != depts.count){
                                    Button {
                                        result.favDept.swapAt(index, index+1)
                                    } label: {
                                        Image(systemName: "chevron.down")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 15)
                                            .foregroundStyle(Color(.systemGray2))
                                    }
                                }
                            }
                            ResultDetailViewRowView(dept: depts[index], result: $result)
                        }
                        if ((index < depts.count-1)) {
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
                
                TipView(keyName: "choDeptsTip", title: "志願校系功能", content:
                """
                志願校系功能說明：
                - 您可在各校系右上角點選愛心將其加入或移除最愛校系
                - 在最愛校系的校系會自動加入志願校系
                - 第一志願將標「橘色」
                - 系統預測可能的錄取區間為「綠色」
                - 請點選科系右方上或下進行排序
                
                分科測驗志願填寫說明：
                - 您只會錄取一個校系，正式選填時，有一百個志願可以填寫（本程式不會限制上限）。建議可依個人喜好程度，夢幻校系大膽填寫。
                """)
                
                Color.clear
                    .padding(.bottom, 5)
                
            }
            .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
            .background(Color(.secondarySystemBackground))
            
            
        }
        .navigationTitle("志願校系 - \(result.dataName)")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

