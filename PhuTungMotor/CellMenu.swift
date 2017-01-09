//
//  CellMenu.swift
//  PhuTungMotor
//
//  Created by admin on 1/1/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class CellMenu: BaseTableCell {
    
    var hinh:UIImage = UIImage()
    var ten:String = ""
    
    let imgIcon:UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lblTen:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        return lbl
    }()
    
    override func setupView() {
        super.setupView()
        addSubview(imgIcon)
        addSubview(lblTen)
        
        imgIcon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblTen.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addContraintByVSF(VSF: "V:|-5-[v0(24)]", views: imgIcon)
        addContraintByVSF(VSF: "V:|-5-[v0]", views: lblTen)
        addContraintByVSF(VSF: "H:|-10-[v0(24)]-10-[v1]-10-|", views: imgIcon, lblTen)
        
    }
    
    override func setupData() {
        lblTen.text = ten
        imgIcon.image = hinh
    }
}
