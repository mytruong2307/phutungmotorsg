//
//  LoaiXe.swift
//  PhuTungMotor
//
//  Created by admin on 1/1/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation

struct LoaiXe {
    var hinh:String
    var ten:String
    var id:Int
    
    init() {
        self.hinh = ""
        self.id = 0
        self.ten = ""
    }
    
    init(loaixe:Dictionary<String,Any>) {
        self.init()
        if let id = loaixe["id"] as? Int {
            self.id = id
        }
        if let ten = loaixe["ten"] as? String {
            self.ten = ten
        }
        if let hinh = loaixe["hinh"] as? String {
            self.hinh = hinh
        }
    }
}
