//
//  CellShopping.swift
//  PhuTungMotor
//
//  Created by admin on 2/18/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class CellShopping: BaseCollectCell {
    
    var gh:GioHang = GioHang()
    
    let imgHinh:UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let vInfo:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let lblName:UILabel = {
        let v = UILabel()
        v.numberOfLines = 2
        v.font = UIFont.systemFont(ofSize: 17)
        v.textColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let lblCode:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont.systemFont(ofSize: 12)
        return v
    }()
    let lblPrice:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont.systemFont(ofSize: 12)
        v.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        v.textAlignment = .left
        return v
    }()
    let txtSoLuong:MyTextField = MyTextField()
    
    let vSoluong:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let btnChinh:MyButton = MyButton()
    
    let lblThanhTien:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont.boldSystemFont(ofSize: 17)
        v.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        v.textAlignment = .right
        return v
    }()
    
    
    override func setupView() {
        addSubview(imgHinh)
        addSubview(vInfo)
        addSubview(vSoluong)
        addSubview(lblThanhTien)
        
        addContraintByVSF(VSF: "V:|[v0]|", views: imgHinh)
        addContraintByVSF(VSF: "V:|[v0]|", views: vInfo)
        addContraintByVSF(VSF: "V:|[v0]|", views: vSoluong)
        addContraintByVSF(VSF: "V:|[v0]|", views: lblThanhTien)
        
        addContraintByVSF(VSF: "H:|[v0(50)]-5-[v1(150)][v2(60)][v3]|", views: imgHinh,vInfo, vSoluong,lblThanhTien)
        
        vInfo.addSubview(lblName)
        vInfo.addSubview(lblCode)
        vInfo.addSubview(lblPrice)
        
        lblPrice.bottomAnchor.constraint(equalTo: vInfo.bottomAnchor, constant: 0).isActive = true
        vInfo.addContraintByVSF(VSF: "H:|[v0]|", views: lblName)
        vInfo.addContraintByVSF(VSF: "H:|[v0]|", views: lblCode)
        vInfo.addContraintByVSF(VSF: "H:|[v0]|", views: lblPrice)
        vInfo.addContraintByVSF(VSF: "V:|[v0][v1][v2]", views: lblName, lblCode, lblPrice)
        
        vSoluong.addSubview(txtSoLuong)
        vSoluong.addSubview(btnChinh)
        vSoluong.addContraintByVSF(VSF: "H:|[v0]|", views: txtSoLuong)
        vSoluong.addContraintByVSF(VSF: "H:|[v0]|", views: btnChinh)
        vSoluong.addContraintByVSF(VSF: "V:|[v0]-5-[v1]", views: txtSoLuong, btnChinh)
        
    }
    override func setupData() {
        imgHinh.image = gh.sanpham.hinh[0]
        lblName.text = gh.sanpham.ten
        lblCode.text = gh.sanpham.code
//        lblCode.text = ""
        lblPrice.text = showVNCurrency(gia: gh.sanpham.gia)
        txtSoLuong.text = String (gh.soluong)
        if #available(iOS 10.0, *) {
            txtSoLuong.textContentType = UITextContentType.telephoneNumber
        }
        txtSoLuong.textAlignment = .center
        btnChinh.setTitle(getTextUI(ui: UI.BTN_UPDATENO), for: UIControlState.normal)
        btnChinh.addTarget(self, action: #selector(CellShopping.chinhGioHang), for: UIControlEvents.touchUpInside)
        let thanhtien = gh.sanpham.gia * Double (gh.soluong)
        lblThanhTien.text = showVNCurrency(gia: thanhtien)
    }
    
    func chinhGioHang()  {
        if let soluong = Int (txtSoLuong.text!) {
            gh.soluong = soluong
        } else {
            gh.soluong = 0
        }
        NotificationCenter.default.post(name: NSNotification.Name.init("updateShopping"), object: gh)
    }
}
