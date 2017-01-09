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
        v.font = UIFont.boldSystemFont(ofSize: 14)
        return v
    } ()
    
    let lblNguoiHoi:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont.boldSystemFont(ofSize: 17)
        v.textColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        return v
    } ()
    
    let lblNgayHoi:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont.systemFont(ofSize: 14)
        return v
    } ()
    
    let lblTomTat:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont.systemFont(ofSize: 14)
        return v
    } ()
    
    var hoidap = HoiDap()
    
    override func setupView() {
        addSubview(lblCauHoi)
        addSubview(lblTomTat)
        addSubview(lblNgayHoi)
        addSubview(lblNguoiHoi)
        
        addContraintByVSF(VSF: "H:|-20-[v0]-10-[v1]-20-|", views: lblNguoiHoi, lblNgayHoi)
        addContraintByVSF(VSF: "H:|-20-[v0]-20-|", views: lblCauHoi)
        addContraintByVSF(VSF: "H:|-20-[v0]-20-|", views: lblTomTat)
        addContraintByVSF(VSF: "V:|-10-[v0]-10-[v1]-10-[v2]-10-|", views: lblNguoiHoi, lblCauHoi, lblTomTat)
        addContraintByVSF(VSF: "V:|-10-[v0]-10-[v1]-10-[v2]-10-|", views: lblNgayHoi, lblCauHoi, lblTomTat)
    }
    override func setupData() {
        lblCauHoi.text = hoidap.cauhoi
        lblNguoiHoi.text = hoidap.ten
        lblNgayHoi.text = hoidap.created_at.getDurationTime()
        lblTomTat.text = hoidap.tomtat
    }
}
