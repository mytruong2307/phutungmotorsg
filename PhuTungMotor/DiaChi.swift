//
//  DiaChi.swift
//  PhuTungMotor
//
//  Created by admin on 1/1/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation

struct Address {
    var id:Int
    var ten:String
    
    init() {
        self.id = 0
        self.ten = ""
    }
    
    init(address:Dictionary<String,Any>) {
        self.init()
        if let id = address["id"] as? Int {
            self.id = id
        }
        if let ten = address["ten"] as? String {
            self.ten = ten
        }
    }
    
    init(loaixe:LoaiXe) {
        self.ten = loaixe.ten
        self.id = loaixe.id
    }
}
