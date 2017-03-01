//
//  Permission.swift
//  PhuTungMotor
//
//  Created by admin on 2/23/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

struct Permission {
    var imgIcon:UIImage
    var ten:String
    var soluong:Double //So  don hang, hoi dap, doanh thu
    
    init() {
        imgIcon = #imageLiteral(resourceName: "logo")
        ten = ""
        soluong = 0
    }
    
    init(dic:Dictionary<String,Any>) {
        self.init()
        if let ten = dic["ten"] as? String {
            self.ten = ten
        }
        
        if ip != "" {
            //Chay local
            if let soluong = dic["soluong"] as? Double {
                self.soluong = soluong
            }
        } else {
            //chay host
            if let soluong = (dic["soluong"] as? NSString)?.doubleValue {
                self.soluong = soluong
            }
        }
    }
}
