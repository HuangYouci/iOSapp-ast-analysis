//
//  LevelConstants.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/3/22.
//

struct LevelConstants {
    
    // 本資料年份
    static var programVersion: String = "v1.1.2"
    static var dataVersion: String = "114"

    // 分科五標請要減 1 後乘以 4 ! 比較時需「大於」 !
    // 國文
    static var CHLevel1: Int = 48 // 頂標
    static var CHLevel2: Int = 44 // 前標
    static var CHLevel3: Int = 36 // 均標
    static var CHLevel4: Int = 32 // 後標
    static var CHLevel5: Int = 24 // 底標

    // 英文
    static var ENLevel1: Int = 48 // 頂標
    static var ENLevel2: Int = 40 // 前標
    static var ENLevel3: Int = 28 // 均標
    static var ENLevel4: Int = 12 // 後標
    static var ENLevel5: Int = 8  // 底標

    // 數學A
    static var MALevel1: Int = 40 // 頂標
    static var MALevel2: Int = 32 // 前標
    static var MALevel3: Int = 20 // 均標
    static var MALevel4: Int = 12 // 後標
    static var MALevel5: Int = 8  // 底標

    // 數學B
    static var MBLevel1: Int = 44 // 頂標
    static var MBLevel2: Int = 36 // 前標
    static var MBLevel3: Int = 20 // 均標
    static var MBLevel4: Int = 12 // 後標
    static var MBLevel5: Int = 8  // 底標

    // 社會
    static var SOLevel1: Int = 48 // 頂標
    static var SOLevel2: Int = 44 // 前標
    static var SOLevel3: Int = 36 // 均標
    static var SOLevel4: Int = 28 // 後標
    static var SOLevel5: Int = 24 // 底標

    // 自然
    static var SCLevel1: Int = 48 // 頂標
    static var SCLevel2: Int = 44 // 前標
    static var SCLevel3: Int = 32 // 均標
    static var SCLevel4: Int = 24 // 後標
    static var SCLevel5: Int = 16 // 底標
}
