//
//  KhachHang.swift
//  PhuTungMotor
//
//  Created by admin on 1/1/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation

struct KhachHang {
    var id:Int
    var ten:String
    var email:String
    var dienthoai:String
    var xedangdung:String
    var tinh:String
    var quan:String
    var phuong:String
    var sonha:String
    var gioitinh:String
    var maxacnhan:String
    
    init(khachhang:Dictionary<String,Any>) {
        self.id = khachhang["id"] as! Int
        self.ten = khachhang["ten"] as! String
        self.email = khachhang["email"] as! String
        self.dienthoai = khachhang["dienthoai"] as! String
        self.xedangdung = khachhang["xedangdung"] as! String
        self.tinh = khachhang["tinh"] as! String
        self.quan = khachhang["quan"] as! String
        self.phuong = khachhang["phuong"] as! String
        self.sonha = khachhang["sonha"] as! String
        self.gioitinh = khachhang["gioitinh"] as! String
        self.maxacnhan = khachhang["maxacnhan"] as! String
    }
}
