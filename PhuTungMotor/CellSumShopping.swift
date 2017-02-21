//
//  CellSumShopping.swift
//  PhuTungMotor
//
//  Created by admin on 2/19/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class CellSumShopping: BaseCollectCell {
    
    let lblTong:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = getTextUI(ui: UI.LBL_SUM)
        v.font = UIFont.boldSystemFont(ofSize: 17)
        v.textAlignment = .right
        return v
    }()
    
    let lblSum:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont.boldSystemFont(ofSize: 17)
        v.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        v.textAlignment = .right
        return v
    }()
    
    let vTemp:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    var gh:GioHang = GioHang()
    
    override func setupView() {
        
        addSubview(vTemp)
        addSubview(lblTong)
        addSubview(lblSum)
        vTemp.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3).isActive = true
        lblTong.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true
        addContraintByVSF(VSF: "V:|-5-[v0(40)]-5-|", views: vTemp)
        addContraintByVSF(VSF: "V:|[v0]|", views: lblTong)
        addContraintByVSF(VSF: "V:|[v0]|", views: lblSum)
        addContraintByVSF(VSF: "H:|-30-[v0][v1]-10-[v2]|", views: vTemp, lblTong, lblSum)
    }
    
    override func setupData() {
        lblSum.text = showVNCurrency(gia: gh.sanpham.gia)
    }

}
