//
//  CellPhanQuyen.swift
//  PhuTungMotor
//
//  Created by admin on 2/24/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class CellPhanQuyen: BaseCollectCell {
    
    let imgIcon:UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblPer:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblDoanhThu:UILabel = {
        let v = UILabel()
        v.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    
    let imgRight:UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.image = #imageLiteral(resourceName: "right")
        return v
    }()
    
    
    var per:Permission = Permission()
    
    override func setupView() {
        addSubview(imgIcon)
        addSubview(lblPer)
        addSubview(lblDoanhThu)
        addSubview(imgRight)
        
        
        addContraintByVSF(VSF: "V:|-13-[v0(24)]", views: imgIcon)
        addContraintByVSF(VSF: "V:|[v0]|", views: lblPer)
        addContraintByVSF(VSF: "V:|[v0]|", views: lblDoanhThu)
        addContraintByVSF(VSF: "V:|-13-[v0(24)]", views: imgRight)
        
        addContraintByVSF(VSF: "H:|-20-[v0(24)]-20-[v1][v2]-10-[v3(24)]-20-|", views: imgIcon, lblPer, lblDoanhThu, imgRight)

    }
    
    override func setupData() {
        imgIcon.image = per.imgIcon
        lblPer.text = per.ten
        if per.soluong > 0 {
            lblDoanhThu.text = showVNCurrency(gia: per.soluong)
        }
    }
}
