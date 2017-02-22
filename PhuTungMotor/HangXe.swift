//
//  HangXe.swift
//  PhuTungMotor
//
//  Created by admin on 1/1/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation

struct HangXe {
    var hinh:String
    var ten:String
    var id:Int
    
    init() {
        self.hinh = ""
        self.ten = ""
        self.id = 0
    }
    
    init(hangxe:Dictionary<String,Any>) {
        self.init()
        if let id = hangxe["id"] as? Int {
            self.id = id
        }
        if let ten = hangxe["ten"] as? String {
            self.ten = ten
        }
        if let hinh = hangxe["hinh"] as? String {
            self.hinh = hinh
        }
    }
}
