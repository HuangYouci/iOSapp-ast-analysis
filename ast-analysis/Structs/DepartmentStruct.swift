//
//  DepartmentStruct.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/3/21.
//

import Foundation

struct Departments: Identifiable, Codable {
    // UUID 屬性
    var id = UUID()
    // MARK: - 輸入屬性
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
    let resultCombine: String
    let resultPeople: String
    let resultScore: String
    // MARK: - 計算屬性
    // 在建立時就創建好的
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
        return Double(multiplierString) ?? 1.0
    }
    var resultCombineArray: [(String, Double)] {
        if resultCombine == "#N/A" || resultCombine.isEmpty {
            return []
        }
        
        // 定義科目名稱的轉換規則
        let subjectMapping: [String: String] = [
            "國": "國文",
            "英": "英文",
            "數A": "數Ａ",
            "數B": "數Ｂ",
            "自": "自然",
            "社": "社會",
            "物": "物理",
            "化": "化學",
            "生": "生物",
            "歷": "歷史",
            "地": "地理",
            "公": "公民"
        ]
        
        let components = resultCombine.split(separator: " ").map { String($0) }
        var result: [(String, Double)] = []
        
        for component in components {
            let parts = component.split(separator: "x").map { String($0) }
            guard parts.count == 2 else { continue }
            
            let subject = parts[0]
            let scoreString = parts[1]
            
            // 檢查是否有對應的轉換，如果有則使用轉換後的名稱，否則保持原樣
            let transformedSubject = subjectMapping[subject] ?? subject
            
            if let score = Double(scoreString) {
                result.append((transformedSubject, score))
            }
        }
        
        return result
    }
    var resultTotalMultiplier: Double {
        let result = resultCombineArray.reduce(0.0) {
            $0 + ($1.1.isNaN ? 0.0 : $1.1)
        }
        if result > 0 {
            return result
        } else {
            return 1.0
        }
    }
    // 後續計算屬性 依結果 順序
    var calculatedPercent: Double = 0
    var calculatedType: DepartmentCalculatedType = .notCaluclated
}

enum DepartmentCalculatedType: Codable {
    case notCaluclated
    case normal
    case nodata
    case nopass
}
