//
//  GuessView.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/3/27.
//

import SwiftUI

struct GuessView: View {
    @EnvironmentObject private var userData: UserData
    @EnvironmentObject private var departmentData: DepartmentData
    var body: some View {
        VStack(alignment: .leading){
            
            VStack(alignment: .leading){
                Text("差距分析")
                    .font(.largeTitle)
                    .bold()
                Text("預測分科要考幾級才會上")
                    .foregroundStyle(Color(.systemGray))
            }
            .padding()
            VStack{
                HStack{
                    Image(systemName: "info.circle")
                    Text("本功能是計算您在現有成績與目標校系的尚缺分數差異。")
                }
                Divider()
                    .padding(.vertical, 3)
                Text("若要在分科考前以既有學測成績分析差距，請在「成績輸入」處輸入一個「僅有學測成績（轉換六十幾分制）」的資料，並產生結果，再到者裡選擇該分析結果。")
                    .font(.caption)
                    .foregroundStyle(Color(.systemGray2))
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
            
            ScrollView{
                LazyVStack{
                    if userData.userData.grade.isEmpty {
                        HStack{
                            Spacer()
                            Text("尚無分析資料")
                                .foregroundStyle(Color(.systemGray2))
                            Spacer()
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
                    FlowLayout{
                        ForEach(userData.userData.grade) { item in
                            NavigationLink(destination: GuessDetailView(grade: item)) {
                                VStack(alignment: .leading){
                                    HStack{
                                        Text(item.dataName)
                                            .font(.title3)
                                            .bold()
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundStyle(Color(.systemGray2))
                                    }
                                    Divider()
                                        .padding(.bottom, 5)
                                    ScrollView(.horizontal){
                                        HStack{
                                            
                                            if item.GsatCH >= 0 {
                                                Text("國文 \(item.GsatCH)")
                                                    .padding(5)
                                                    .background(Color(.systemGray5))
                                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                            }
                                            if item.GsatEN >= 0 {
                                                Text("英文 \(item.GsatEN)")
                                                    .padding(5)
                                                    .background(Color(.systemGray5))
                                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                            }
                                            if item.GsatMA >= 0 {
                                                Text("數Ａ \(item.GsatMA)")
                                                    .padding(5)
                                                    .background(Color(.systemGray5))
                                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                            }
                                            if item.GsatMB >= 0 {
                                                Text("數Ｂ \(item.GsatMB)")
                                                    .padding(5)
                                                    .background(Color(.systemGray5))
                                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                            }
                                            if item.GsatSC >= 0 {
                                                Text("自然 \(item.GsatSC)")
                                                    .padding(5)
                                                    .background(Color(.systemGray5))
                                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                            }
                                            if item.GsatSO >= 0 {
                                                Text("社會 \(item.GsatSO)")
                                                    .padding(5)
                                                    .background(Color(.systemGray5))
                                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                            }
                                            if item.GsatEL >= 0 {
                                                switch item.GsatEL {
                                                case 3:
                                                    Text("英聽 A")
                                                        .padding(5)
                                                        .background(Color(.systemGray5))
                                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                                case 2:
                                                    Text("英聽 B")
                                                        .padding(5)
                                                        .background(Color(.systemGray5))
                                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                                case 1:
                                                    Text("英聽 C")
                                                        .padding(5)
                                                        .background(Color(.systemGray5))
                                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                                default:
                                                    Text("英聽 F")
                                                        .padding(5)
                                                        .background(Color(.systemGray5))
                                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                                }
                                            }
                                            if item.AstMA >= 0 {
                                                Text("數甲 \(item.AstMA)")
                                                    .padding(5)
                                                    .background(Color(.systemGray5))
                                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                            }
                                            if item.AstMB >= 0 {
                                                Text("數乙 \(item.AstMB)")
                                                    .padding(5)
                                                    .background(Color(.systemGray5))
                                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                            }
                                            if item.AstPH >= 0 {
                                                Text("物理 \(item.AstPH)")
                                                    .padding(5)
                                                    .background(Color(.systemGray5))
                                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                            }
                                            if item.AstCH >= 0 {
                                                Text("化學 \(item.AstCH)")
                                                    .padding(5)
                                                    .background(Color(.systemGray5))
                                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                            }
                                            if item.AstBI >= 0 {
                                                Text("生物 \(item.AstBI)")
                                                    .padding(5)
                                                    .background(Color(.systemGray5))
                                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                            }
                                            if item.AstHI >= 0 {
                                                Text("歷史 \(item.AstHI)")
                                                    .padding(5)
                                                    .background(Color(.systemGray5))
                                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                            }
                                            if item.AstGE >= 0 {
                                                Text("地理 \(item.AstGE)")
                                                    .padding(5)
                                                    .background(Color(.systemGray5))
                                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                            }
                                            if item.AstSO >= 0 {
                                                Text("公民 \(item.AstSO)")
                                                    .padding(5)
                                                    .background(Color(.systemGray5))
                                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                            }
                                            
                                        }
                                    }
                                }
                                .scoreCard()
                                .padding(.horizontal)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
        
            HStack{
                Spacer()
            }
        }
        .navigationTitle("差距分析")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    GuessView()
        .environmentObject(DepartmentData())
        .environmentObject(UserData())
}

struct GuessDetailView: View {
    
    @EnvironmentObject private var userData: UserData
    @EnvironmentObject private var departmentData: DepartmentData
    @State private var showFilter: Bool = false
    @State private var searchText: String = ""
    @State private var searchFilter: [String] = []
    
    private var filteredDepartments: [Departments] {
        DepartmentData().departments.filter { department in
            
            let matchesSearchText = searchText.isEmpty || department.fullname.contains(searchText) || department.code.contains(searchText)
            
            let matchesFilter = searchFilter.isEmpty || searchFilter.contains { filter in
                department.fullname.contains(filter)
            }
            
            // 結合條件：同時滿足搜尋框和篩選器
            return matchesSearchText && matchesFilter
        }
    }
    
    let grade: UserGrade
    
    var body: some View {
        VStack(alignment: .leading){
            
            VStack{
                HStack{
                    Text(grade.dataName)
                        .bold()
                    Spacer()
                }
                HStack{
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            
                            if grade.GsatCH >= 0 {
                                Text("國文 \(grade.GsatCH)")
                                    .padding(5)
                                    .background(Color(.systemGray5))
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            }
                            if grade.GsatEN >= 0 {
                                Text("英文 \(grade.GsatEN)")
                                    .padding(5)
                                    .background(Color(.systemGray5))
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            }
                            if grade.GsatMA >= 0 {
                                Text("數Ａ \(grade.GsatMA)")
                                    .padding(5)
                                    .background(Color(.systemGray5))
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            }
                            if grade.GsatMB >= 0 {
                                Text("數Ｂ \(grade.GsatMB)")
                                    .padding(5)
                                    .background(Color(.systemGray5))
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            }
                            if grade.GsatSC >= 0 {
                                Text("自然 \(grade.GsatSC)")
                                    .padding(5)
                                    .background(Color(.systemGray5))
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            }
                            if grade.GsatSO >= 0 {
                                Text("社會 \(grade.GsatSO)")
                                    .padding(5)
                                    .background(Color(.systemGray5))
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            }
                            if grade.GsatEL >= 0 {
                                switch grade.GsatEL {
                                case 3:
                                    Text("英聽 A")
                                        .padding(5)
                                        .background(Color(.systemGray5))
                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                case 2:
                                    Text("英聽 B")
                                        .padding(5)
                                        .background(Color(.systemGray5))
                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                case 1:
                                    Text("英聽 C")
                                        .padding(5)
                                        .background(Color(.systemGray5))
                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                default:
                                    Text("英聽 F")
                                        .padding(5)
                                        .background(Color(.systemGray5))
                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                }
                            }
                            if grade.AstMA >= 0 {
                                Text("數甲 \(grade.AstMA)")
                                    .padding(5)
                                    .background(Color(.systemGray5))
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            }
                            if grade.AstMB >= 0 {
                                Text("數乙 \(grade.AstMB)")
                                    .padding(5)
                                    .background(Color(.systemGray5))
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            }
                            if grade.AstPH >= 0 {
                                Text("物理 \(grade.AstPH)")
                                    .padding(5)
                                    .background(Color(.systemGray5))
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            }
                            if grade.AstCH >= 0 {
                                Text("化學 \(grade.AstCH)")
                                    .padding(5)
                                    .background(Color(.systemGray5))
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            }
                            if grade.AstBI >= 0 {
                                Text("生物 \(grade.AstBI)")
                                    .padding(5)
                                    .background(Color(.systemGray5))
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            }
                            if grade.AstHI >= 0 {
                                Text("歷史 \(grade.AstHI)")
                                    .padding(5)
                                    .background(Color(.systemGray5))
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            }
                            if grade.AstGE >= 0 {
                                Text("地理 \(grade.AstGE)")
                                    .padding(5)
                                    .background(Color(.systemGray5))
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            }
                            if grade.AstSO >= 0 {
                                Text("公民 \(grade.AstSO)")
                                    .padding(5)
                                    .background(Color(.systemGray5))
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            }
                            
                        }
                    }
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
                .padding()
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray6), lineWidth: 2)
                )
                .shadow(color: Color(.label).opacity(0.1),radius: 5)
                .padding(.horizontal)
            
            ScrollView {
                LazyVStack{
                    ForEach(filteredDepartments) { department in
                        GuessRowView(department: department, grade: grade)
                    }
                }
                .padding()
            }
            
            
            HStack{
                Spacer()
            }
        }
        .navigationTitle("差距分析 - \(grade.dataName)")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showFilter){
            DepartmentListFilterView(searchFilter: $searchFilter)
        }
    }

}

struct GuessRowView: View {
    @State private var showMore: Bool = false
    let department: Departments
    let grade: UserGrade
    
    var body: some View {
        Button {
            showMore.toggle()
        } label: {
            VStack(alignment: .leading){
                let availability = checkAvailablity(department: department)
                let nonAvailability = checkNonAvailablity(department: department)
                HStack{
                    if !availability.isEmpty {
                        Image(systemName: "xmark.square.fill")
                            .foregroundStyle(Color(.red))
                    }
                    Text(department.fullname)
                    Spacer()
                }
                if showMore {
                    Divider()
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 12)
                        Text("檢定檢查")
                    }
                    .font(.caption)
                    .foregroundStyle(Color(.systemGray))
                    .padding(.vertical, 2)
                    if availability.isEmpty && nonAvailability.isEmpty {
                        HStack{
                            Image(systemName: "checkmark.square.fill")
                            Text("通過檢定")
                        }
                        .padding(5)
                        .background(Color(.green).opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    } else {
                        FlowLayout{
                            ForEach(checkAvailablity(department: department), id: \.self){ reason in
                                HStack{
                                    Image(systemName: "xmark.square.fill")
                                        .foregroundStyle(Color(.red))
                                    Text(reason)
                                }
                                .padding(5)
                                .background(Color(.red).opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            }
                            ForEach(checkNonAvailablity(department: department), id: \.self){ reason in
                                HStack{
                                    Image(systemName: "exclamationmark.triangle.fill")
                                    Text(reason)
                                }
                                .padding(5)
                                .background(Color(.systemGray5))
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            }
                        }
                    }
                    HStack{
                        Image(systemName: "document.badge.clock")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 12)
                        Text("分數計算")
                    }
                    .font(.caption)
                    .foregroundStyle(Color(.systemGray))
                    .padding(.vertical, 2)
                    VStack{
                        HStack{
                            Text("科目")
                                .frame(width: 45, alignment: .leading)
                            Text("倍率")
                                .frame(width: 45, alignment: .leading)
                            Spacer()
                            Text("你的分數")
                        }
                        .bold()
                        if department.gsatchineseMultiplier > 0 {
                            HStack{
                                Text("國文")
                                    .frame(width: 45, alignment: .leading)
                                Text(String(format: "%.2f", department.gsatchineseMultiplier))
                                    .frame(width: 45, alignment: .leading)
                                Spacer()
                                if grade.GsatCH == -1 {
                                    Text("-")
                                } else {
                                    Text("\(grade.GsatCH)")
                                        .frame(width: 45, alignment: .trailing)
                                    Text("×")
                                    Text(String(format: "%.2f", department.gsatchineseMultiplier))
                                        .frame(width: 45, alignment: .trailing)
                                    Text("=")
                                    Text(String(format: "%.2f", Double(grade.GsatCH) * department.gsatchineseMultiplier))
                                        .frame(width: 45, alignment: .trailing)
                                }
                            }
                        }
                        if department.gsatenglishMultiplier > 0 {
                            HStack {
                                Text("英文")
                                    .frame(width: 45, alignment: .leading)
                                Text(String(format: "%.2f", department.gsatenglishMultiplier))
                                    .frame(width: 45, alignment: .leading)
                                Spacer()
                                if grade.GsatEN == -1 {
                                    Text("-")
                                } else {
                                    Text("\(grade.GsatEN)")
                                        .frame(width: 45, alignment: .trailing)
                                    Text("×")
                                    Text(String(format: "%.2f", department.gsatenglishMultiplier))
                                        .frame(width: 45, alignment: .trailing)
                                    Text("=")
                                    Text(String(format: "%.2f", Double(grade.GsatEN) * department.gsatenglishMultiplier))
                                        .frame(width: 50, alignment: .trailing)
                                }
                            }
                        }
                        if department.gsatmathaMultiplier > 0 {
                            HStack {
                                Text("數Ａ")
                                    .frame(width: 45, alignment: .leading)
                                Text(String(format: "%.2f", department.gsatmathaMultiplier))
                                    .frame(width: 45, alignment: .leading)
                                Spacer()
                                if grade.GsatMA == -1 {
                                    Text("-")
                                } else {
                                    Text("\(grade.GsatMA)")
                                        .frame(width: 45, alignment: .trailing)
                                    Text("×")
                                    Text(String(format: "%.2f", department.gsatmathaMultiplier))
                                        .frame(width: 45, alignment: .trailing)
                                    Text("=")
                                    Text(String(format: "%.2f", Double(grade.GsatMA) * department.gsatmathaMultiplier))
                                        .frame(width: 50, alignment: .trailing)
                                }
                            }
                        }
                        if department.gsatmathbMultiplier > 0 {
                            HStack {
                                Text("數Ｂ")
                                    .frame(width: 45, alignment: .leading)
                                Text(String(format: "%.2f", department.gsatmathbMultiplier))
                                    .frame(width: 45, alignment: .leading)
                                Spacer()
                                if grade.GsatMB == -1 {
                                    Text("-")
                                } else {
                                    Text("\(grade.GsatMB)")
                                        .frame(width: 45, alignment: .trailing)
                                    Text("×")
                                    Text(String(format: "%.2f", department.gsatmathbMultiplier))
                                        .frame(width: 45, alignment: .trailing)
                                    Text("=")
                                    Text(String(format: "%.2f", Double(grade.GsatMB) * department.gsatmathbMultiplier))
                                        .frame(width: 50, alignment: .trailing)
                                }
                            }
                        }
                        if department.gsatscienceMultiplier > 0 {
                            HStack {
                                Text("自然")
                                    .frame(width: 45, alignment: .leading)
                                Text(String(format: "%.2f", department.gsatscienceMultiplier))
                                    .frame(width: 45, alignment: .leading)
                                Spacer()
                                if grade.GsatSC == -1 {
                                    Text("-")
                                } else {
                                    Text("\(grade.GsatSC)")
                                        .frame(width: 45, alignment: .trailing)
                                    Text("×")
                                    Text(String(format: "%.2f", department.gsatscienceMultiplier))
                                        .frame(width: 45, alignment: .trailing)
                                    Text("=")
                                    Text(String(format: "%.2f", Double(grade.GsatSC) * department.gsatscienceMultiplier))
                                        .frame(width: 50, alignment: .trailing)
                                }
                            }
                        }
                        if department.gsatsocialMultiplier > 0 {
                            HStack {
                                Text("社會")
                                    .frame(width: 45, alignment: .leading)
                                Text(String(format: "%.2f", department.gsatsocialMultiplier))
                                    .frame(width: 45, alignment: .leading)
                                Spacer()
                                if grade.GsatSO == -1 {
                                    Text("-")
                                } else {
                                    Text("\(grade.GsatSO)")
                                        .frame(width: 45, alignment: .trailing)
                                    Text("×")
                                    Text(String(format: "%.2f", department.gsatsocialMultiplier))
                                        .frame(width: 45, alignment: .trailing)
                                    Text("=")
                                    Text(String(format: "%.2f", Double(grade.GsatSO) * department.gsatsocialMultiplier))
                                        .frame(width: 50, alignment: .trailing)
                                }
                            }
                        }
                        if department.mathaMultiplier > 0 {
                            HStack {
                                Text("數甲")
                                    .frame(width: 45, alignment: .leading)
                                Text(String(format: "%.2f", department.mathaMultiplier))
                                    .frame(width: 45, alignment: .leading)
                                Spacer()
                                if grade.AstMA == -1 {
                                    Text("-")
                                } else {
                                    Text("\(grade.AstMA)")
                                        .frame(width: 45, alignment: .trailing)
                                    Text("×")
                                    Text(String(format: "%.2f", department.mathaMultiplier))
                                        .frame(width: 45, alignment: .trailing)
                                    Text("=")
                                    Text(String(format: "%.2f", Double(grade.AstMA) * department.mathaMultiplier))
                                        .frame(width: 50, alignment: .trailing)
                                }
                            }
                        }
                        if department.mathbMultiplier > 0 {
                            HStack {
                                Text("數乙")
                                    .frame(width: 45, alignment: .leading)
                                Text(String(format: "%.2f", department.mathbMultiplier))
                                    .frame(width: 45, alignment: .leading)
                                Spacer()
                                if grade.AstMB == -1 {
                                    Text("-")
                                } else {
                                    Text("\(grade.AstMB)")
                                        .frame(width: 45, alignment: .trailing)
                                    Text("×")
                                    Text(String(format: "%.2f", department.mathbMultiplier))
                                        .frame(width: 45, alignment: .trailing)
                                    Text("=")
                                    Text(String(format: "%.2f", Double(grade.AstMB) * department.mathbMultiplier))
                                        .frame(width: 50, alignment: .trailing)
                                }
                            }
                        }
                        if department.physicsMultiplier > 0 {
                            HStack {
                                Text("物理")
                                    .frame(width: 45, alignment: .leading)
                                Text(String(format: "%.2f", department.physicsMultiplier))
                                    .frame(width: 45, alignment: .leading)
                                Spacer()
                                if grade.AstPH == -1 {
                                    Text("-")
                                } else {
                                    Text("\(grade.AstPH)")
                                        .frame(width: 45, alignment: .trailing)
                                    Text("×")
                                    Text(String(format: "%.2f", department.physicsMultiplier))
                                        .frame(width: 45, alignment: .trailing)
                                    Text("=")
                                    Text(String(format: "%.2f", Double(grade.AstPH) * department.physicsMultiplier))
                                        .frame(width: 50, alignment: .trailing)
                                }
                            }
                        }
                        if department.chemistryMultiplier > 0 {
                            HStack {
                                Text("化學")
                                    .frame(width: 45, alignment: .leading)
                                Text(String(format: "%.2f", department.chemistryMultiplier))
                                    .frame(width: 45, alignment: .leading)
                                Spacer()
                                if grade.AstCH == -1 {
                                    Text("-")
                                } else {
                                    Text("\(grade.AstCH)")
                                        .frame(width: 45, alignment: .trailing)
                                    Text("×")
                                    Text(String(format: "%.2f", department.chemistryMultiplier))
                                        .frame(width: 45, alignment: .trailing)
                                    Text("=")
                                    Text(String(format: "%.2f", Double(grade.AstCH) * department.chemistryMultiplier))
                                        .frame(width: 50, alignment: .trailing)
                                }
                            }
                        }
                        if department.biologyMultiplier > 0 {
                            HStack {
                                Text("生物")
                                    .frame(width: 45, alignment: .leading)
                                Text(String(format: "%.2f", department.biologyMultiplier))
                                    .frame(width: 45, alignment: .leading)
                                Spacer()
                                if grade.AstBI == -1 {
                                    Text("-")
                                } else {
                                    Text("\(grade.AstBI)")
                                        .frame(width: 45, alignment: .trailing)
                                    Text("×")
                                    Text(String(format: "%.2f", department.biologyMultiplier))
                                        .frame(width: 45, alignment: .trailing)
                                    Text("=")
                                    Text(String(format: "%.2f", Double(grade.AstBI) * department.biologyMultiplier))
                                        .frame(width: 50, alignment: .trailing)
                                }
                            }
                        }
                        if department.historyMultiplier > 0 {
                            HStack {
                                Text("歷史")
                                    .frame(width: 45, alignment: .leading)
                                Text(String(format: "%.2f", department.historyMultiplier))
                                    .frame(width: 45, alignment: .leading)
                                Spacer()
                                if grade.AstHI == -1 {
                                    Text("-")
                                } else {
                                    Text("\(grade.AstHI)")
                                        .frame(width: 45, alignment: .trailing)
                                    Text("×")
                                    Text(String(format: "%.2f", department.historyMultiplier))
                                        .frame(width: 45, alignment: .trailing)
                                    Text("=")
                                    Text(String(format: "%.2f", Double(grade.AstHI) * department.historyMultiplier))
                                        .frame(width: 50, alignment: .trailing)
                                }
                            }
                        }
                        if department.geometryMultiplier > 0 {
                            HStack {
                                Text("地理")
                                    .frame(width: 45, alignment: .leading)
                                Text(String(format: "%.2f", department.geometryMultiplier))
                                    .frame(width: 45, alignment: .leading)
                                Spacer()
                                if grade.AstGE == -1 {
                                    Text("-")
                                } else {
                                    Text("\(grade.AstGE)")
                                        .frame(width: 45, alignment: .trailing)
                                    Text("×")
                                    Text(String(format: "%.2f", department.geometryMultiplier))
                                        .frame(width: 45, alignment: .trailing)
                                    Text("=")
                                    Text(String(format: "%.2f", Double(grade.AstGE) * department.geometryMultiplier))
                                        .frame(width: 50, alignment: .trailing)
                                }
                            }
                        }
                        if department.socialMultiplier > 0 {
                            HStack {
                                Text("公民")
                                    .frame(width: 45, alignment: .leading)
                                Text(String(format: "%.2f", department.socialMultiplier))
                                    .frame(width: 45, alignment: .leading)
                                Spacer()
                                if grade.AstSO == -1 {
                                    Text("-")
                                } else {
                                    Text("\(grade.AstSO)")
                                        .frame(width: 45, alignment: .trailing)
                                    Text("×")
                                    Text(String(format: "%.2f", department.socialMultiplier))
                                        .frame(width: 45, alignment: .trailing)
                                    Text("=")
                                    Text(String(format: "%.2f", Double(grade.AstSO) * department.socialMultiplier))
                                        .frame(width: 50, alignment: .trailing)
                                }
                            }
                        }
                        HStack{
                            Text("錄取分數")
                            Spacer()
                            Text(String(format: "%.2f", Double(department.resultScore) ?? 0.0))
                            Text(String(format: "(%.2f)", (Double(department.resultScore) ?? 0.0) / department.resultTotalMultiplier))
                        }
                        .bold()
                        .padding(.top, 1)
                        HStack{
                            Text("目前分數")
                            Spacer()
                            Text(String(format: "%.2f", totalScore()))
                            Text(String(format: "(%.2f)", totalScore() / currentTotalMultiplier()))
                        }
                        .bold()
                        if grade.SpecialPercentage > 0 {
                            HStack{
                                Text("身份加分")
                                Spacer()
                                Text("+\(grade.SpecialPercentage)%")
                            }
                        }
                        
                    }
                    HStack{
                        Image(systemName: "sparkles")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 12)
                        Text("差距分析")
                    }
                    .font(.caption)
                    .foregroundStyle(Color(.systemGray))
                    .padding(.vertical, 2)
                    
                    if let resultScoreValue = Double(department.resultScore) {
                        let resultScoreAverage = resultScoreValue / department.resultTotalMultiplier
                        let resultScoreToNow = resultScoreAverage * totalMultiplier() // 去年分數轉換今年總分
                        let scoreDiff = resultScoreToNow - totalScore() // 差距總分
                        let scoreAverageDiff = scoreDiff / (totalMultiplier() - currentTotalMultiplier()) // 差距平均
                        
                        if (totalMultiplier() == currentTotalMultiplier()){
                            HStack{
                                Text("科系要求之科目皆已有成績")
                                Spacer()
                                Text("不適用差距分析")
                            }
                        } else {
                            if scoreDiff > 0 {
                                HStack {
                                    Text("現有分數對錄取分數尚缺")
                                    Spacer()
                                    Text(String(format: "%.2f", scoreDiff))
                                    Text(String(format: "(%.2f)", scoreAverageDiff))
                                }
                            } else {
                                HStack {
                                    Text("現有分數已超越錄取分數")
                                    Spacer()
                                    Text(String(format: "%.2f", -scoreDiff))
                                    Text(String(format: "(%.2f)", -scoreAverageDiff))
                                }
                            }
                        }
                        
                    } else {
                        HStack {
                            Text("無去年最低錄取分數資料")
                            Spacer()
                            Text("N/A")
                        }
                    }
                    
                    HStack{
                        Image(systemName: "link")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 12)
                        Text("詳細資料")
                    }
                    .font(.caption)
                    .foregroundStyle(Color(.systemGray))
                    .padding(.vertical, 2)
                    NavigationLink(destination: DepartmentDetailView(department: department, grade: UserGrade(id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!, dataName: "無資料", GsatCH: -1, GsatEN: -1, GsatMA: -1, GsatMB: -1, GsatSO: -1, GsatSC: -1, GsatEL: -1, AstMA: -1, AstMB: -1, AstPH: -1, AstCH: -1, AstBI: -1, AstHI: -1, AstGE: -1, AstSO: -1, SpecialType: -1, SpecialPercentage: -1))){
                        HStack{
                            Image(systemName: "link")
                            Text("查看本科系詳細資料")
                        }
                        .padding(5)
                        .foregroundStyle(Color(.white))
                        .background(Color(.accent))
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                    .buttonStyle(.plain)
                }
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
    
    private func checkAvailablity(department: Departments) -> [String] {
        var reason: [String] = []
        // 檢定
        if grade.GsatCH > -1 {
            switch department.chinesetest {
            case "頂標":
                if grade.GsatCH <= LevelConstants.CHLevel1 {
                    reason.append("國文未達頂標")
                }
            case "前標":
                if grade.GsatCH <= LevelConstants.CHLevel2 {
                    reason.append("國文未達前標")
                }
            case "均標":
                if grade.GsatCH <= LevelConstants.CHLevel3 {
                    reason.append("國文未達均標")
                }
            case "後標":
                if grade.GsatCH <= LevelConstants.CHLevel4 {
                    reason.append("國文未達後標")
                }
            case "底標":
                if grade.GsatCH <= LevelConstants.CHLevel5 {
                    reason.append("國文未達底標")
                }
            default:
                break
            }
        }
        if grade.GsatEN > -1 {
            switch department.englishtest {
            case "頂標":
                if grade.GsatEN <= LevelConstants.ENLevel1 {
                    reason.append("英文未達頂標")
                }
            case "前標":
                if grade.GsatEN <= LevelConstants.ENLevel2 {
                    reason.append("英文未達前標")
                }
            case "均標":
                if grade.GsatEN <= LevelConstants.ENLevel3 {
                    reason.append("英文未達均標")
                }
            case "後標":
                if grade.GsatEN <= LevelConstants.ENLevel4 {
                    reason.append("國文未達後標")
                }
            case "底標":
                if grade.GsatEN <= LevelConstants.ENLevel5 {
                    reason.append("英文未達底標")
                }
            default:
                break
            }
        }
        if grade.GsatMA > -1 {
            switch department.mathatest {
            case "頂標":
                if grade.GsatMA <= LevelConstants.MALevel1 {
                    reason.append("數Ａ未達頂標")
                }
            case "前標":
                if grade.GsatMA <= LevelConstants.MALevel2 {
                    reason.append("數Ａ未達前標")
                }
            case "均標":
                if grade.GsatMA <= LevelConstants.MALevel3 {
                    reason.append("數Ａ未達均標")
                }
            case "後標":
                if grade.GsatMA <= LevelConstants.MALevel4 {
                    reason.append("數Ａ未達後標")
                }
            case "底標":
                if grade.GsatMA <= LevelConstants.MALevel5 {
                    reason.append("數Ａ未達底標")
                }
            default:
                break
            }
        }
        if grade.GsatMB > -1 {
            switch department.mathbtest {
            case "頂標":
                if grade.GsatMB <= LevelConstants.MBLevel1 {
                    reason.append("數Ｂ未達頂標")
                }
            case "前標":
                if grade.GsatMB <= LevelConstants.MBLevel2 {
                    reason.append("數Ｂ未達前標")
                }
            case "均標":
                if grade.GsatMB <= LevelConstants.MBLevel3 {
                    reason.append("數Ｂ未達均標")
                }
            case "後標":
                if grade.GsatMB <= LevelConstants.MBLevel4 {
                    reason.append("數Ｂ未達後標")
                }
            case "底標":
                if grade.GsatMB <= LevelConstants.MBLevel5 {
                    reason.append("數Ｂ未達底標")
                }
            default:
                break
            }
        }
        if grade.GsatSC > -1 {
            switch department.sciencetest {
            case "頂標":
                if grade.GsatSC <= LevelConstants.SCLevel1 {
                    reason.append("自然未達頂標")
                }
            case "前標":
                if grade.GsatSC <= LevelConstants.SCLevel2 {
                    reason.append("自然未達前標")
                }
            case "均標":
                if grade.GsatSC <= LevelConstants.SCLevel3 {
                    reason.append("自然未達均標")
                }
            case "後標":
                if grade.GsatSC <= LevelConstants.SCLevel4 {
                    reason.append("自然未達後標")
                }
            case "底標":
                if grade.GsatSC <= LevelConstants.SCLevel5 {
                    reason.append("自然未達底標")
                }
            default:
                break
            }
        }
        if grade.GsatSO > -1 {
            switch department.socialtest {
            case "頂標":
                if grade.GsatSO <= LevelConstants.SOLevel1 {
                    reason.append("社會未達頂標")
                }
            case "前標":
                if grade.GsatSO <= LevelConstants.SOLevel2 {
                    reason.append("社會未達前標")
                }
            case "均標":
                if grade.GsatSO <= LevelConstants.SOLevel3 {
                    reason.append("社會未達均標")
                }
            case "後標":
                if grade.GsatSO <= LevelConstants.SOLevel4 {
                    reason.append("社會未達後標")
                }
            case "底標":
                if grade.GsatSO <= LevelConstants.SOLevel5 {
                    reason.append("社會未達底標")
                }
            default:
                break
            }
        }
        switch grade.GsatEL {
        case 3: // A級
            break
        case 2: // B級
            if (department.englishlistentest == "A級"){
                reason.append("英聽未達A級")
            }
        case 1: // C級
            if (department.englishlistentest == "A級"){
                reason.append("英聽未達A級")
            } else if ( department.englishlistentest == "B級" ) {
                reason.append("英聽未達B級")
            }
        default: // F級或其他
            if (department.englishlistentest == "A級"){
                reason.append("英聽未達A級")
            } else if ( department.englishlistentest == "B級" ) {
                reason.append("英聽未達B級")
            } else if ( department.englishlistentest == "C級" ) {
                reason.append("英聽未達C級")
            }
        }
        return reason
    }
    
    private func checkNonAvailablity(department: Departments) -> [String] {
        var reason: [String] = []
        // 檢定
        if grade.GsatCH == -1 {
            switch department.chinesetest {
            case "頂標":
                if grade.GsatCH <= LevelConstants.CHLevel1 {
                    reason.append("國文需達頂標")
                }
            case "前標":
                if grade.GsatCH <= LevelConstants.CHLevel2 {
                    reason.append("國文需達前標")
                }
            case "均標":
                if grade.GsatCH <= LevelConstants.CHLevel3 {
                    reason.append("國文需達均標")
                }
            case "後標":
                if grade.GsatCH <= LevelConstants.CHLevel4 {
                    reason.append("國文需達後標")
                }
            case "底標":
                if grade.GsatCH <= LevelConstants.CHLevel5 {
                    reason.append("國文需達底標")
                }
            default:
                break
            }
        }
        if grade.GsatEN == -1 {
            switch department.englishtest {
            case "頂標":
                if grade.GsatEN <= LevelConstants.ENLevel1 {
                    reason.append("英文需達頂標")
                }
            case "前標":
                if grade.GsatEN <= LevelConstants.ENLevel2 {
                    reason.append("英文需達前標")
                }
            case "均標":
                if grade.GsatEN <= LevelConstants.ENLevel3 {
                    reason.append("英文需達均標")
                }
            case "後標":
                if grade.GsatEN <= LevelConstants.ENLevel4 {
                    reason.append("國文需達後標")
                }
            case "底標":
                if grade.GsatEN <= LevelConstants.ENLevel5 {
                    reason.append("英文需達底標")
                }
            default:
                break
            }
        }
        if grade.GsatMA == -1 {
            switch department.mathatest {
            case "頂標":
                if grade.GsatMA <= LevelConstants.MALevel1 {
                    reason.append("數Ａ需達頂標")
                }
            case "前標":
                if grade.GsatMA <= LevelConstants.MALevel2 {
                    reason.append("數Ａ需達前標")
                }
            case "均標":
                if grade.GsatMA <= LevelConstants.MALevel3 {
                    reason.append("數Ａ需達均標")
                }
            case "後標":
                if grade.GsatMA <= LevelConstants.MALevel4 {
                    reason.append("數Ａ需達後標")
                }
            case "底標":
                if grade.GsatMA <= LevelConstants.MALevel5 {
                    reason.append("數Ａ需達底標")
                }
            default:
                break
            }
        }
        if grade.GsatMB == -1 {
            switch department.mathbtest {
            case "頂標":
                if grade.GsatMB <= LevelConstants.MBLevel1 {
                    reason.append("數Ｂ需達頂標")
                }
            case "前標":
                if grade.GsatMB <= LevelConstants.MBLevel2 {
                    reason.append("數Ｂ需達前標")
                }
            case "均標":
                if grade.GsatMB <= LevelConstants.MBLevel3 {
                    reason.append("數Ｂ需達均標")
                }
            case "後標":
                if grade.GsatMB <= LevelConstants.MBLevel4 {
                    reason.append("數Ｂ需達後標")
                }
            case "底標":
                if grade.GsatMB <= LevelConstants.MBLevel5 {
                    reason.append("數Ｂ需達底標")
                }
            default:
                break
            }
        }
        if grade.GsatSC == -1 {
            switch department.sciencetest {
            case "頂標":
                if grade.GsatSC <= LevelConstants.SCLevel1 {
                    reason.append("自然需達頂標")
                }
            case "前標":
                if grade.GsatSC <= LevelConstants.SCLevel2 {
                    reason.append("自然需達前標")
                }
            case "均標":
                if grade.GsatSC <= LevelConstants.SCLevel3 {
                    reason.append("自然需達均標")
                }
            case "後標":
                if grade.GsatSC <= LevelConstants.SCLevel4 {
                    reason.append("自然需達後標")
                }
            case "底標":
                if grade.GsatSC <= LevelConstants.SCLevel5 {
                    reason.append("自然需達底標")
                }
            default:
                break
            }
        }
        if grade.GsatSO == -1 {
            switch department.socialtest {
            case "頂標":
                if grade.GsatSO <= LevelConstants.SOLevel1 {
                    reason.append("社會需達頂標")
                }
            case "前標":
                if grade.GsatSO <= LevelConstants.SOLevel2 {
                    reason.append("社會需達前標")
                }
            case "均標":
                if grade.GsatSO <= LevelConstants.SOLevel3 {
                    reason.append("社會需達均標")
                }
            case "後標":
                if grade.GsatSO <= LevelConstants.SOLevel4 {
                    reason.append("社會需達後標")
                }
            case "底標":
                if grade.GsatSO <= LevelConstants.SOLevel5 {
                    reason.append("社會需達底標")
                }
            default:
                break
            }
        }
//        switch grade.GsatEL {
//        case 3: // A級
//            break
//        case 2: // B級
//            if (department.englishlistentest == "A級"){
//                reason.append("英聽需達A級")
//            }
//        case 1: // C級
//            if (department.englishlistentest == "A級"){
//                reason.append("英聽需達A級")
//            } else if ( department.englishlistentest == "B級" ) {
//                reason.append("英聽需達B級")
//            }
//        default: // F級或其他
//            if (department.englishlistentest == "A級"){
//                reason.append("英聽需達A級")
//            } else if ( department.englishlistentest == "B級" ) {
//                reason.append("英聽需達B級")
//            } else if ( department.englishlistentest == "C級" ) {
//                reason.append("英聽需達C級")
//            }
//        }
        return reason
    }
    
    private func totalScore() -> Double {
        var total: Double = 0.0
        
        // GSAT 科目
        if grade.GsatCH != -1 {
            total += department.gsatchineseMultiplier * Double(grade.GsatCH)
        }
        if grade.GsatEN != -1 {
            total += department.gsatenglishMultiplier * Double(grade.GsatEN)
        }
        if grade.GsatMA != -1 {
            total += department.gsatmathaMultiplier * Double(grade.GsatMA)
        }
        if grade.GsatMB != -1 {
            total += department.gsatmathbMultiplier * Double(grade.GsatMB)
        }
        if grade.GsatSC != -1 {
            total += department.gsatscienceMultiplier * Double(grade.GsatSC)
        }
        if grade.GsatSO != -1 {
            total += department.gsatsocialMultiplier * Double(grade.GsatSO)
        }
        
        // AST 科目
        if grade.AstMA != -1 {
            total += department.mathaMultiplier * Double(grade.AstMA)
        }
        if grade.AstMB != -1 {
            total += department.mathbMultiplier * Double(grade.AstMB)
        }
        if grade.AstPH != -1 {
            total += department.physicsMultiplier * Double(grade.AstPH)
        }
        if grade.AstCH != -1 {
            total += department.chemistryMultiplier * Double(grade.AstCH)
        }
        if grade.AstBI != -1 {
            total += department.biologyMultiplier * Double(grade.AstBI)
        }
        if grade.AstHI != -1 {
            total += department.historyMultiplier * Double(grade.AstHI)
        }
        if grade.AstGE != -1 {
            total += department.geometryMultiplier * Double(grade.AstGE)
        }
        if grade.AstSO != -1 {
            total += department.socialMultiplier * Double(grade.AstSO)
        }
        
        if grade.SpecialPercentage > 0 {
            total *= Double(100 + grade.SpecialPercentage)/100
        }
        
        return total
    }
    
    private func totalMultiplier() -> Double {
        return (department.gsatchineseMultiplier + department.gsatenglishMultiplier + department.gsatmathaMultiplier + department.gsatmathbMultiplier + department.gsatscienceMultiplier + department.gsatsocialMultiplier + department.mathaMultiplier + department.mathbMultiplier + department.physicsMultiplier + department.chemistryMultiplier + department.biologyMultiplier + department.historyMultiplier + department.geometryMultiplier + department.socialMultiplier)
    }
    
    private func currentTotalMultiplier() -> Double {
        var total: Double = 0.0
        
        // GSAT 科目
        if grade.GsatCH != -1 {
            total += department.gsatchineseMultiplier
        }
        if grade.GsatEN != -1 {
            total += department.gsatenglishMultiplier
        }
        if grade.GsatMA != -1 {
            total += department.gsatmathaMultiplier
        }
        if grade.GsatMB != -1 {
            total += department.gsatmathbMultiplier
        }
        if grade.GsatSC != -1 {
            total += department.gsatscienceMultiplier
        }
        if grade.GsatSO != -1 {
            total += department.gsatsocialMultiplier
        }
        
        // AST 科目
        if grade.AstMA != -1 {
            total += department.mathaMultiplier
        }
        if grade.AstMB != -1 {
            total += department.mathbMultiplier
        }
        if grade.AstPH != -1 {
            total += department.physicsMultiplier
        }
        if grade.AstCH != -1 {
            total += department.chemistryMultiplier
        }
        if grade.AstBI != -1 {
            total += department.biologyMultiplier
        }
        if grade.AstHI != -1 {
            total += department.historyMultiplier
        }
        if grade.AstGE != -1 {
            total += department.geometryMultiplier
        }
        if grade.AstSO != -1 {
            total += department.socialMultiplier
        }
        
        return total
    }
}

#Preview {
    NavigationStack{
        GuessRowView(department: DepartmentData().departments.first!, grade: UserData().userData.grade.first!)
    }
}
