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
        v.setImage(#imageLiteral(resourceName: "right"), for: .normal)
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
        
        lblLoaiXe.leftAnchor.constraint(equalTo: vTemp.leftAnchor, constant: 15).isActive = true
        lblLoaiXe.centerYAnchor.constraint(equalTo: vTemp.centerYAnchor).isActive = true
        lblLoaiXe.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        btnViewMore.rightAnchor.constraint(equalTo: vTemp.rightAnchor, constant: -25).isActive = true
        btnViewMore.centerYAnchor.constraint(equalTo: vTemp.centerYAnchor).isActive = true
        btnViewMore.heightAnchor.constraint(equalToConstant: 24).isActive = true
        btnViewMore.widthAnchor.constraint(equalToConstant: 24).isActive = true

    }
    
    override func setupData() {
        lblLoaiXe.text = loaixe.ten
        btnViewMore.addTarget(self, action: #selector(HeaderSanPham.showProduct), for: UIControlEvents.touchUpInside)
    }

    func showProduct() {
        UIView.animate(withDuration: 0.5, animations: { 
            self.btnViewMore.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 80, 0, 0)
        }) { (true) in
            NotificationCenter.default.post(name: NSNotification.Name.init("viewMore"), object: self.loaixe)
            self.perform(#selector(HeaderSanPham.chuyenlai), with: self, afterDelay: 0.5)
        }
    }
    
    func chuyenlai()  {
        self.btnViewMore.layer.transform = CATransform3DIdentity
    }
    
}
