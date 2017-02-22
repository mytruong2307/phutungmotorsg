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
    var quyen:Array<String>
    
    init() {
        self.id = 0
        self.ten = ""
        self.email = ""
        self.dienthoai = ""
        self.xedangdung = ""
        self.tinh = ""
        self.quan = ""
        self.phuong = ""
        self.sonha = ""
        self.gioitinh = ""
        self.maxacnhan = ""
        self.quyen = []
    }
    
    init(khachhang:Dictionary<String,Any>) {
        self.init()
        if let id = khachhang["id"] as? Int {
            self.id = id
        }
        if let ten = khachhang["ten"] as? String {
            self.ten = ten
        }
        if let quyen = khachhang["quyen"] as? Array<String> {
            self.quyen = quyen
        }
        if let email = khachhang["email"] as? String {
            self.email = email
        }
        if let dienthoai = khachhang["dienthoai"] as? String {
            self.dienthoai = dienthoai
        }
        if let xedangdung = khachhang["xedangdung"] as? String {
            self.xedangdung = xedangdung
        }
        if let tinh = khachhang["tinh"] as? String {
            self.tinh = tinh
        }
        if let quan = khachhang["quan"] as? String {
            self.quan = quan
        }
        if let phuong = khachhang["phuong"] as? String {
            self.phuong = phuong
        }
        if let sonha = khachhang["sonha"] as? String {
            self.sonha = sonha
        }
        if let gioitinh = khachhang["gioitinh"] as? String {
            self.gioitinh = gioitinh
        }
        if let maxacnhan = khachhang["maxacnhan"] as? String {
            self.maxacnhan = maxacnhan
        }
    }
}
