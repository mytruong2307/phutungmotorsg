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
        self.init()
        if let id = dic["id"] as? Int {
            self.id = id
        }
        
        if ip != "" {
            //chay local
            if let noibat = dic["noibat"] as? Int {
                self.noibat = noibat
            }
        } else {
            //chay host
            if let noibat = (dic["noibat"] as? NSString)?.integerValue {
                self.noibat = noibat
            }
        }
        
        if let tieude = dic["tieude"] as? String {
            self.tieude = tieude
        }
        if let nguontin = dic["nguontin"] as? String {
            self.nguontin = nguontin
        }
        if let tomtat = dic["tomtat"] as? String {
            self.tomtat = tomtat
        }
        if let noidung = dic["noidung"] as? String {
            self.noidung = noidung
        }
        if let hinhtin = dic["hinhtin"] as? String {
            self.hinhtin = hinhtin
        }
        if let nguoiviet = dic["nguoiviet"] as? String {
            self.nguoiviet = nguoiviet
        }
        if let created_at = dic["created_at"] as? String {
            self.created_at = created_at
        }
        if let updated_at = dic["updated_at"] as? String {
            self.updated_at = updated_at
        }
    }
}
