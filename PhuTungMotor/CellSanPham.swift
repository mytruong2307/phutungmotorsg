//
//  CellSanPham.swift
//  PhuTungMotor
//
//  Created by admin on 1/11/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class CellSanPham: BaseCollectCell {
    
    let imgHinh:UIImageView = {
        let v = UIImageView()
        v.image = #imageLiteral(resourceName: "logo")
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblTen:UILabel = {
        let v = UILabel()
        v.textAlignment = .center
        v.font = UIFont.systemFont(ofSize: 14)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblGia:UILabel = {
        let v = UILabel()
        v.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        v.font = UIFont.systemFont(ofSize: 14)
        v.textAlignment = .left
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblCode:UILabel = {
        let v = UILabel()
        v.textAlignment = .center
        v.font = UIFont.systemFont(ofSize: 10)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblGiaGoc:UILabel = {
        let v = UILabel()
        v.font = UIFont.systemFont(ofSize: 10)
        v.textAlignment = .right
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblTile:UILabel = {
        let v = UILabel()
        v.backgroundColor = Constants.MY_BG_COLOR
        v.textColor = Constants.MY_TEXT_COLOR
        v.font = UIFont.boldSystemFont(ofSize: 12)
        v.textAlignment = .center
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let vGia:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let act:UIActivityIndicatorView = {
        let v = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        v.activityIndicatorViewStyle = .whiteLarge
        v.color = Constants.MY_BG_COLOR
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var sanpham:SanPham = SanPham()
    var borderwidth:CGFloat = 0.3
    override func setupView() {
        addSubview(imgHinh)
        addSubview(lblCode)
        addSubview(lblTen)
        addSubview(lblTile)
        addSubview(vGia)
        
        addContraintByVSF(VSF: "H:|[v0]|", views: imgHinh)
        addContraintByVSF(VSF: "H:|[v0]|", views: lblTen)
        addContraintByVSF(VSF: "H:|[v0]|", views: lblCode)
        addContraintByVSF(VSF: "H:|[v0]|", views: vGia)
        addContraintByVSF(VSF: "V:|[v0][v1(20)][v2(30)][v3(30)]|", views: imgHinh, lblCode, lblTen, vGia)
        
        vGia.addSubview(lblGiaGoc)
        vGia.addSubview(lblGia)
        lblGiaGoc.widthAnchor.constraint(equalTo: vGia.widthAnchor, multiplier: 0.45).isActive = true
        vGia.addContraintByVSF(VSF: "H:|[v0]-10-[v1]|", views: lblGiaGoc, lblGia)
        vGia.addContraintByVSF(VSF: "V:|[v0(30)]|", views: lblGiaGoc)
        vGia.addContraintByVSF(VSF: "V:|[v0(30)]|", views: lblGia)
        
        imgHinh.addSubview(lblTile)
        imgHinh.addContraintByVSF(VSF: "H:[v0(30)]-5-|", views: lblTile)
        imgHinh.addContraintByVSF(VSF: "V:|-5-[v0(30)]", views: lblTile)
        
        imgHinh.addSubview(act)
        act.centerXAnchor.constraint(equalTo: imgHinh.centerXAnchor).isActive = true
        act.centerYAnchor.constraint(equalTo: imgHinh.centerYAnchor).isActive = true
        act.startAnimating()
    }
    
    override func setupData() {
        self.layer.borderWidth = borderwidth
        if sanpham.hinh.count > 0 {
            act.stopAnimating()
            imgHinh.image = sanpham.hinh[0]
        }
        lblTen.text = sanpham.ten
        lblGia.text = showVNCurrency(gia: sanpham.gia)
        lblCode.text = sanpham.code
        let tile:Double = sanpham.giamgia / (sanpham.gia + sanpham.giamgia) * 100
        lblTile.text = String(format:"%.0f", tile) + "%"
        lblTile.clipsToBounds = true
        lblTile.layer.cornerRadius = 15
        lblGiaGoc.attributedText = showPrice(sp: sanpham)
    }
    
}
