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
    var favDept: [Int] = []
    var grade: [UserGrade] = []
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
}
