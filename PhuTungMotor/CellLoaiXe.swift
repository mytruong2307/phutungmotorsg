//
//  CellLoaiXe.swift
//  PhuTungMotor
//
//  Created by admin on 1/11/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class CellLoaiXe: BaseCollectCell {
    let lblTen:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont.systemFont(ofSize: 17)
        v.backgroundColor = Constants.MY_BG_COLOR
        v.textColor = Constants.MY_TEXT_COLOR
        v.textAlignment = .center
        return v
    }()
    
    var loaixe:LoaiXe = LoaiXe()
    
    override func setupView() {
        addViewFullScreen(views: lblTen)
        
    }
    override func setupData() {
        lblTen.text = loaixe.ten
    }
}
