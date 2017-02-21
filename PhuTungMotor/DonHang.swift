//
//  DonHang.swift
//  PhuTungMotor
//
//  Created by admin on 2/20/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation

struct DonHang {
    var id:Int
    var khachhang_id:Int
    var cachthanhtoan:Int
    var thanhtoan:Int
    var trangthai:Int
    var tongtien:Double
    var xacnhan:String
    var ghichu:String
    var createdAt:String
    var updateAt:String
    var listSP:Array<GioHang>
    
    init() {
        id = 0
        khachhang_id = 0
        cachthanhtoan = 0
        thanhtoan = 0
        trangthai = 0
        tongtien = 0
        xacnhan = ""
        ghichu = ""
        createdAt = ""
        updateAt = ""
        listSP = []
    }
    
    init(dic:Dictionary<String,Any>) {
        self.init()
        if let id = dic["id"] as? Int {
            self.id = id
        }
        if let khachhang_id = dic["khachhang_id"] as? Int {
            self.khachhang_id = khachhang_id
        }
        if let cachthanhtoan = dic["cachthanhtoan"] as? Int {
            self.cachthanhtoan = cachthanhtoan
        }
        if let thanhtoan = dic["thanhtoan"] as? Int {
            self.thanhtoan = thanhtoan
        }
        if let trangthai = dic["trangthai"] as? Int {
            self.trangthai = trangthai
        }
        if let tongtien = dic["tongtien"] as? Double {
            self.tongtien = tongtien
        }
        if let maxacnhan = dic["maxacnhan"] as? String {
            self.xacnhan = maxacnhan
        }
        if let ghichu = dic["ghichu"] as? String {
            self.ghichu = ghichu
        }
        if let createdAt = dic["created_at"] as? String {
            self.createdAt = createdAt
        }
        if let updateAt = dic["update_at"] as? String {
            self.updateAt = updateAt
        }
    }
}
