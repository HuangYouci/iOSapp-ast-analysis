//
//  UserData.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/3/21.
//

import SwiftUI

class UserData: ObservableObject {
    
    @Published var userData: User {
        didSet {
            UserDefaults.standard.set(try? JSONEncoder().encode(userData), forKey: "userData")
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "userData"),
           let decodedUser = try? JSONDecoder().decode(User.self, from: data) {
            self.userData = decodedUser
        } else {
            self.userData = User() // 預設值
        }
    }
    
}

func testJSONEncodability<T: Encodable>(_ data: T) {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted // 可選：讓輸出易於閱讀
    
    do {
        let jsonData = try encoder.encode(data)
        print("資料成功編碼為 JSON:")
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            print(jsonString)
        }
    } catch {
        print("無法編碼為 JSON，錯誤資訊:")
        switch error {
        case EncodingError.invalidValue(let value, let context):
            print("無效值: \(value)")
            print("問題路徑: \(context.codingPath.map { $0.stringValue }.joined(separator: " -> "))")
            print("詳細描述: \(context.debugDescription)")
            if let underlyingError = context.underlyingError {
                print("底層錯誤: \(underlyingError)")
            }
        default:
            print("其他錯誤: \(error)")
        }
    }
}
