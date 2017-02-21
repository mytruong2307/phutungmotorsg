//
//  GioHang.swift
//  PhuTungMotor
//
//  Created by admin on 2/19/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation

struct GioHang {
    
    var sanpham:SanPham
    var soluong:Int
    
    init() {
        self.sanpham = SanPham()
        self.soluong = 0
    }
    init(sanpham:SanPham, soluong:Int) {
        self.soluong = soluong
        self.sanpham = sanpham
    }
}
