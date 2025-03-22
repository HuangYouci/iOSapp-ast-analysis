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
