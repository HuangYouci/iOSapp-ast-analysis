//
//  TipView.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/6/4.
//


import SwiftUI


struct TipView: View {
    @ObservedObject var userData = UserData.shared

    let keyName: String
    let title: String
    let content: String

    private var shouldShowTip: Bool {
        return !(userData.tips[keyName] ?? false)
    }

    var body: some View {
        Group {
            if shouldShowTip {
                VStack(alignment: .leading) {
                    HStack{
                        Image(systemName: "lightbulb.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color.accentColor)
                        Text(title)
                            .bold()
                        Spacer()
                        Button {
                            userData.tips[keyName] = true
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(Color(.tertiaryLabel))
                                .font(.caption)
                        }
                    }
                    Text(content)
                }
                .padding()
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: Color(.label).opacity(0.1), radius: 5)
                .padding(.horizontal)
            } else {
                EmptyView()
            }
        }
        .onAppear {
            if userData.tips[keyName] == nil {
                userData.tips[keyName] = false
            }
        }
    }
}
