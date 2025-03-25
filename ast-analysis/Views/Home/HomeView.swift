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
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                    Text("分科測驗分析")
                        .font(.largeTitle)
                        .bold()
                    Text("落點分析、校系資訊")
                        .foregroundStyle(Color(.systemGray))
                }
                .padding()
                FlowLayout{
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
                        .frame(width: 350)
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.systemGray6), lineWidth: 2)
                        )
                        .shadow(color: Color(.label).opacity(0.1),radius: 5)
                    }
                    .buttonStyle(.plain)
                    .disabled(userData.userData.analyzeCount < 1)
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
                        .frame(width: 170)
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.systemGray6), lineWidth: 2)
                        )
                        .shadow(color: Color(.label).opacity(0.1),radius: 5)
                    }
                    .buttonStyle(.plain)
                    NavigationLink(destination: ChoiceView()){
                        VStack(alignment: .leading, spacing: 20){
                            HStack(alignment: .bottom){
                                Text("志願填寫")
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
                        .frame(width: 170)
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.systemGray6), lineWidth: 2)
                        )
                        .shadow(color: Color(.label).opacity(0.1),radius: 5)
                    }
                    .buttonStyle(.plain)
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
                        .frame(width: 170)
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.systemGray6), lineWidth: 2)
                        )
                        .shadow(color: Color(.label).opacity(0.1),radius: 5)
                    }
                    .buttonStyle(.plain)
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
                            .frame(width: 170)
                            .background(Color(.systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(.systemGray6), lineWidth: 2)
                            )
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
                            .frame(width: 170)
                            .background(Color(.systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(.systemGray6), lineWidth: 2)
                            )
                            .shadow(color: Color(.label).opacity(0.1),radius: 5)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
                Spacer()
                HStack{
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
