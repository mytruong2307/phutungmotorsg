//
//  CellPermission.swift
//  PhuTungMotor
//
//  Created by admin on 2/23/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class CellPermission: BaseCollectCell {
    
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
    
    let imgRight:UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.image = #imageLiteral(resourceName: "right")
        return v
    }()
    
    let lblSoluong:UILabel = {
        let v = UILabel()
        v.font = UIFont.boldSystemFont(ofSize: 15)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let vSoluong:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var per:Permission = Permission()
    
    override func setupView() {
        addSubview(imgIcon)
        addSubview(lblPer)
        addSubview(vSoluong)
        
        
        addContraintByVSF(VSF: "V:|-13-[v0(24)]", views: imgIcon)
        addContraintByVSF(VSF: "V:|[v0]|", views: lblPer)
        addContraintByVSF(VSF: "V:|-13-[v0]", views: vSoluong)
        
        addContraintByVSF(VSF: "H:|-20-[v0(24)]-20-[v1][v2]-20-|", views: imgIcon, lblPer, vSoluong)
        
        vSoluong.addSubview(lblSoluong)
        vSoluong.addSubview(imgRight)
        
        vSoluong.addContraintByVSF(VSF: "V:|[v0]|", views: lblSoluong)
        vSoluong.addContraintByVSF(VSF: "V:|[v0(24)]|", views: imgRight)
        vSoluong.addContraintByVSF(VSF: "H:|[v0]-10-[v1(24)]|", views: lblSoluong, imgRight)
    }
    
    override func setupData() {
        showLog(mess: "Gan data cho cell \(per.ten) - \(per.soluong)")
        lblPer.text = per.ten
        imgIcon.image = per.imgIcon
        if per.soluong > 10000 {
            lblSoluong.text = showVNCurrency(gia: per.soluong)
            lblSoluong.textColor = Constants.MY_BG_COLOR
            lblSoluong.textAlignment = .right
        } else if per.soluong > 0 {
            lblSoluong.textAlignment = .center
            lblSoluong.layer.cornerRadius = 12
            lblSoluong.textColor = Constants.MY_TEXT_COLOR
            lblSoluong.backgroundColor = Constants.MY_BG_COLOR
            lblSoluong.clipsToBounds = true
            lblSoluong.text = String(Int (per.soluong))
            lblSoluong.widthAnchor.constraint(equalToConstant: 24).isActive = true
            lblSoluong.heightAnchor.constraint(equalToConstant: 24).isActive = true
        }
        

    }
}
