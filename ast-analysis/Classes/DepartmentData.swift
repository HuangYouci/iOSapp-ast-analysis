//
//  DepartmentData.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/3/21.
//

import SwiftCSV
import Foundation

class DepartmentData: ObservableObject {
    @Published var departments: [Departments] = []
    
    init() {
        self.departments = loadCSV()
    }
    
    private func loadCSV() -> [Departments] {
        guard let url = Bundle.main.url(forResource: "114", withExtension: "csv") else {
            print("DepartmentData | No CSV Data Founded")
            return []
        }
        do {
            let csv = try NamedCSV(url: url)
            var data: [Departments] = []
            for row in csv.rows {
                let department = Departments(
                    schoolid: row["schoolid"] ?? "",
                    departmentid: row["departmentid"] ?? "",
                    schoolname: row["schoolname"] ?? "",
                    departmentname: row["departmentname"] ?? "",
                    chinesetest: row["chinesetest"] ?? "",
                    englishtest: row["englishtest"] ?? "",
                    mathatest: row["mathatest"] ?? "",
                    mathbtest: row["mathbtest"] ?? "",
                    socialtest: row["socialtest"] ?? "",
                    sciencetest: row["sciencetest"] ?? "",
                    englishlistentest: row["englishlistentest"] ?? "",
                    matha: row["matha"] ?? "",
                    mathb: row["mathb"] ?? "",
                    physics: row["physics"] ?? "",
                    chemistry: row["chemistry"] ?? "",
                    biology: row["biology"] ?? "",
                    history: row["history"] ?? "",
                    geometry: row["geometry"] ?? "",
                    social: row["social"] ?? "",
                    gsatchinese: row["gsatchinese"] ?? "",
                    gsatenglish: row["gsatenglish"] ?? "",
                    gsatmatha: row["gsatmatha"] ?? "",
                    gsatmathb: row["gsatmathb"] ?? "",
                    gsatsocial: row["gsatsocial"] ?? "",
                    gsatscience: row["gsatscience"] ?? "",
                    gsatskill: row["gsatskill"] ?? "",
                    gsatskilltype: row["gsatskilltype"] ?? "",
                    samecompare1: row["samecompare1"] ?? "",
                    samecompare2: row["samecompare2"] ?? "",
                    samecompare3: row["samecompare3"] ?? "",
                    samecompare4: row["samecompare4"] ?? "",
                    samecompare5: row["samecompare5"] ?? "",
                    info: row["info"] ?? ""
                )
                data.append(department)
            }
            return data
        } catch {
            print("DepartmentData | Error loading or parsing CSV: \(error)")
            return []
        }
    }
}

