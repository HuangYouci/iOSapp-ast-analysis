//
//  WebhookLog.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/4/27.
//

import Foundation

class WebhookLog {
    func logA(title: String, description: String, color: Int = 0x3498db, fields: [(String, String)] = []) {
        
        let webhookURL: String 保密保密保密Ａ
        
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
        
        let webhookURL: String 保密保密保密Ｂ
        
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
