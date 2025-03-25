//
//  EachResultView.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/3/22.
//

import SwiftUI

struct EachResultView: View {
    let resultID: UUID
    
    @EnvironmentObject var departmentData: DepartmentData
    @EnvironmentObject var userData: UserData
    @Environment(\.dismiss) var dismiss
    
    @State private var editNameField: String = ""
    @State private var expandedInfo: Bool = false
    @State private var confirmEdit: Bool = false
    @State private var editName: Bool = false
    @State private var shouldDelete: Bool = false
    
    private var result: UserGrade {
        userData.userData.grade.first { $0.id == resultID }!
    }
    
    var body: some View {
        
        VStack {
            VStack(alignment: .leading) {
                HStack{
                    if editName {
                        TextField(result.dataName, text: $editNameField)
                            .font(.title3)
                            .bold()
                    } else {
                        Text(result.dataName)
                            .font(.title3)
                            .bold()
                    }
                    Spacer()
                    Image(systemName: expandedInfo ? "chevron.up" : "chevron.right")
                        .foregroundStyle(Color(.systemGray2))
                }
                Divider()
                if expandedInfo {
                    Text("學科能力測驗")
                        .font(.caption)
                        .foregroundStyle(Color(.systemGray2))
                        .padding(.vertical, 5)
                    FlowLayout{
                        HStack{
                            Text("國文")
                            if result.GsatCH >= 0 { Text("\(result.GsatCH) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                        }
                        HStack{
                            Text("英文")
                            if result.GsatEN >= 0 { Text("\(result.GsatEN) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                        }
                        HStack{
                            Text("數Ａ")
                            if result.GsatMA >= 0 { Text("\(result.GsatMA) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                        }
                        HStack{
                            Text("數Ｂ")
                            if result.GsatMB >= 0 { Text("\(result.GsatMB) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                        }
                        HStack{
                            Text("自然")
                            if result.GsatSC >= 0 { Text("\(result.GsatSC) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                        }
                        HStack{
                            Text("社會")
                            if result.GsatSO >= 0 { Text("\(result.GsatSO) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
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
                            if result.AstMA >= 0 { Text("\(result.AstMA) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                        }
                        HStack{
                            Text("數乙")
                            if result.AstMB >= 0 { Text("\(result.AstMB) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                        }
                        HStack{
                            Text("物理")
                            if result.AstPH >= 0 { Text("\(result.AstPH) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                        }
                        HStack{
                            Text("化學")
                            if result.AstCH >= 0 { Text("\(result.AstCH) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                        }
                        HStack{
                            Text("生物")
                            if result.AstBI >= 0 { Text("\(result.AstBI) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                        }
                        HStack{
                            Text("歷史")
                            if result.AstHI >= 0 { Text("\(result.AstHI) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                        }
                        HStack{
                            Text("地理")
                            if result.AstGE >= 0 { Text("\(result.AstGE) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                        }
                        HStack{
                            Text("公民")
                            if result.AstSO >= 0 { Text("\(result.AstSO) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
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
                                if let index = userData.userData.grade.firstIndex(where: { $0.id == resultID }) {
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
                        HStack{
                            
                                HStack{
                                    Text("國文")
                                    if result.GsatCH >= 0 { Text("\(result.GsatCH) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                }
                                HStack{
                                    Text("英文")
                                    if result.GsatEN >= 0 { Text("\(result.GsatEN) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                }
                                HStack{
                                    Text("數Ａ")
                                    if result.GsatMA >= 0 { Text("\(result.GsatMA) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                }
                                HStack{
                                    Text("數Ｂ")
                                    if result.GsatMB >= 0 { Text("\(result.GsatMB) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                }
                                HStack{
                                    Text("自然")
                                    if result.GsatSC >= 0 { Text("\(result.GsatSC) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                }
                                HStack{
                                    Text("社會")
                                    if result.GsatSO >= 0 { Text("\(result.GsatSO) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                }
                            
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
                            
                            
                                HStack{
                                    Text("數甲")
                                    if result.AstMA >= 0 { Text("\(result.AstMA) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                }
                                HStack{
                                    Text("數乙")
                                    if result.AstMB >= 0 { Text("\(result.AstMB) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                }
                                HStack{
                                    Text("物理")
                                    if result.AstPH >= 0 { Text("\(result.AstPH) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                }
                                HStack{
                                    Text("化學")
                                    if result.AstCH >= 0 { Text("\(result.AstCH) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                }
                                HStack{
                                    Text("生物")
                                    if result.AstBI >= 0 { Text("\(result.AstBI) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                }
                                HStack{
                                    Text("歷史")
                                    if result.AstHI >= 0 { Text("\(result.AstHI) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                }
                                HStack{
                                    Text("地理")
                                    if result.AstGE >= 0 { Text("\(result.AstGE) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                }
                                HStack{
                                    Text("公民")
                                    if result.AstSO >= 0 { Text("\(result.AstSO) 級") } else { Text("未報考").foregroundStyle(Color(.systemGray)) }
                                }
                            
                            Text("加分")
                                .font(.caption)
                                .foregroundStyle(Color(.systemGray2))
                            Text("\(result.SpecialPercentage) %")
                                .bold()
                            
                        }
                    }
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.systemGray6), lineWidth: 2)
            )
            .shadow(color: Color(.label).opacity(0.1),radius: 5)
            .onTapGesture {
                withAnimation(.easeInOut){
                    expandedInfo.toggle()
                }
            }
            .padding(.horizontal)
            
            ScrollView{
                Text("錄取機率分析僅供參考，分科志願填寫無需過於斟酌，按自己喜歡依序填寫即可。僅能計算去年有資料的校系之錄取機率分析。")
                    .multilineTextAlignment(.center)
                    .font(.caption)
                    .foregroundStyle(Color(.systemGray2))
                    .padding(20)
                if result.analyse.count > 2 {
                    NavigationLink(destination: DepartmentListView(departments: result.analyse[2], grade: result, title: "保底志願")){
                        VStack{
                            HStack{
                                Text("保底")
                                    .font(.title)
                                    .bold()
                                VStack(alignment: .leading){
                                    Text("錄取機率 80% 以上")
                                    Divider()
                                    Text("共有 \(result.analyse[2].count) 個校系")
                                }
                                .padding(.horizontal, 5)
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(Color(.systemGray2))
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.systemGray6), lineWidth: 2)
                        )
                        .shadow(color: Color(.label).opacity(0.1),radius: 5)
                        .padding(.horizontal)
                    }
                }
                if result.analyse.count > 3 {
                    NavigationLink(destination: DepartmentListView(departments: result.analyse[3], grade: result, title: "安全志願")){
                        VStack{
                            HStack{
                                Text("安全")
                                    .font(.title)
                                    .bold()
                                VStack(alignment: .leading){
                                    Text("錄取機率 60% 至 80%")
                                    Divider()
                                    Text("共有 \(result.analyse[3].count) 個校系")
                                }
                                .padding(.horizontal, 5)
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(Color(.systemGray2))
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.systemGray6), lineWidth: 2)
                        )
                        .shadow(color: Color(.label).opacity(0.1),radius: 5)
                        .padding(.horizontal)
                    }
                }
                if result.analyse.count > 4 {
                    NavigationLink(destination: DepartmentListView(departments: result.analyse[4], grade: result, title: "一般志願")){
                        VStack{
                            HStack{
                                Text("一般")
                                    .font(.title)
                                    .bold()
                                VStack(alignment: .leading){
                                    Text("錄取機率 40% 至 60%")
                                    Divider()
                                    Text("共有 \(result.analyse[4].count) 個校系")
                                }
                                .padding(.horizontal, 5)
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(Color(.systemGray2))
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.systemGray6), lineWidth: 2)
                        )
                        .shadow(color: Color(.label).opacity(0.1),radius: 5)
                        .padding(.horizontal)
                    }
                }
                if result.analyse.count > 5 {
                    NavigationLink(destination: DepartmentListView(departments: result.analyse[5], grade: result, title: "進攻志願")){
                        VStack{
                            HStack{
                                Text("進攻")
                                    .font(.title)
                                    .bold()
                                VStack(alignment: .leading){
                                    Text("錄取機率 20% 至 40%")
                                    Divider()
                                    Text("共有 \(result.analyse[5].count) 個校系")
                                }
                                .padding(.horizontal, 5)
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(Color(.systemGray2))
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.systemGray6), lineWidth: 2)
                        )
                        .shadow(color: Color(.label).opacity(0.1),radius: 5)
                        .padding(.horizontal)
                    }
                }
                if result.analyse.count > 6 {
                    NavigationLink(destination: DepartmentListView(departments: result.analyse[6], grade: result, title: "夢幻志願")){
                        VStack{
                            HStack{
                                Text("夢幻")
                                    .font(.title)
                                    .bold()
                                VStack(alignment: .leading){
                                    Text("錄取機率 20% 以下")
                                    Divider()
                                    Text("共有 \(result.analyse[6].count) 個校系")
                                }
                                .padding(.horizontal, 5)
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(Color(.systemGray2))
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.systemGray6), lineWidth: 2)
                        )
                        .shadow(color: Color(.label).opacity(0.1),radius: 5)
                        .padding(.horizontal)
                    }
                }
                
                Text("完整校系資料")
                    .multilineTextAlignment(.center)
                    .font(.caption)
                    .foregroundStyle(Color(.systemGray2))
                    .padding(20)
                
                NavigationLink(destination: EachResultReasonView(resultID: resultID)){
                    VStack{
                        HStack{
                            Text("未通過檢定之校系")
                                .bold()
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color(.systemGray2))
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemGray6), lineWidth: 2)
                    )
                    .shadow(color: Color(.label).opacity(0.1),radius: 5)
                    .padding(.horizontal)
                }
                if result.analyse.count > 1 {
                    NavigationLink(destination: DepartmentListView(departments: result.analyse[1], grade: result, title: "所有通過檢定之校系")){
                        VStack{
                            HStack{
                                Text("所有通過檢定之校系")
                                    .font(.title3)
                                    .bold()
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(Color(.systemGray2))
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.systemGray6), lineWidth: 2)
                        )
                        .shadow(color: Color(.label).opacity(0.1),radius: 5)
                        .padding(.horizontal)
                    }
                }
            }
        }
        .navigationTitle(result.dataName)
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            if shouldDelete {
                if let index = userData.userData.grade.firstIndex(where: { $0.id == resultID }) {
                    userData.userData.grade.remove(at: index)
                }
            }
        }
        
    }
    
}

#Preview {
    return EachResultView(resultID: UserData().userData.grade.first!.id)
        .environmentObject(UserData()) // 提供 EnvironmentObject
}
