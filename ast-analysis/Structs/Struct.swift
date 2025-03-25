//
//  Untitled.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/3/21.
//

import SwiftUI

struct User: Identifiable, Codable {
    var id = UUID()
    var name: String = "用戶"
    var type: Int = 0
    var favDept: [Departments] = []
    var choDept: [Departments?] = Array(repeating: nil, count: 100)
    var grade: [UserGrade] = []
    var analyzeCount: Int = 0
}

struct UserGrade: Identifiable, Codable {
    var id = UUID()
    var dataName: String
    var GsatCH: Int
    var GsatEN: Int
    var GsatMA: Int
    var GsatMB: Int
    var GsatSO: Int
    var GsatSC: Int
    var GsatEL: Int
    var AstMA: Int
    var AstMB: Int
    var AstPH: Int
    var AstCH: Int
    var AstBI: Int
    var AstHI: Int
    var AstGE: Int
    var AstSO: Int
    var SpecialType: Int
    var SpecialPercentage: Int
    // 系統分析
    var analyse: [[Departments]] = [[]]
}

// pad

struct Window: Identifiable {
    let id = UUID()
    var offset: CGSize = .zero
    var content: AnyView // 儲存視窗的內容
    var name: String
}
