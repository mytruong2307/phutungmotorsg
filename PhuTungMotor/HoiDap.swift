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
        self.id = dic["id"] as! Int
        self.idkhachhang = dic["idkhachhang"] as! Int
        self.ten = dic["ten"] as! String
        self.email = dic["email"] as! String
        self.dienthoai = dic["dienthoai"] as! String
        self.cauhoi = dic["cauhoi"] as! String
        self.tomtat = dic["tomtat"] as! String
        if let tt = dic["tomtat"] as? String {
            self.tomtat = tt
        } else {
            self.tomtat = ""
        }
        if let traloi = dic["cautraloi"] as? String {
            self.cautraloi = traloi
        } else {
            self.cautraloi = ""
        }
        self.usertraloi = dic["usertraloi"] as! String
        self.userxacnhan = dic["userxacnhan"] as! String
        self.sendmail = dic["sendmail"] as! Int
        self.trangthai = dic["trangthai"] as! Int
        self.created_at = dic["created_at"] as! String
        self.updated_at = dic["updated_at"] as! String
    }
}
