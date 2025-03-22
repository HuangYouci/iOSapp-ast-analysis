//
//  InputView.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/3/21.
//

import SwiftUI

struct InputView: View {
    
    @EnvironmentObject private var userData: UserData
    
    @State private var editingPage: Int = 0
    @State private var editingGsatCH: String = ""
    @State private var editingGsatEN: String = ""
    @State private var editingGsatMA: String = ""
    @State private var editingGsatMB: String = ""
    @State private var editingGsatSC: String = ""
    @State private var editingGsatSO: String = ""
    @State private var editingAstMA: String = ""
    @State private var editingAstMB: String = ""
    @State private var editingAstPH: String = ""
    @State private var editingAstCH: String = ""
    @State private var editingAstBI: String = ""
    @State private var editingAstHI: String = ""
    @State private var editingAstGE: String = ""
    @State private var editingAstSO: String = ""
    @State private var editingGsatEL: Int = 0
    @State private var editingOtherSP: Int = 0
    @State private var isFinished: Bool = false
    
    var body: some View {
        VStack(alignment: .leading){
            
            VStack(alignment: .leading){
                Text("成績輸入")
                    .font(.largeTitle)
                    .bold()
                Text("請輸入分科測驗與學測成績")
                    .foregroundStyle(Color(.systemGray))
            }
            
            Spacer()
                
            HStack{
                
                VStack(alignment: .leading){
                    
                    VStack(alignment: .leading){
                        Text("學測分數")
                            .font(.title2)
                            .bold()
                        Text("請輸入60級分制分數，未報考留空")
                            .foregroundStyle(Color(.systemGray))
                    }
                    .padding(.bottom, 20)
                    
                    HStack{
                        HStack{
                            Text("國文")
                            TextField("0~60 級分", text: $editingGsatCH)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        .padding(10)
                        .background(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(valdiateScore(editingGsatCH) ? .systemGray6 : .red), lineWidth: 1)
                        )
                        HStack{
                            Text("英文")
                            TextField("0~60 級分", text: $editingGsatEN)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        .padding(10)
                        .background(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(valdiateScore(editingGsatEN) ? .systemGray6 : .red), lineWidth: 1)
                        )
                    }
                    HStack{
                        HStack{
                            Text("數Ａ")
                            TextField("0~60 級分", text: $editingGsatMA)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        .padding(10)
                        .background(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(valdiateScore(editingGsatMA) ? .systemGray6 : .red), lineWidth: 1)
                        )
                        HStack{
                            Text("數Ｂ")
                            TextField("0~60 級分", text: $editingGsatMB)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        .padding(10)
                        .background(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(valdiateScore(editingGsatMB) ? .systemGray6 : .red), lineWidth: 1)
                        )
                    }
                    HStack{
                        HStack{
                            Text("自然")
                            TextField("0~60 級分", text: $editingGsatSC)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        .padding(10)
                        .background(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(valdiateScore(editingGsatSC) ? .systemGray6 : .red), lineWidth: 1)
                        )
                        HStack{
                            Text("社會")
                            TextField("0~60 級分", text: $editingGsatSO)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        .padding(10)
                        .background(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(valdiateScore(editingGsatSO) ? .systemGray6 : .red), lineWidth: 1)
                        )
                    }
                    
                    Spacer()
                    HStack{
                        Spacer()
                        Button{
                            withAnimation(.easeInOut){
                                editingPage = 1
                            }
                        } label: {
                            HStack{
                                Text("下一步")
                                Image(systemName: "chevron.right")
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(!valdiateScore(editingGsatMA) || !valdiateScore(editingGsatMB) || !valdiateScore(editingGsatEN) || !valdiateScore(editingGsatCH) || !valdiateScore(editingGsatSC) || !valdiateScore(editingGsatSO))
                    }
                }
                .inputCard()
                .disabled(editingPage != 0)
                
                VStack(alignment: .leading){
                    
                    VStack(alignment: .leading){
                        Text("分科分數")
                            .font(.title2)
                            .bold()
                        Text("請輸入60級分制分數，未報考留空")
                            .foregroundStyle(Color(.systemGray))
                    }
                    .padding(.bottom, 20)
                    
                    HStack{
                        HStack{
                            Text("數甲")
                            TextField("0~60 級分", text: $editingAstMA)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        .padding(10)
                        .background(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(valdiateScore(editingAstMA) ? .systemGray6 : .red), lineWidth: 1)
                        )
                        HStack{
                            Text("數乙")
                            TextField("0~60 級分", text: $editingAstMB)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        .padding(10)
                        .background(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(valdiateScore(editingAstMB) ? .systemGray6 : .red), lineWidth: 1)
                        )
                    }
                    HStack{
                        HStack{
                            Text("物理")
                            TextField("0~60 級分", text: $editingAstPH)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        .padding(10)
                        .background(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(valdiateScore(editingAstPH) ? .systemGray6 : .red), lineWidth: 1)
                        )
                        HStack{
                            Text("化學")
                            TextField("0~60 級分", text: $editingAstCH)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        .padding(10)
                        .background(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(valdiateScore(editingAstCH) ? .systemGray6 : .red), lineWidth: 1)
                        )
                    }
                    HStack{
                        HStack{
                            Text("生物")
                            TextField("0~60 級分", text: $editingAstBI)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        .padding(10)
                        .background(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(valdiateScore(editingAstBI) ? .systemGray6 : .red), lineWidth: 1)
                        )
                        HStack{
                            Text("歷史")
                            TextField("0~60 級分", text: $editingAstHI)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        .padding(10)
                        .background(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(valdiateScore(editingAstHI) ? .systemGray6 : .red), lineWidth: 1)
                        )
                    }
                    HStack{
                        HStack{
                            Text("地理")
                            TextField("0~60 級分", text: $editingAstGE)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        .padding(10)
                        .background(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(valdiateScore(editingAstGE) ? .systemGray6 : .red), lineWidth: 1)
                        )
                        HStack{
                            Text("公民")
                            TextField("0~60 級分", text: $editingAstSO)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        .padding(10)
                        .background(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(valdiateScore(editingAstSO) ? .systemGray6 : .red), lineWidth: 1)
                        )
                    }
                    
                    Spacer()
                    HStack{
                        Button{
                            withAnimation(.easeInOut){
                                editingPage = 0
                            }
                        } label: {
                            HStack{
                                Image(systemName: "chevron.left")
                                Text("上一步")
                            }
                        }
                        Spacer()
                        Button{
                            withAnimation(.easeInOut){
                                editingPage = 2
                                hideKeyboard()
                            }
                        } label: {
                            HStack{
                                Text("下一步")
                                Image(systemName: "chevron.right")
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(!valdiateScore(editingAstMA) || !valdiateScore(editingAstMB) || !valdiateScore(editingAstPH) || !valdiateScore(editingAstCH) || !valdiateScore(editingAstBI) || !valdiateScore(editingAstHI) || !valdiateScore(editingAstGE) || !valdiateScore(editingAstSO))
                    }
                }
                .inputCard()
                .disabled(editingPage != 1)
                
                VStack(alignment: .leading){
                    
                    VStack(alignment: .leading){
                        Text("其他項目")
                            .font(.title2)
                            .bold()
                        Text("請選擇")
                            .foregroundStyle(Color(.systemGray))
                    }
                    .padding(.bottom, 20)
                    
                    HStack{
                        Text("英聽")
                        Spacer()
                        Picker("", selection: $editingGsatEL){
                            Text("A級")
                                .tag(3)
                            Text("B級")
                                .tag(2)
                            Text("C級")
                                .tag(1)
                            Text("F級 / 未報考")
                                .tag(0)
                        }
                    }
                    .padding(10)
                    .background(Color(.systemBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemGray6), lineWidth: 1)
                    )
                    
                    HStack{
                        Text("身份")
                        Spacer()
                        Picker("", selection: $editingOtherSP){
                            Text("一般生 (+0%)")
                                .tag(0)
                            Section("原住民"){
                                Text("具語言認證原住民 (+35%)")
                                    .tag(1)
                                Text("無語言認證原住民 (+10%)")
                                    .tag(2)
                            }
                            Section("蒙藏僑生"){
                                Text("蒙藏生 (+25%)")
                                    .tag(3)
                                Text("僑生 (+25%)")
                                    .tag(4)
                            }
                            Section("政府外派人員子女"){
                                Text("返國就讀一學年內 (+25%)")
                                    .tag(5)
                                Text("返國就讀二學年內 (+15%)")
                                    .tag(6)
                                Text("返國就讀三學年內 (+10%)")
                                    .tag(7)
                            }
                            Section("境外優秀科技人才"){
                                Text("來臺就讀一學年內 (+25%)")
                                    .tag(8)
                                Text("來臺就讀二學年內 (+15%)")
                                    .tag(9)
                                Text("來臺就讀三學年內 (+10%)")
                                    .tag(10)
                            }
                            Section("退伍軍人"){
                                Text("服役五年退伍一年 (+25%)")
                                    .tag(11)
                                Text("服役五年退伍二年 (+20%)")
                                    .tag(12)
                                Text("服役五年退伍三年(+15%)")
                                    .tag(13)
                                Text("服役五年退伍五年(+10%)")
                                    .tag(14)
                                Text("服役四年退伍一年 (+20%)")
                                    .tag(15)
                                Text("服役四年退伍二年 (+15%)")
                                    .tag(16)
                                Text("服役四年退伍三年(+10%)")
                                    .tag(17)
                                Text("服役四年退伍五年(+5%)")
                                    .tag(18)
                                Text("服役三年退伍一年 (+15%)")
                                    .tag(19)
                                Text("服役三年退伍二年 (+10%)")
                                    .tag(20)
                                Text("服役三年退伍三年 (+5%)")
                                    .tag(21)
                                Text("服役三年退伍五年 (+3%)")
                                    .tag(22)
                                Text("服滿役期退伍三年 (+5%)")
                                    .tag(23)
                                Text("因公身障退伍三年 (+25%)")
                                    .tag(24)
                                Text("因病身障退伍三年 (+5%)")
                                    .tag(25)
                            }
                        }
                    }
                    .padding(10)
                    .background(Color(.systemBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemGray6), lineWidth: 1)
                    )
                    
                    Spacer()
                    HStack{
                        Button{
                            withAnimation(.easeInOut){
                                editingPage = 1
                            }
                        } label: {
                            HStack{
                                Image(systemName: "chevron.left")
                                Text("上一步")
                            }
                        }
                        Spacer()
                        Button{
                            isFinished = true
                            withAnimation(.easeInOut){
                                editingPage = 3
                            }
                            userData.userData.grade.append(UserGrade(dataName: "資料 #\(userData.userData.grade.count + 1)", GsatCH: returnScore(editingGsatCH), GsatEN: returnScore(editingGsatEN), GsatMA: returnScore(editingGsatMA), GsatMB: returnScore(editingGsatMB), GsatSO: returnScore(editingGsatSO), GsatSC: returnScore(editingGsatSC), GsatEL: editingGsatEL, AstMA: returnScore(editingAstMA), AstMB: returnScore(editingAstMB), AstPH: returnScore(editingAstPH), AstCH: returnScore(editingAstCH), AstBI: returnScore(editingAstBI), AstHI: returnScore(editingAstHI), AstGE: returnScore(editingAstGE), AstSO: returnScore(editingAstSO), SpecialType: editingOtherSP, SpecialPercentage: getPercentage(for: editingOtherSP)))
                        } label: {
                            HStack{
                                Text("完成")
                                Image(systemName: "chevron.right")
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                .inputCard()
                .disabled(editingPage != 2)
                
                if isFinished {
                    VStack(alignment: .center){
                        
                        Spacer()
                        VStack(spacing: 5){
                            Image(systemName: "checkmark.circle")
                                .font(.largeTitle)
                                .foregroundStyle(Color(.accent))
                            Text("完成!")
                                .font(.title2)
                                .bold()
                            Text("資料已登錄，請至分析頁查看分析結果")
                                .foregroundStyle(Color(.systemGray))
                        }
                        Spacer()
                        HStack{
                            Spacer()
                            Button{
                                withAnimation(.easeInOut){
                                    editingPage = 0
                                    isFinished = false
                                }
                            } label: {
                                HStack{
                                    Text("輸入新成績")
                                    Image(systemName: "arrow.trianglehead.clockwise")
                                }
                            }
                            .buttonStyle(.bordered)
                            Button{
                                withAnimation(.easeInOut){
                                    editingPage = 0
                                }
                            } label: {
                                HStack{
                                    Text("查看分析")
                                    Image(systemName: "chevron.right")
                                }
                            }
                            .buttonStyle(.borderedProminent)
                            Spacer()
                        }
                    }
                    .inputCard()
                    .disabled(editingPage != 3)
                }
                
            }
            .frame(width: 350, alignment: .leading)
            .offset(x: CGFloat(editingPage) * -358)
            .padding(.bottom)
            
            Spacer()
            
            HStack{
                Spacer()
            }
            
        }
        .padding()
    }
    
    private func valdiateScore(_ score: String) -> Bool {
        if score.isEmpty { return true } // 無成績
        guard let scoreInt = Int(score) else {
            return false // 不知輸入啥
        }
        return scoreInt >= 0 && scoreInt <= 60 // 是否正確輸入
    }
    
    private func returnScore(_ score: String) -> Int {
        if score.isEmpty {
            return -1
        }
        if let scoreInt = Int(score) {
            if scoreInt < 0 || scoreInt > 60 {
                return -1
            } else {
                return scoreInt
            }
        } else {
            return -1
        }
    }
    
    func getPercentage(for type: Int) -> Int {
        switch type {
        case 0: // 一般生
            return 0
        case 1: // 具語言認證原住民
            return 35
        case 3, 4, 5, 8, 11, 24: // 蒙藏生、僑生、返國一學年、來臺一學年、服役五年退伍一年、因公身障退伍三年
            return 25
        case 12, 15: // 服役五年退伍二年、服役四年退伍一年
            return 20
        case 6, 9, 13, 16, 19: // 返國二學年、來臺二學年、服役五年退伍三年、服役四年退伍二年、服役三年退伍一年
            return 15
        case 2, 7, 10, 14, 17, 20: // 無語言認證原住民、返國三學年、來臺三學年、服役五年退伍五年、服役四年退伍三年、服役三年退伍二年
            return 10
        case 18, 21, 23, 25: // 服役四年退伍五年、服役三年退伍三年、服滿役期退伍三年、因病身障退伍三年
            return 5
        case 22: // 服役三年退伍五年
            return 3
        default:
            return 0 // 未定義的 tag 返回 0
        }
    }
}

#Preview {
    InputView()
        .environmentObject(UserData())
}
