//
//  NhanVien.swift
//  PhuTungMotor
//
//  Created by admin on 3/4/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation

struct NhanVien {
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
    var quyen:String
    var lanlogin:Int
    var tinhtrang:Int
    var createdAt:String
    
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
        self.quyen = ""
        self.lanlogin = 0
        self.tinhtrang = 0
        self.createdAt = ""
    }
    
    init(dic:Dictionary<String,Any>) {
        self.init()
        if let id = dic["id"] as? Int {
            self.id = id
        }
        if let ten = dic["ten"] as? String {
            self.ten = ten
        }
        if let quyen = dic["quyen"] as? String {
            self.quyen = quyen
        }
        if let email = dic["email"] as? String {
            self.email = email
        }
        if let dienthoai = dic["dienthoai"] as? String {
            self.dienthoai = dienthoai
        }
        if let xedangdung = dic["xedangdung"] as? String {
            self.xedangdung = xedangdung
        }
        if let tinh = dic["tinh"] as? String {
            self.tinh = tinh
        }
        if let quan = dic["quan"] as? String {
            self.quan = quan
        }
        if let phuong = dic["phuong"] as? String {
            self.phuong = phuong
        }
        if let sonha = dic["sonha"] as? String {
            self.sonha = sonha
        }
        if let gioitinh = dic["gioitinh"] as? String {
            self.gioitinh = gioitinh
        }
        if let maxacnhan = dic["maxacnhan"] as? String {
            self.maxacnhan = maxacnhan
        }
        if let created = dic["created_at"] as? String {
            self.createdAt = convertDateFromMySQL(strFromMySql: created)!
        }
        if ip != "" {
            if let lanlogin = dic["lanlogin"] as? Int {
                self.lanlogin = lanlogin
            }
            if let tinhtrang = dic["tinhtrang"] as? Int {
                self.tinhtrang = tinhtrang
            }
        } else {
            //Chay host
            if let lanlogin = (dic["lanlogin"] as? NSString)?.integerValue {
                self.lanlogin = lanlogin
            }
            if let tinhtrang = (dic["tinhtrang"] as? NSString)?.integerValue {
                self.tinhtrang = tinhtrang
            }
        }

    }
}
