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
        self.hinh = loaixe["hinh"] as! String
        self.id = loaixe["id"] as! Int
        self.ten = loaixe["ten"] as! String
    }
}
