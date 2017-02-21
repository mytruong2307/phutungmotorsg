//
//  FooterShopping.swift
//  PhuTungMotor
//
//  Created by admin on 2/19/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class FooterShopping: BaseCollReusableView {
    
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
    
    let btnShopping:MyButton = MyButton()
    
    var sum:Double = 0
    
    override func setupView() {
        btnShopping.setTitle(getTextUI(ui: UI.BTN_SHOPPING), for: UIControlState.normal)
        addSubview(btnShopping)
        addSubview(lblTong)
        addSubview(lblSum)
        
        btnShopping.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35).isActive = true
        lblTong.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35).isActive = true
        
        addContraintByVSF(VSF: "V:|[v0]|", views: btnShopping)
        addContraintByVSF(VSF: "V:|[v0]|", views: lblTong)
        addContraintByVSF(VSF: "V:|[v0]|", views: lblSum)
        addContraintByVSF(VSF: "H:|[v0][v1][v2]|", views: btnShopping, lblTong, lblSum)
    }
    
    override func setupData() {
        lblSum.text = showVNCurrency(gia: sum)
        btnShopping.addTarget(self, action: #selector(FooterShopping.dathang), for: UIControlEvents.touchUpInside)
    }
    
    func dathang() {
        showLog(mess: "Dat hang")
    }
}
