//
//  HeaderSanPham.swift
//  PhuTungMotor
//
//  Created by admin on 1/19/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class HeaderSanPham: BaseCollReusableView {
    
    let lblLoaiXe:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textAlignment = .center
        return v
    }()
    
    let btnViewMore:UIButton = {
        let v = UIButton()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setTitle(getTextUI(ui: UI.BTN_SHOWMORE), for: UIControlState.normal)
        v.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: UIControlState.normal)
        v.setTitleColor(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), for: UIControlState.highlighted)
        v.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return v
    }()
    
    let vTemp:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var loaixe:LoaiXe = LoaiXe()

    
    override func setupView() {
        addViewFullScreen(views: vTemp)
        vTemp.addSubview(lblLoaiXe)
        vTemp.addSubview(btnViewMore)
        
        lblLoaiXe.leftAnchor.constraint(equalTo: vTemp.leftAnchor, constant: 5).isActive = true
        lblLoaiXe.centerYAnchor.constraint(equalTo: vTemp.centerYAnchor).isActive = true
        lblLoaiXe.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        btnViewMore.rightAnchor.constraint(equalTo: vTemp.rightAnchor, constant: -5).isActive = true
        btnViewMore.centerYAnchor.constraint(equalTo: vTemp.centerYAnchor).isActive = true
        btnViewMore.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnViewMore.widthAnchor.constraint(equalTo: vTemp.widthAnchor, multiplier: 0.3).isActive = true

    }
    
    override func setupData() {
        lblLoaiXe.text = loaixe.ten
        btnViewMore.setTitle(getTextUI(ui: UI.BTN_SHOWMORE), for: UIControlState.normal)
        btnViewMore.addTarget(self, action: #selector(HeaderSanPham.showProduct), for: UIControlEvents.touchUpInside)
    }

    func showProduct() {
        NotificationCenter.default.post(name: NSNotification.Name.init("viewMore"), object: loaixe)
    }
}
