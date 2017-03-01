//
//  File.swift
//  PhuTungMotor
//
//  Created by admin on 1/6/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation

struct HoiDap {
    var id:Int
    var idkhachhang:Int
    var ten:String
    var email:String
    var dienthoai:String
    var cauhoi:String
    var tomtat:String
    var cautraloi:String
    var usertraloi:String
    var userxacnhan:String
    var sendmail:Int
    var trangthai:Int
    var created_at:String
    var updated_at:String
    
    init() {
        self.id = 0
        self.idkhachhang = 0
        self.ten = ""
        self.email = ""
        self.dienthoai = ""
        self.cauhoi = ""
        self.tomtat = ""
        self.cautraloi = ""
        self.usertraloi = ""
        self.userxacnhan = ""
        self.sendmail = 0
        self.trangthai = 0
        self.created_at = ""
        self.updated_at = ""
    }
    
    init(dic:Dictionary<String,Any>) {
        self.init()
        if let id = dic["id"] as? Int {
            self.id = id
        }
        
        //chay local
        if ip != "" {
            if let idkhachhang = dic["idkhachhang"] as? Int {
                self.idkhachhang = idkhachhang
            }
            if let trangthai = dic["trangthai"] as? Int {
                self.trangthai = trangthai
            }
            if let sendmail = dic["sendmail"] as? Int {
                self.sendmail = sendmail
            }
        } else {
            //chay host
            if let trangthai = (dic["trangthai"] as? NSString)?.integerValue {
                self.trangthai = trangthai
            }
            if let sendmail = (dic["sendmail"] as? NSString)?.integerValue {
                self.sendmail = sendmail
            }
            if let idkhachhang = (dic["idkhachhang"] as? NSString)?.integerValue {
                self.idkhachhang = idkhachhang
            }
        }
        
        if let ten = dic["ten"] as? String {
            self.ten = ten
        }
        if let email = dic["email"] as? String {
            self.email = email
        }
        if let dienthoai = dic["dienthoai"] as? String {
            self.dienthoai = dienthoai
        }
        if let cauhoi = dic["cauhoi"] as? String {
            self.cauhoi = cauhoi
        }
        if let tt = dic["tomtat"] as? String {
            self.tomtat = tt
        }
        if let traloi = dic["cautraloi"] as? String {
            self.cautraloi = traloi
        }
        if let usertraloi = dic["usertraloi"] as? String {
            self.usertraloi = usertraloi
        }
        if let userxacnhan = dic["userxacnhan"] as? String {
            self.userxacnhan = userxacnhan
        }
        if let created_at = dic["created_at"] as? String {
            self.created_at = created_at
        }
        if let updated_at = dic["updated_at"] as? String {
            self.updated_at = updated_at
        }
    }
}
