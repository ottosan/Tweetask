//
//  Task.swift
//  
//
//  Created by 音石朋恵 on 2017/02/20.
//
//

import Foundation
import RealmSwift

class Task: Object {
    // 管理用 ID。プライマリーキー
    dynamic var id = 0
    
    // タイトル
    dynamic var title = ""
    
    // メモ
    dynamic var memo = ""
    
    /// 日時
    dynamic var date:NSDate! = nil
    
    /**
     id をプライマリーキーとして設定
     */
    override static func primaryKey() -> String? {
        return "id"
    }
}
