//
//  SanPham.swift
//  PhuTungMotor
//
//  Created by admin on 1/1/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

struct SanPham {
    var hinh:String
    var ten:String
    var gia:Double
    var id:Int
    var giamgia:Double
    var code:String
    
    init(sanpham:Dictionary<String,Any>) {
        self.hinh = sanpham["hinh"] as! String
        self.id = sanpham["id"] as! Int
        self.ten = sanpham["ten"] as! String
        self.code = sanpham["code"] as! String
        self.gia = sanpham["gia"] as! Double
        self.giamgia = sanpham["giamgia"] as! Double
    }
    static func showPrice(sp:SanPham)->NSMutableAttributedString{
        let giagoc:Double = sp.giamgia + sp.gia
        let gg = showVNCurrency(gia: giagoc)
        let result:NSMutableAttributedString = NSMutableAttributedString(string: gg)
        result.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, result.length))
        return result
    }
    static func showVNCurrency(gia:Double) -> String {
        var giamoi:IntMax = IntMax (gia)
        var result:String = ""
        while giamoi >= 1000 {
            let du = showNumber (so: giamoi % 1000)
            if result != "" {
                result = "\(du).\(result)"
            } else {
                result = "\(du)"
            }
            
            giamoi = giamoi / 1000
        }
        result = "\(giamoi).\(result)"
        //        print(result)
        return result
    }
    static func showNumber(so:IntMax)->String {
        var kq:String = ""
        if so < 10 {
            kq =  "00\(so)"
        } else if so < 100 {
            kq = "0\(so)"
        } else {
            kq = "\(so)"
        }
        return kq
        
    }
    
}
