//
//  CellHoiDap.swift
//  PhuTungMotor
//
//  Created by admin on 1/6/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class CellHoiDap: BaseCollectCell {
    
    let lblCauHoi:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.numberOfLines = 0
        return v
    } ()
    
    let lblNguoiHoi:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    } ()
    
    let lblNgayHoi:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    } ()
    
    let lblTomTat:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.numberOfLines = 0
        return v
    } ()
    
    var hoidap = HoiDap()
    
    override func setupView() {
        addSubview(lblCauHoi)
        addSubview(lblTomTat)
        addSubview(lblNgayHoi)
        addSubview(lblNguoiHoi)
        
        addContraintByVSF(VSF: "H:|-20-[v0]-20-|", views: lblCauHoi)
        addContraintByVSF(VSF: "H:|-20-[v0]-20-|", views: lblTomTat)
        addContraintByVSF(VSF: "H:|-20-[v0]-20-|", views: lblNguoiHoi)
        addContraintByVSF(VSF: "H:|-20-[v0]-20-|", views: lblNgayHoi)
        addContraintByVSF(VSF: "V:|[v0][v1][v2][v3]|", views: lblCauHoi, lblNguoiHoi, lblNgayHoi, lblTomTat)
    }
    override func setupData() {
        lblCauHoi.text = hoidap.cauhoi
        lblNguoiHoi.text = hoidap.ten
        lblNgayHoi.text = hoidap.created_at
        lblTomTat.text = hoidap.tomtat
    }
}
