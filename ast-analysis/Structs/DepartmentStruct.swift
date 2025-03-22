//
//  DepartmentStruct.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/3/21.
//

import Foundation

struct Departments: Identifiable {
    // UUID 屬性
    let id = UUID()
    // 輸入屬性
    let schoolid: String
    let departmentid: String
    let schoolname: String
    let departmentname: String
    let chinesetest: String
    let englishtest: String
    let mathatest: String
    let mathbtest: String
    let socialtest: String
    let sciencetest: String
    let englishlistentest: String
    let matha: String
    let mathb: String
    let physics: String
    let chemistry: String
    let biology: String
    let history: String
    let geometry: String
    let social: String
    let gsatchinese: String
    let gsatenglish: String
    let gsatmatha: String
    let gsatmathb: String
    let gsatsocial: String
    let gsatscience: String
    let gsatskill: String
    let gsatskilltype: String
    let samecompare1: String
    let samecompare2: String
    let samecompare3: String
    let samecompare4: String
    let samecompare5: String
    let info: String
    // 計算屬性
    var fullname: String {
        return schoolname + departmentname
    }
    var code: String {
        return String(format: "%03d", Int(schoolid) ?? 0) + String(format: "%03d", Int(departmentid) ?? 0)
    }
    var mathaMultiplier: Double {
        if matha.isEmpty { return 0.0 }
        let multiplierString = matha.replacingOccurrences(of: "x", with: "")
        return Double(multiplierString) ?? 0.0
    }
    
    var mathbMultiplier: Double {
        if mathb.isEmpty { return 0.0 }
        let multiplierString = mathb.replacingOccurrences(of: "x", with: "")
        return Double(multiplierString) ?? 0.0
    }
    
    var physicsMultiplier: Double {
        if physics.isEmpty { return 0.0 }
        let multiplierString = physics.replacingOccurrences(of: "x", with: "")
        return Double(multiplierString) ?? 0.0
    }
    
    var chemistryMultiplier: Double {
        if chemistry.isEmpty { return 0.0 }
        let multiplierString = chemistry.replacingOccurrences(of: "x", with: "")
        return Double(multiplierString) ?? 0.0
    }
    
    var biologyMultiplier: Double {
        if biology.isEmpty { return 0.0 }
        let multiplierString = biology.replacingOccurrences(of: "x", with: "")
        return Double(multiplierString) ?? 0.0
    }
    
    var historyMultiplier: Double {
        if history.isEmpty { return 0.0 }
        let multiplierString = history.replacingOccurrences(of: "x", with: "")
        return Double(multiplierString) ?? 0.0
    }
    
    var geometryMultiplier: Double {
        if geometry.isEmpty { return 0.0 }
        let multiplierString = geometry.replacingOccurrences(of: "x", with: "")
        return Double(multiplierString) ?? 0.0
    }
    
    var socialMultiplier: Double {
        if social.isEmpty { return 0.0 }
        let multiplierString = social.replacingOccurrences(of: "x", with: "")
        return Double(multiplierString) ?? 0.0
    }
    
    var gsatchineseMultiplier: Double {
        if gsatchinese.isEmpty { return 0.0 }
        let multiplierString = gsatchinese.replacingOccurrences(of: "x", with: "")
        return Double(multiplierString) ?? 0.0
    }
    
    var gsatenglishMultiplier: Double {
        if gsatenglish.isEmpty { return 0.0 }
        let multiplierString = gsatenglish.replacingOccurrences(of: "x", with: "")
        return Double(multiplierString) ?? 0.0
    }
    
    var gsatmathaMultiplier: Double {
        if gsatmatha.isEmpty { return 0.0 }
        let multiplierString = gsatmatha.replacingOccurrences(of: "x", with: "")
        return Double(multiplierString) ?? 0.0
    }
    
    var gsatmathbMultiplier: Double {
        if gsatmathb.isEmpty { return 0.0 }
        let multiplierString = gsatmathb.replacingOccurrences(of: "x", with: "")
        return Double(multiplierString) ?? 0.0
    }
    
    var gsatsocialMultiplier: Double {
        if gsatsocial.isEmpty { return 0.0 }
        let multiplierString = gsatsocial.replacingOccurrences(of: "x", with: "")
        return Double(multiplierString) ?? 0.0
    }
    
    var gsatscienceMultiplier: Double {
        if gsatscience.isEmpty { return 0.0 }
        let multiplierString = gsatscience.replacingOccurrences(of: "x", with: "")
        return Double(multiplierString) ?? 0.0
    }
    
    var gsatskillMultiplier: Double {
        if gsatskill.isEmpty { return 0.0 }
        let multiplierString = gsatskill.replacingOccurrences(of: "x", with: "")
        return Double(multiplierString) ?? 1.0 // 預設為 1.0，因為它是倍率
    }
}
