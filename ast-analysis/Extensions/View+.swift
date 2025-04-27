//
//  View+.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/3/21.
//

import SwiftUI

extension View {
    
    func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                           to: nil,
                                           from: nil,
                                           for: nil)
        }
    
    func inputCard() -> some View {
        self
            .padding()
            .frame(width: 350, height: 400, alignment: .topLeading)
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: Color(.label).opacity(0.1),radius: 5)
    }
    
    func scoreCard() -> some View {
        self
            .padding()
            .frame(width: 350, alignment: .topLeading)
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.systemGray6), lineWidth: 2)
            )
            .shadow(color: Color(.label).opacity(0.1),radius: 5)
    }
    
}
