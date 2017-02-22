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
    
    init(address:Dictionary<String,Any>) {
        self.ten = address["ten"] as! String
        self.id = address["id"] as! Int
    }
    
    init(loaixe:LoaiXe) {
        self.ten = loaixe.ten
        self.id = loaixe.id
    }
}
