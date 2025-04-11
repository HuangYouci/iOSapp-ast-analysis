//
//  HomeView.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/3/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var userData: UserData
    @EnvironmentObject private var iapManager: IAPManager
    @StateObject private var adViewModel = RewardedAdViewModel()
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 0){
                
                HStack{
                    Text("分科測驗分析")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    NavigationLink(destination: InfoView()){
                        Image(systemName: "info.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color(.label).opacity(0.5))
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                VStack{
                    VStack(alignment: .leading){
                        HStack(alignment: .center){
                            VStack{
                                Text({
                                    let now = Date()
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "MMM"
                                    dateFormatter.timeZone = TimeZone.current // 可選
                                    return dateFormatter.string(from: now)
                                }())
                                .font(.caption)
                                Text({
                                    let now = Date()
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "dd"
                                    dateFormatter.timeZone = TimeZone.current // 可選
                                    return dateFormatter.string(from: now)
                                }())
                                .font(.title3)
                                .bold()
                            }
                            .padding(1)
                            .foregroundStyle(Color(.red))
                            Circle()
                                .fill(Color(.label).opacity(0.5))
                                .frame(width: 5, height: 5)
                                .padding(.horizontal, 3)
                            VStack{
                                Text("分科倒數")
                                    .font(.caption)
                                Text({
                                    let components = Calendar.current.dateComponents([.day], from: Date(), to: Date(timeIntervalSince1970: 1752163200))
                                    
                                    if let days = components.day {
                                        if days > 0 {
                                            return "\(days)"
                                        } else {
                                            return "--"
                                        }
                                    } else {
                                        return "??"
                                    }
                                }())
                                .font(.title3)
                                .bold()
                            }
                            VStack{
                                Text("成績公布")
                                    .font(.caption)
                                Text({
                                    let components = Calendar.current.dateComponents([.day], from: Date(), to: Date(timeIntervalSince1970: 1753718400))
                                    
                                    if let days = components.day {
                                        if days > 0 {
                                            return "\(days)"
                                        } else {
                                            return "--"
                                        }
                                    } else {
                                        return "??"
                                    }
                                }())
                                .font(.title3)
                                .bold()
                            }
                            Circle()
                                .fill(Color(.label).opacity(0.5))
                                .frame(width: 5, height: 5)
                                .padding(.horizontal, 3)
                            VStack{
                                Text("分析次數")
                                    .font(.caption)
                                Text("\(userData.userData.analyzeCount)")
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

                    NavigationLink(destination: InputView()){
                        VStack(alignment: .leading, spacing: 20){
                            HStack(alignment: .bottom){
                                Text("成績輸入")
                                    .font(.title3)
                                Spacer()
                                Image(systemName: "square.and.pencil")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color(.accent))
                            }
                            Text(userData.userData.analyzeCount > 100000 ? "無限次分析啟用中" : "尚餘 \(userData.userData.analyzeCount) 次分析次數")
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: Color(.label).opacity(0.1),radius: 5)
                    }
                    .buttonStyle(.plain)
                    .disabled(userData.userData.analyzeCount < 1)
                    .padding(.horizontal)
                    
                    HStack{
                        NavigationLink(destination: DepartmentListView(departments: userData.userData.favDept, grade: UserGrade(id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!, dataName: "無資料", GsatCH: -1, GsatEN: -1, GsatMA: -1, GsatMB: -1, GsatSO: -1, GsatSC: -1, GsatEL: -1, AstMA: -1, AstMB: -1, AstPH: -1, AstCH: -1, AstBI: -1, AstHI: -1, AstGE: -1, AstSO: -1, SpecialType: -1, SpecialPercentage: -1), title: "喜愛科系")){
                            VStack(alignment: .leading, spacing: 20){
                                HStack(alignment: .bottom){
                                    Text("喜愛科系")
                                        .font(.title3)
                                    Spacer()
                                    Image(systemName: "heart")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                        .foregroundStyle(Color(.accent))
                                }
                                Text("共有 \(userData.userData.favDept.count) 個喜愛科系")
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: Color(.label).opacity(0.1),radius: 5)
                        }
                        .buttonStyle(.plain)
                        
                        NavigationLink(destination: ChoiceView()){
                            VStack(alignment: .leading, spacing: 20){
                                HStack(alignment: .bottom){
                                    Text("志願選擇")
                                        .font(.title3)
                                    Spacer()
                                    Image(systemName: "doc.text")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                        .foregroundStyle(Color(.accent))
                                }
                                Text("\(userData.userData.choDept.compactMap { $0 }.count) / 100 志願")
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: Color(.label).opacity(0.1),radius: 5)
                        }
                        .buttonStyle(.plain)
                        
                    }
                    .padding(.horizontal)
                    
                    HStack{
                        Text("分析次數")
                            .font(.caption)
                            .foregroundStyle(Color(.systemGray2))
                            .padding(.vertical, 5)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack{
                        
                        if adViewModel.isAdLoaded {
                            Button{
                                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                   let rootViewController = scene.windows.first?.rootViewController {
                                    adViewModel.showAd(from: rootViewController) {
                                        userData.userData.analyzeCount += 1
                                    }
                                }
                            } label: {
                                VStack(alignment: .leading, spacing: 20){
                                    HStack(alignment: .bottom){
                                        Text("分析次數")
                                            .font(.title3)
                                        Spacer()
                                        Image(systemName: "play.circle")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25, height: 25)
                                            .foregroundStyle(Color(.accent))
                                    }
                                    Text(adViewModel.isAdLoaded ? "觀看廣告以獲得" : "廣告尚未準備好")
                                }
                                .padding()
                                .background(Color(.systemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(color: Color(.label).opacity(0.1),radius: 5)
                            }
                            .buttonStyle(.plain)
                        } else {
                            NavigationLink(destination: MyAdView()){
                                VStack(alignment: .leading, spacing: 20){
                                    HStack(alignment: .bottom){
                                        Text("分析次數")
                                            .font(.title3)
                                        Spacer()
                                        Image(systemName: "play.circle")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25, height: 25)
                                            .foregroundStyle(Color(.accent))
                                    }
                                    Text("觀看廣告以獲得")
                                }
                                .padding()
                                .background(Color(.systemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(color: Color(.label).opacity(0.1),radius: 5)
                            }
                            .buttonStyle(.plain)
                        }
                        
                        NavigationLink(destination: ProView()){
                            VStack(alignment: .leading, spacing: 20){
                                HStack(alignment: .bottom){
                                    Text("付費用戶")
                                        .font(.title3)
                                    Spacer()
                                    Image(systemName: "crown")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                        .foregroundStyle(Color(.accent))
                                }
                                Text(userData.userData.analyzeCount > 100000 ? "感謝成為付費用戶" : "獲得無限分析次數")
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: Color(.label).opacity(0.1),radius: 5)
                        }
                        .buttonStyle(.plain)
                        
                    }
                    .padding(.horizontal)
                    
                    HStack{
                        Text("附加功能")
                            .font(.caption)
                            .foregroundStyle(Color(.systemGray2))
                            .padding(.vertical, 5)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    NavigationLink(destination: GuessView()){
                        VStack(alignment: .leading, spacing: 20){
                            HStack(alignment: .bottom){
                                Text("差距分析")
                                    .font(.title3)
                                Spacer()
                                Image(systemName: "sparkles")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color(.accent))
                            }
                            Text("以已知成績計算與校系的分數差距")
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: Color(.label).opacity(0.1),radius: 5)
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal)
                    
                }
                .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
                .background(Color(.secondarySystemBackground))
                
            }
        }
    }
    
}

struct HomeView_pad: View {
    @EnvironmentObject private var userData: UserData
    @EnvironmentObject private var iapManager: IAPManager
    @StateObject private var adViewModel = RewardedAdViewModel()
    @State private var windows: [Window] = []
    
    var body: some View {
        HStack(spacing: 0){
            VStack(alignment: .leading, spacing: 0){
                
                HStack{
                    Text("分科測驗分析")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    
                    Button {
                        if !windows.contains(where: { $0.name == "程式資訊" }) {
                            windows.append(Window(content: AnyView(InfoView()), name: "程式資訊"))
                        }
                    } label:{
                        Image(systemName: "info.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color(.label).opacity(0.5))
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                VStack{
                    VStack(alignment: .leading){
                        HStack(alignment: .center){
                            VStack{
                                Text({
                                    let now = Date()
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "MMM"
                                    dateFormatter.timeZone = TimeZone.current // 可選
                                    return dateFormatter.string(from: now)
                                }())
                                .font(.caption)
                                Text({
                                    let now = Date()
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "dd"
                                    dateFormatter.timeZone = TimeZone.current // 可選
                                    return dateFormatter.string(from: now)
                                }())
                                .font(.title3)
                                .bold()
                            }
                            .padding(1)
                            .foregroundStyle(Color(.red))
                            Circle()
                                .fill(Color(.label).opacity(0.5))
                                .frame(width: 5, height: 5)
                                .padding(.horizontal, 3)
                            VStack{
                                Text("分科倒數")
                                    .font(.caption)
                                Text({
                                    let components = Calendar.current.dateComponents([.day], from: Date(), to: Date(timeIntervalSince1970: 1752163200))
                                    
                                    if let days = components.day {
                                        if days > 0 {
                                            return "\(days)"
                                        } else {
                                            return "--"
                                        }
                                    } else {
                                        return "??"
                                    }
                                }())
                                .font(.title3)
                                .bold()
                            }
                            VStack{
                                Text("成績公布")
                                    .font(.caption)
                                Text({
                                    let components = Calendar.current.dateComponents([.day], from: Date(), to: Date(timeIntervalSince1970: 1753718400))
                                    
                                    if let days = components.day {
                                        if days > 0 {
                                            return "\(days)"
                                        } else {
                                            return "--"
                                        }
                                    } else {
                                        return "??"
                                    }
                                }())
                                .font(.title3)
                                .bold()
                            }
                            Circle()
                                .fill(Color(.label).opacity(0.5))
                                .frame(width: 5, height: 5)
                                .padding(.horizontal, 3)
                            VStack{
                                Text("分析次數")
                                    .font(.caption)
                                Text("\(userData.userData.analyzeCount)")
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

                    Button {
                        if !windows.contains(where: { $0.name == "成績輸入" }) {
                            windows.append(Window(content: AnyView(InputView()), name: "成績輸入"))
                        }
                    } label: {
                        VStack(alignment: .leading, spacing: 20){
                            HStack(alignment: .bottom){
                                Text("成績輸入")
                                    .font(.title3)
                                Spacer()
                                Image(systemName: "square.and.pencil")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color(.accent))
                            }
                            Text(userData.userData.analyzeCount > 100000 ? "無限次分析啟用中" : "尚餘 \(userData.userData.analyzeCount) 次分析次數")
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: Color(.label).opacity(0.1),radius: 5)
                    }
                    .buttonStyle(.plain)
                    .disabled(userData.userData.analyzeCount < 1)
                    .padding(.horizontal)
                    
                    HStack{
                        Button{
                            windows.append(Window(content: AnyView(DepartmentListView(departments: userData.userData.favDept, grade: UserGrade(id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!, dataName: "無資料", GsatCH: -1, GsatEN: -1, GsatMA: -1, GsatMB: -1, GsatSO: -1, GsatSC: -1, GsatEL: -1, AstMA: -1, AstMB: -1, AstPH: -1, AstCH: -1, AstBI: -1, AstHI: -1, AstGE: -1, AstSO: -1, SpecialType: -1, SpecialPercentage: -1), title: "喜愛科系")), name: "喜愛科系"))
                        } label: {
                            VStack(alignment: .leading, spacing: 20){
                                HStack(alignment: .bottom){
                                    Text("喜愛科系")
                                        .font(.title3)
                                    Spacer()
                                    Image(systemName: "heart")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                        .foregroundStyle(Color(.accent))
                                }
                                Text("共有 \(userData.userData.favDept.count) 個喜愛科系")
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: Color(.label).opacity(0.1),radius: 5)
                        }
                        .buttonStyle(.plain)
                        
                        Button {
                            windows.append(Window(content: AnyView(ChoiceView()), name: "志願選擇"))
                        } label: {
                            VStack(alignment: .leading, spacing: 20){
                                HStack(alignment: .bottom){
                                    Text("志願選擇")
                                        .font(.title3)
                                    Spacer()
                                    Image(systemName: "doc.text")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                        .foregroundStyle(Color(.accent))
                                }
                                Text("\(userData.userData.choDept.compactMap { $0 }.count) / 100 志願")
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: Color(.label).opacity(0.1),radius: 5)
                        }
                        .buttonStyle(.plain)
                        
                    }
                    .padding(.horizontal)
                    
                    Button {
                        windows.append(Window(content: AnyView(ResultView()), name: "分析結果"))
                    } label: {
                        VStack(alignment: .leading, spacing: 20){
                            HStack(alignment: .bottom){
                                Text("分析結果")
                                    .font(.title3)
                                Spacer()
                                Image(systemName: "chart.line.text.clipboard")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color(.accent))
                            }
                            Text("\(userData.userData.grade.count) 筆分析結果")
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: Color(.label).opacity(0.1),radius: 5)
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal)
                    
                    HStack{
                        Text("分析次數")
                            .font(.caption)
                            .foregroundStyle(Color(.systemGray2))
                            .padding(.vertical, 5)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack{
                        
                        if adViewModel.isAdLoaded {
                            Button{
                                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                   let rootViewController = scene.windows.first?.rootViewController {
                                    adViewModel.showAd(from: rootViewController) {
                                        userData.userData.analyzeCount += 1
                                    }
                                }
                            } label: {
                                VStack(alignment: .leading, spacing: 20){
                                    HStack(alignment: .bottom){
                                        Text("分析次數")
                                            .font(.title3)
                                        Spacer()
                                        Image(systemName: "play.circle")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25, height: 25)
                                            .foregroundStyle(Color(.accent))
                                    }
                                    Text(adViewModel.isAdLoaded ? "觀看廣告以獲得" : "廣告尚未準備好")
                                }
                                .padding()
                                .background(Color(.systemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(color: Color(.label).opacity(0.1),radius: 5)
                            }
                            .buttonStyle(.plain)
                        } else {
                            Button {
                                if !windows.contains(where: { $0.name == "廣告" }) {
                                    windows.append(Window(content: AnyView(MyAdView()), name: "廣告"))
                                }
                            } label: {
                                VStack(alignment: .leading, spacing: 20){
                                    HStack(alignment: .bottom){
                                        Text("分析次數")
                                            .font(.title3)
                                        Spacer()
                                        Image(systemName: "play.circle")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25, height: 25)
                                            .foregroundStyle(Color(.accent))
                                    }
                                    Text("觀看廣告以獲得")
                                }
                                .padding()
                                .background(Color(.systemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(color: Color(.label).opacity(0.1),radius: 5)
                            }
                            .buttonStyle(.plain)
                        }
                        
                        Button {
                           if !windows.contains(where: { $0.name == "付費用戶" }) {
                               windows.append(Window(content: AnyView(ProView()), name: "付費用戶"))
                           }
                       } label: {
                            VStack(alignment: .leading, spacing: 20){
                                HStack(alignment: .bottom){
                                    Text("付費用戶")
                                        .font(.title3)
                                    Spacer()
                                    Image(systemName: "crown")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                        .foregroundStyle(Color(.accent))
                                }
                                Text(userData.userData.analyzeCount > 100000 ? "感謝成為付費用戶" : "獲得無限分析次數")
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: Color(.label).opacity(0.1),radius: 5)
                        }
                        .buttonStyle(.plain)
                        
                    }
                    .padding(.horizontal)
                    
                    HStack{
                        Text("附加功能")
                            .font(.caption)
                            .foregroundStyle(Color(.systemGray2))
                            .padding(.vertical, 5)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    Button {
                        windows.append(Window(content: AnyView(GuessView()), name: "差距分析"))
                    } label: {
                        VStack(alignment: .leading, spacing: 20){
                            HStack(alignment: .bottom){
                                Text("差距分析")
                                    .font(.title3)
                                Spacer()
                                Image(systemName: "sparkles")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color(.accent))
                            }
                            Text("以已知成績計算與校系的分數差距")
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: Color(.label).opacity(0.1),radius: 5)
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal)
                    
                    Button {
                        windows.append(Window(content: AnyView(ListView()), name: "科系列表"))
                    } label: {
                        VStack(alignment: .leading, spacing: 20){
                            HStack(alignment: .bottom){
                                Text("科系列表")
                                    .font(.title3)
                                Spacer()
                                Image(systemName: "list.bullet")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color(.accent))
                            }
                            Text("瀏覽所有大學科系列表")
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: Color(.label).opacity(0.1),radius: 5)
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal)
                    
                }
                .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
                .background(Color(.secondarySystemBackground))
                
            }
            .frame(width: UIScreen.main.bounds.width * 0.35)
            GeometryReader { geometry in
                ZStack{
                    Color(.secondarySystemBackground)
                        .ignoresSafeArea()
                    ForEach($windows) { $window in
                        VStack(spacing: 0) { // 使用 VStack 將手柄和內容分開
                            // 拖曳手柄
                            Color(.systemBackground)
                                .frame(height: 30)
                                .overlay(
                                    HStack(alignment: .bottom) {
                                    Button(action: {
                                        // 關閉該視窗
                                        if let index = windows.firstIndex(where: { $0.id == window.id }) {
                                            windows.remove(at: index)
                                        }
                                    }) {
                                        Circle()
                                            .fill(Color(.red))
                                            .frame(width: 15, height: 15)
                                    }
                                    .padding(.leading, 5)
                                    Text(window.name)
                                            .font(.caption)
                                    Spacer()
                                }
                                )
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            if let index = windows.firstIndex(where: { $0.id == window.id }) {
                                                let movedWindow = windows.remove(at: index) // 移除該視窗
                                                windows.append(movedWindow) // 添加到最後（最上層）
                                            }
                                            let windowWidth: CGFloat = 300
                                            let windowHeight: CGFloat = 600
                                            let containerWidth = geometry.size.width
                                            let containerHeight = geometry.size.height
                                            
                                            // 基於當前 offset 平滑移動
                                            let newOffsetX = window.offset.width + value.translation.width
                                            let newOffsetY = window.offset.height + value.translation.height
                                            
                                            // 限制邊界
                                            let minX = -containerWidth / 2 + windowWidth / 2
                                            let maxX = containerWidth / 2 - windowWidth / 2
                                            let minY = -containerHeight / 2 + windowHeight / 2
                                            let maxY = containerHeight / 2 - windowHeight / 2
                                            
                                            window.offset = CGSize(
                                                width: min(max(newOffsetX, minX), maxX),
                                                height: min(max(newOffsetY, minY), maxY)
                                            )
                                        }
                                )
                            NavigationStack{
                                window.content
                            }
                            .frame(width: 380, height: 680)
                        }
                        .frame(width: 380, height: 700)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .offset(window.offset)
                    }
                }
            }
        }
    }
}



#Preview {
    HomeView()
        .environmentObject(IAPManager())
        .environmentObject(UserData())
}

#Preview {
    HomeView_pad()
        .environmentObject(IAPManager())
        .environmentObject(UserData())
}
