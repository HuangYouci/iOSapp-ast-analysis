//
//  WebhookLog.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/4/27.
//

import Foundation

class WebhookLog {
    func logA(title: String, description: String, color: Int = 0x3498db, fields: [(String, String)] = []) {
        
        let webhookURL: String = "https://discord.com/api/webhooks/1379734004391088259/wEEOBzgw7Tvp2voTDXQ5eWP7HubdsjZFl1fw9r79_Xsx_zWOa09MIb55Y1Ik9eHd1uXR"
        
        var embedFields: [[String: String]] = []
        for (name, value) in fields {
            embedFields.append([
                "name": name,
                "value": value
            ])
        }
        
        let payload: [String: Any] = [
            "embeds": [[
                "title": title,
                "description": description,
                "color": color,
                "fields": embedFields,
                "footer": [
                    "text": "\(Date().formatted(date: .numeric, time: .standard))"
                ]
            ]]
        ]

        guard let url = URL(string: webhookURL),
              let data = try? JSONSerialization.data(withJSONObject: payload, options: []) else {
            print("WebhookLog | 無法建立請求資料")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("WebhookLog | 送出失敗：\(error)")
            } else {
                print("WebhookLog | 送出成功")
            }
        }
        task.resume()
    }
    func logB(title: String, description: String, color: Int = 0x3498db, fields: [(String, String)] = []) {
        
        let webhookURL: String = "https://discord.com/api/webhooks/1379734188059525122/08LsOVzQWAOpHzQ4zzAC37q0StvgdmUXaeIDKeM0rs4gTSzlOrre9Pjg1jFqvrijUmY8"
        
        var embedFields: [[String: String]] = []
        for (name, value) in fields {
            embedFields.append([
                "name": name,
                "value": value,
                "inline": "true"
            ])
        }
        
        let payload: [String: Any] = [
            "embeds": [[
                "title": title,
                "description": description,
                "color": color,
                "fields": embedFields,
                "footer": [
                    "text": "\(Date().formatted(date: .numeric, time: .standard))"
                ]
            ]]
        ]

        guard let url = URL(string: webhookURL),
              let data = try? JSONSerialization.data(withJSONObject: payload, options: []) else {
            print("WebhookLog | 無法建立請求資料")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("WebhookLog | 送出失敗：\(error)")
            } else {
                print("WebhookLog | 送出成功")
            }
        }
        task.resume()
    }
}
