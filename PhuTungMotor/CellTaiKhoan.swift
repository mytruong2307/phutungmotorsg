//
//  CellTaiKhoan.swift
//  PhuTungMotor
//
//  Created by admin on 3/4/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class CellTaiKhoan: BaseCollectCell {
    
    let vBackGround:UIView = {
        let v = UIView()
        v.clipsToBounds = true
        v.layer.cornerRadius = 5
        v.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let vTen:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let imgAvartar:UIImageView = {
        let v = UIImageView()
        v.clipsToBounds = true
        v.layer.cornerRadius = 25
        v.translatesAutoresizingMaskIntoConstraints = false
        v.image = #imageLiteral(resourceName: "avartar")
        return v
    }()
    
    
    let lblDTen:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = true
        v.textColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        return v
    }()
    
    let swActive:UISwitch = {
        let v = UISwitch()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblDEmail:UILabel = {
        let v = UILabel()
        v.textColor = Constants.MY_BG_COLOR
        v.font = UIFont.systemFont(ofSize: 14)
        v.translatesAutoresizingMaskIntoConstraints = true
        return v
    }()
    
    let lblPer:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = true
        v.text = getTextUI(ui: UI.LBL_PER)
        v.font = UIFont.systemFont(ofSize: 14)
        return v
    }()
    
    let lblDPer:UILabel = {
        let v = UILabel()
        v.numberOfLines = 0
        v.font = UIFont.systemFont(ofSize: 14)
        v.translatesAutoresizingMaskIntoConstraints = true
        return v
    }()
    
    let vPhone:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblPhone:UILabel = {
        let v = UILabel()
        v.font = UIFont.systemFont(ofSize: 14)
        v.translatesAutoresizingMaskIntoConstraints = true
        v.text = getTextUI(ui: UI.LBL_PHONE)
        return v
    }()
    
    let lblDPhone:UILabel = {
        let v = UILabel()
        v.font = UIFont.systemFont(ofSize: 14)
        v.translatesAutoresizingMaskIntoConstraints = true
        return v
    }()
    
    let lblGender:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = true
        v.text = getTextUI(ui: UI.LBL_GENDER)
        v.font = UIFont.systemFont(ofSize: 14)
        return v
    }()
    
    let lblDGender:UILabel = {
        let v = UILabel()
        v.textAlignment = .right
        v.font = UIFont.systemFont(ofSize: 14)
        v.translatesAutoresizingMaskIntoConstraints = true
        return v
    }()
    
    
    let vSwitch:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    
    let lblBikeType:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = true
        v.text = getTextUI(ui: UI.LBL_BIKETYPE)
        v.font = UIFont.systemFont(ofSize: 14)
        return v
    }()
    
    let lblDBikeType:UILabel = {
        let v = UILabel()
        v.textAlignment = .right
        v.font = UIFont.systemFont(ofSize: 14)
        v.translatesAutoresizingMaskIntoConstraints = true
        return v
    }()
    
    let lblAddress:UILabel = {
        let v = UILabel()
        v.font = UIFont.systemFont(ofSize: 14)
        v.translatesAutoresizingMaskIntoConstraints = true
        v.text = getTextUI(ui: UI.LBL_DIACHI)
        return v
    }()
    
    let lblDAddress:UILabel = {
        let v = UILabel()
        v.numberOfLines = 0
        v.font = UIFont.systemFont(ofSize: 14)
        v.translatesAutoresizingMaskIntoConstraints = true
        return v
    }()
    let vActive:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let vCreated:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    
    let lblLogin:UILabel = {
        let v = UILabel()
        v.font = UIFont.systemFont(ofSize: 14)
        v.translatesAutoresizingMaskIntoConstraints = true
        v.text = getTextUI(ui: UI.LBL_LOGIN)
        return v
    }()
    
    let lblDLogin:UILabel = {
        let v = UILabel()
        v.font = UIFont.systemFont(ofSize: 14)
        v.translatesAutoresizingMaskIntoConstraints = true
        return v
    }()
    
    let lblCreatedAt:UILabel = {
        let v = UILabel()
        v.font = UIFont.systemFont(ofSize: 14)
        v.translatesAutoresizingMaskIntoConstraints = true
        v.text = getTextUI(ui: UI.LBL_CREATED)
        return v
    }()
    
    let lblDCreatedAt:UILabel = {
        let v = UILabel()
        v.font = UIFont.systemFont(ofSize: 14)
        v.translatesAutoresizingMaskIntoConstraints = true
        return v
    }()
    
    var nv:NhanVien = NhanVien()
    
    override func setupView() {
        let viewHSL = "H:|-10-[v0]-10-|"
        let labelHSL:String = "H:|-10-[v0(75)][v1]-10-|"
        let VSL:String = "V:|[v0(70)]-5-[v1]-5-[v2]-5-[v3]-5-[v4]-5-[v5]-10-|"
        
        addSubview(views: vBackGround)
        addContraintByVSF(VSF: "H:|-10-[v0]-10-|", views: vBackGround)
        addContraintByVSF(VSF: "V:|[v0]|", views: vBackGround)

        
        vBackGround.addSubview(views: vTen, vPhone, vCreated, vSwitch, lblAddress, lblDAddress, lblPer, lblDPer)
        
        lblAddress.topAnchor.constraint(equalTo: lblPer.bottomAnchor).isActive = true
        lblPer.topAnchor.constraint(equalTo: vCreated.bottomAnchor).isActive = true
        
        vBackGround.addContraintByVSF(VSF: "H:|-30-[v0]|", views: vTen)
        vBackGround.addContraintByVSF(VSF: viewHSL, views: vPhone)
        vBackGround.addContraintByVSF(VSF: viewHSL, views: vCreated)
        vBackGround.addContraintByVSF(VSF: viewHSL, views: vSwitch)
        vBackGround.addContraintByVSF(VSF: labelHSL, views: lblPer, lblDPer)
        vBackGround.addContraintByVSF(VSF: labelHSL, views: lblAddress, lblDAddress)
        
        vBackGround.addContraintByVSF(VSF: VSL, views: vTen, vPhone, vCreated, lblPer, lblAddress, vSwitch)
        vBackGround.addContraintByVSF(VSF: VSL, views: vTen, vPhone, vCreated, lblDPer, lblDAddress, vSwitch)
        
        vTen.addSubview(views: imgAvartar, vActive, lblDEmail)
        vTen.addContraintByVSF(VSF: "H:|[v0(50)]-10-[v1]|", views: imgAvartar, vActive)
        vTen.addContraintByVSF(VSF: "H:|[v0(50)]-10-[v1]|", views: imgAvartar, lblDEmail)
        vTen.addContraintByVSF(VSF: "V:|-10-[v0]-10-|", views: imgAvartar)
        vTen.addContraintByVSF(VSF: "V:|-10-[v0][v1]-5-|", views: vActive,lblDEmail)
        
        vActive.addSubview(views: lblDTen, swActive)
        swActive.rightAnchor.constraint(equalTo: vActive.rightAnchor).isActive = true
        vActive.addContraintByVSF(VSF: "H:|[v0][v1(51)]-10-|", views: lblDTen, swActive)
        vActive.addContraintByVSF(VSF: "V:|[v0]|", views: lblDTen)
        vActive.addContraintByVSF(VSF: "V:|[v0]|", views: swActive)
        
        vPhone.addSubview(views: lblPhone, lblDPhone, lblGender, lblDGender)
        vPhone.addContraintByVSF(VSF: "V:|[v0]|", views: lblPhone)
        vPhone.addContraintByVSF(VSF: "V:|[v0]|", views: lblDPhone)
        vPhone.addContraintByVSF(VSF: "V:|[v0]|", views: lblGender)
        vPhone.addContraintByVSF(VSF: "V:|[v0]|", views: lblDGender)
        vPhone.addContraintByVSF(VSF: "H:|[v0(75)][v1(95)][v2(95)][v3]|", views: lblPhone, lblDPhone, lblGender, lblDGender)
        
        vCreated.addSubview(views: lblCreatedAt, lblDCreatedAt, lblBikeType, lblDBikeType)
        vCreated.addContraintByVSF(VSF: "V:|[v0]|", views: lblCreatedAt)
        vCreated.addContraintByVSF(VSF: "V:|[v0]|", views: lblDCreatedAt)
        vCreated.addContraintByVSF(VSF: "V:|[v0]|", views: lblBikeType)
        vCreated.addContraintByVSF(VSF: "V:|[v0]|", views: lblDBikeType)
        vCreated.addContraintByVSF(VSF: "H:|[v0(75)][v1(95)][v2(95)][v3]|", views: lblCreatedAt, lblDCreatedAt,  lblBikeType, lblDBikeType)
        
        vSwitch.addSubview(views: lblLogin, lblDLogin)
        vSwitch.addContraintByVSF(VSF: "V:|[v0]|", views: lblLogin)
        vSwitch.addContraintByVSF(VSF: "V:|[v0]|", views: lblDLogin)
        vSwitch.addContraintByVSF(VSF: "H:|[v0(75)][v1]|", views: lblLogin, lblDLogin)
        
    }
    
    override func setupData() {
        lblDTen.text = nv.ten
        lblDEmail.text = nv.email
        lblDPhone.text = nv.dienthoai
        lblDAddress.text = nv.sonha + ", " + nv.phuong + ", " + nv.quan + ", " + nv.tinh
        lblDGender.text = nv.gioitinh
        lblDBikeType.text = nv.xedangdung
        lblDCreatedAt.text = nv.createdAt
        if nv.lanlogin > -1 {
            lblDLogin.text = String (nv.lanlogin)
            // Switch active
            if nv.tinhtrang == 0 {
                swActive.isOn = false
            } else {
                swActive.isOn = true
            }
            swActive.addTarget(self, action: #selector(CellTaiKhoan.active(_:)), for: UIControlEvents.valueChanged)
            //Quyen
            switch nv.quyen {
            case "1":
                lblDPer.text = "Admin"
                break
            case "10":
                lblDPer.text = "Super Admin"
                break
            default:
                var quyen = nv.quyen
                quyen = quyen.replacingOccurrences(of: "2", with: "Tài Khoản")
                quyen = quyen.replacingOccurrences(of: "3", with: "Hỏi Đáp")
                quyen = quyen.replacingOccurrences(of: "4", with: "Tin Tức")
                quyen = quyen.replacingOccurrences(of: "5", with: "Doanh Nghiệp")
                quyen = quyen.replacingOccurrences(of: "6", with: "Hãng Xe")
                quyen = quyen.replacingOccurrences(of: "7", with: "Loại Xe")
                quyen = quyen.replacingOccurrences(of: "9", with: "Đơn Hàng")
                quyen = quyen.replacingOccurrences(of: "s", with: "Slider")
                quyen = quyen.replacingOccurrences(of: "m", with: "Gửi Mail")
                quyen = quyen.replacingOccurrences(of: "8", with: "Sản Phẩm")
                quyen = quyen.replacingOccurrences(of: ",", with: ", ")
                lblDPer.text = quyen
            }
        } else {
            if nv.maxacnhan != "" {
                swActive.isOn = true
            } else {
                swActive.isOn = false
            }
            swActive.isEnabled = false
            lblPer.removeFromSuperview()
            lblDPer.removeFromSuperview()
            lblLogin.removeFromSuperview()
            lblDLogin.removeFromSuperview()
            layoutIfNeeded()
        }
    }
    
    func active(_ sender:UISwitch)  {
        if sender.isOn {
            nv.tinhtrang = 1
        } else {
            nv.tinhtrang = 0
        }
        NotificationCenter.default.post(name: NSNotification.Name.init("activeAccount"), object: nv)
    }
}
