//
//  CellHangXe.swift
//  PhuTungMotor
//
//  Created by admin on 3/8/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class CellHangXe: BaseCollectCell {
    
    let lblHangXe:UILabel = {
        let v = UILabel()
        v.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        v.font = UIFont.boldSystemFont(ofSize: 21)
        v.textAlignment = .center
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let imgBanner:UIImageView = {
        let v = UIImageView()
        v.image = #imageLiteral(resourceName: "logo")
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    
    var hx:HangXe = HangXe()
    
    override func setupView() {
        addSubview(views: imgBanner, lblHangXe)
        imgBanner.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        addContraintByVSF(VSF: "H:|[v0]|", views: imgBanner)
        addContraintByVSF(VSF: "H:|[v0]|", views: lblHangXe)
        addContraintByVSF(VSF: "V:|[v0][v1]|", views: imgBanner, lblHangXe)
    }
    
    override func setupData() {
        lblHangXe.text = hx.ten
        let link = getLinkImage(link: API.HANGXE) + "/" + hx.hinh
        imgBanner.loadImageFromInternet(link: link)
    }
}
