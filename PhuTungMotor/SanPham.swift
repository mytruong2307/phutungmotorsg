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
    
    var hinh:Array<UIImage>
    var ten:String
    var gia:Double
    var id:Int
    var giamgia:Double
    var code:String
    var loaixe_id:Int
    var loaixe:String
    var hangxe:String
    var soluong:Int
    
    init() {
        self.hinh = []
        self.id = 0
        self.ten = ""
        self.code = ""
        self.gia = 0
        self.giamgia = 0
        self.loaixe_id = 0
        self.soluong = 0
        self.loaixe = ""
        self.hangxe = ""
    }
    
    init(sanpham:Dictionary<String,Any>) {
        self.init()
        
        if let id = sanpham["id"] as? Int {
            self.id = id
        }
        
        //Chay local
        if ip != "" {
            if let lx_id = sanpham["loaixe_id"] as? Int {
                self.loaixe_id = lx_id
            }
            if let soluong = sanpham["tonkho"] as? Int {
                self.soluong = soluong
            }
            if let gia = sanpham["gia"] as? Double {
                self.gia = gia
            }
            if let giamgia = sanpham["giamgia"] as? Double {
                self.giamgia = giamgia
            }
        } else {
            //Chay host
            if let newgia = (sanpham["loaixe_id"] as? NSString)?.integerValue {
                self.loaixe_id = newgia
            }
            if let newgia = (sanpham["giamgia"] as? NSString)?.doubleValue {
                self.giamgia = newgia
            }
            if let newgia = (sanpham["gia"] as? NSString)?.doubleValue {
                self.gia = newgia
            }
            if let newgia = (sanpham["tonkho"] as? NSString)?.integerValue {
                self.soluong = newgia
            }
        }
        
        
        if let code = sanpham["code"] as? String {
            self.code = code
        }
        if let ten = sanpham["ten"] as? String {
            self.ten = ten
        }
        if let lx = sanpham["loaixe"] as? String {
            self.loaixe = lx
        }
        if let hx = sanpham["hangxe"] as? String {
            self.hangxe = hx
        }
    }
    
    
}
