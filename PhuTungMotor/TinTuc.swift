//
//  TinTuc.swift
//  PhuTungMotor
//
//  Created by admin on 1/2/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation

struct TinTuc {
    var id:Int
    var tieude:String
    var nguontin:String
    var tomtat:String
    var noidung:String
    var hinhtin:String
    var noibat:Int
    var nguoiviet:String
    var created_at:String
    var updated_at:String
    
    init() {
        self.id = 0
        self.tieude = ""
        self.nguontin = ""
        self.tomtat = ""
        self.noidung = ""
        self.hinhtin = ""
        self.nguoiviet = ""
        self.created_at = ""
        self.updated_at = ""
        self.noibat = 0
    }
    init(dic:Dictionary<String,Any>) {
        self.id = dic["id"] as! Int
        self.tieude = dic["tieude"] as! String
        self.nguontin = dic["nguontin"] as! String
        self.tomtat = dic["tomtat"] as! String
        self.noidung = dic["noidung"] as! String
        self.hinhtin = dic["hinhtin"] as! String
        self.nguoiviet = dic["nguoiviet"] as! String
        self.created_at = dic["created_at"] as! String
        self.updated_at = dic["updated_at"] as! String
        self.noibat = dic["noibat"] as! Int
    }
    
}
