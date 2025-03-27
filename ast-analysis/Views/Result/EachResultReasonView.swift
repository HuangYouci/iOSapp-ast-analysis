//
//  EachResultReasonView.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/3/23.
//

import SwiftUI

struct EachResultReasonView: View {
    
    @EnvironmentObject private var departmentData: DepartmentData
    @EnvironmentObject private var userData: UserData
    
    let resultID: UUID
    
    private var result: UserGrade {
        userData.userData.grade.first { $0.id == resultID }!
    }
    
    var body: some View {
        
        let nopass: [Departments] = departmentData.departments.filter {
            return !checkAvailablity(department: $0).isEmpty
        }
        
        VStack(alignment: .leading){
            VStack(alignment: .leading){
                Text("未通過檢定之校系")
                    .font(.largeTitle)
                    .bold()
                Text("未符合 \(nopass.count) 個校系的選填條件")
                    .foregroundStyle(Color(.systemGray))
                ScrollView{
                    LazyVStack{
                        
                        ForEach(nopass){ item in
                            NavigationLink(destination: DepartmentDetailView(department: item, grade: UserGrade(id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!, dataName: "無資料", GsatCH: -1, GsatEN: -1, GsatMA: -1, GsatMB: -1, GsatSO: -1, GsatSC: -1, GsatEL: -1, AstMA: -1, AstMB: -1, AstPH: -1, AstCH: -1, AstBI: -1, AstHI: -1, AstGE: -1, AstSO: -1, SpecialType: -1, SpecialPercentage: -1))){
                                VStack(alignment: .leading){
                                    HStack{
                                        Text(item.fullname)
                                        Spacer()
                                    }
                                    Divider()
                                    ScrollView(.horizontal, showsIndicators: false){
                                        HStack{
                                            ForEach(checkAvailablity(department: item), id: \.self){ reason in
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
                }
            }
            .padding()
            
        }
        .navigationTitle("未通過檢定之校系")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    private func checkAvailablity(department: Departments) -> [String] {
        var reason: [String] = []
        // 檢定
        switch department.chinesetest {
        case "頂標":
            if result.GsatCH <= LevelConstants.CHLevel1 {
                reason.append("國文未達頂標")
            }
        case "前標":
            if result.GsatCH <= LevelConstants.CHLevel2 {
                reason.append("國文未達前標")
            }
        case "均標":
            if result.GsatCH <= LevelConstants.CHLevel3 {
                reason.append("國文未達均標")
            }
        case "後標":
            if result.GsatCH <= LevelConstants.CHLevel4 {
                reason.append("國文未達後標")
            }
        case "底標":
            if result.GsatCH <= LevelConstants.CHLevel5 {
                reason.append("國文未達底標")
            }
        default:
            break
        }
        switch department.englishtest {
        case "頂標":
            if result.GsatEN <= LevelConstants.ENLevel1 {
                reason.append("英文未達頂標")
            }
        case "前標":
            if result.GsatEN <= LevelConstants.ENLevel2 {
                reason.append("英文未達前標")
            }
        case "均標":
            if result.GsatEN <= LevelConstants.ENLevel3 {
                reason.append("英文未達均標")
            }
        case "後標":
            if result.GsatEN <= LevelConstants.ENLevel4 {
                reason.append("英文未達後標")
            }
        case "底標":
            if result.GsatEN <= LevelConstants.ENLevel5 {
                reason.append("英文未達底標")
            }
        default:
            break
        }
        switch department.mathatest {
        case "頂標":
            if result.GsatMA <= LevelConstants.MALevel1 {
                reason.append("數Ａ未達頂標")
            }
        case "前標":
            if result.GsatMA <= LevelConstants.MALevel2 {
                reason.append("數Ａ未達前標")
            }
        case "均標":
            if result.GsatMA <= LevelConstants.MALevel3 {
                reason.append("數Ａ未達均標")
            }
        case "後標":
            if result.GsatMA <= LevelConstants.MALevel4 {
                reason.append("數Ａ未達後標")
            }
        case "底標":
            if result.GsatMA <= LevelConstants.MALevel5 {
                reason.append("數Ａ未達底標")
            }
        default:
            break
        }
        switch department.mathbtest {
        case "頂標":
            if result.GsatMB <= LevelConstants.MBLevel1 {
                reason.append("數Ｂ未達頂標")
            }
        case "前標":
            if result.GsatMB <= LevelConstants.MBLevel2 {
                reason.append("數Ｂ未達前標")
            }
        case "均標":
            if result.GsatMB <= LevelConstants.MBLevel3 {
                reason.append("數Ｂ未達均標")
            }
        case "後標":
            if result.GsatMB <= LevelConstants.MBLevel4 {
                reason.append("數Ｂ未達後標")
            }
        case "底標":
            if result.GsatMB <= LevelConstants.MBLevel5 {
                reason.append("數Ｂ未達底標")
            }
        default:
            break
        }
        switch department.sciencetest {
        case "頂標":
            if result.GsatSC <= LevelConstants.SCLevel1 {
                reason.append("自然未達頂標")
            }
        case "前標":
            if result.GsatSC <= LevelConstants.SCLevel2 {
                reason.append("自然未達前標")
            }
        case "均標":
            if result.GsatSC <= LevelConstants.SCLevel3 {
                reason.append("自然未達均標")
            }
        case "後標":
            if result.GsatSC <= LevelConstants.SCLevel4 {
                reason.append("自然未達後標")
            }
        case "底標":
            if result.GsatSC <= LevelConstants.SCLevel5 {
                reason.append("自然未達底標")
            }
        default:
            break
        }
        switch department.socialtest {
        case "頂標":
            if result.GsatSO <= LevelConstants.SOLevel1 {
                reason.append("社會未達頂標")
            }
        case "前標":
            if result.GsatSO <= LevelConstants.SOLevel2 {
                reason.append("社會未達前標")
            }
        case "均標":
            if result.GsatSO <= LevelConstants.SOLevel3 {
                reason.append("社會未達均標")
            }
        case "後標":
            if result.GsatSO <= LevelConstants.SOLevel4 {
                reason.append("社會未達後標")
            }
        case "底標":
            if result.GsatSO <= LevelConstants.SOLevel5 {
                reason.append("社會未達底標")
            }
        default:
            break
        }
        switch result.GsatEL {
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
        
        // 考試
        if department.gsatchineseMultiplier > 0 && result.GsatCH < 0 {
            reason.append("未報考國文")
        }
        if department.gsatenglishMultiplier > 0 && result.GsatEN < 0 {
            reason.append("未報考英文")
        }
        if department.gsatmathaMultiplier > 0 && result.GsatMA < 0 {
            reason.append("未報考數Ａ")
        }
        if department.gsatmathbMultiplier > 0 && result.GsatMB < 0 {
            reason.append("未報考數Ｂ")
        }
        if department.gsatscienceMultiplier > 0 && result.GsatSC < 0 {
            reason.append("未報考自然")
        }
        if department.gsatsocialMultiplier > 0 && result.GsatSO < 0 {
            reason.append("未報考社會")
        }
        // 分科測驗科目
        if department.mathaMultiplier > 0 && result.AstMA < 0 {
            reason.append("未報考數甲")
        }
        if department.mathbMultiplier > 0 && result.AstMB < 0 {
            reason.append("未報考數乙")
        }
        if department.physicsMultiplier > 0 && result.AstPH < 0 {
            reason.append("未報考物理")
        }
        if department.chemistryMultiplier > 0 && result.AstCH < 0 {
            reason.append("未報考化學")
        }
        if department.biologyMultiplier > 0 && result.AstBI < 0 {
            reason.append("未報考生物")
        }
        if department.historyMultiplier > 0 && result.AstHI < 0 {
            reason.append("未報考歷史")
        }
        if department.geometryMultiplier > 0 && result.AstGE < 0 {
            reason.append("未報考地理")
        }
        if department.socialMultiplier > 0 && result.AstSO < 0 {
            reason.append("未報考公民")
        }
        
        return reason
        
    }
    
}

#Preview {
    EachResultReasonView(resultID: UserData().userData.grade[0].id)
        .environmentObject(DepartmentData())
        .environmentObject(UserData())
}
