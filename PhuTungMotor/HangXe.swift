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
    
    init(hangxe:Dictionary<String,Any>) {
        self.hinh = hangxe["hinh"] as! String
        self.ten = hangxe["ten"] as! String
        self.id = hangxe["id"] as! Int
    }
}
