//
//  SuaDNController.swift
//  PhuTungMotor
//
//  Created by admin on 2/24/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class SuaDNController:MenuAdminController {
    
    let scroll:UIScrollView = {
        let v:UIScrollView = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblTitle:UILabel = {
        let v = UILabel()
        v.textColor = Constants.MY_TEXT_COLOR
        v.font = UIFont(name: "Hoefler Text", size: 21)
        v.textAlignment = .center
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let viewForScroll:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let uvBackground:UIView = {
        let v = UIView()
        v.backgroundColor = Constants.MY_BG_COLOR
        v.layer.cornerRadius = 10
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let uvForm:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    var bottom: NSLayoutConstraint!
    var top:NSLayoutConstraint!
    
    override func addHomeIcon() {
        //Huy menu
    }
    
    override func addMenuIcon() {
        //Bo nut them
    }
    override func addForm() {
        //ScrollView
        uvMain.addViewFullScreen(views: scroll)
        
        scroll.addViewFullScreen(views: viewForScroll)
        viewForScroll.widthAnchor.constraint(equalTo: uvMain.widthAnchor, multiplier: 1).isActive = true
        viewForScroll.heightAnchor.constraint(greaterThanOrEqualTo: uvMain.heightAnchor, multiplier: 1).isActive = true
        
        
        //Add 2 view de chen form vao
        viewForScroll.addSubview(uvBackground)
        viewForScroll.addSubview(uvForm)
        
        uvForm.centerXAnchor.constraint(equalTo: viewForScroll.centerXAnchor).isActive = true
        uvForm.widthAnchor.constraint(equalTo: viewForScroll.widthAnchor, multiplier: 0.85).isActive = true
        center = uvForm.centerYAnchor.constraint(equalTo: viewForScroll.centerYAnchor, constant: 0)
        center.isActive = true
        
        top = uvForm.topAnchor.constraint(equalTo: viewForScroll.topAnchor, constant: 20)
//        top.isActive = true
        
        
        uvBackground.leftAnchor.constraint(equalTo: uvForm.leftAnchor).isActive = true
        uvBackground.topAnchor.constraint(equalTo: uvForm.topAnchor).isActive = true
        uvBackground.widthAnchor.constraint(equalTo: uvForm.widthAnchor).isActive = true
        uvBackground.heightAnchor.constraint(equalTo: uvForm.heightAnchor).isActive = true
        
        
        //Danh sach ca view de autolayout code tay
        var arrView:Array<UIView> = []
        
        
        //Add title
        lblTitle.text = getTextUI(ui: UI.TTL_UPDATEINFO)
        arrView.append(lblTitle)
        
        var vertical = "V:|[v0(70)]"
        var i = 1
        
        //Add Ten
        let lblTen = MyLabel()
        lblTen.text = getTextUI(ui: UI.LBL_PRODUCTNAME)
        arrView.append(lblTen)
        
        txtTen = MyTextField()
        arrView.append(txtTen)
        vertical = "\(vertical)[v\(i)(21)]-4-[v\(i+1)(30)]-20-"
        i += 2
        
        //Add Điện thoại
        let lblPhone = MyLabel()
        lblPhone.text = getTextUI(ui: UI.LBL_PHONE)
        arrView.append(lblPhone)
        
        txtDienThoai = MyTextField()
        txtDienThoai.keyboardType = UIKeyboardType.numberPad
        arrView.append(txtDienThoai)
        
        vertical = "\(vertical)[v\(i)(21)]-4-[v\(i+1)(30)]-20-"
        i += 2
        
        //Add Email
        let lblEmail = MyLabel()
        lblEmail.text = getTextUI(ui: UI.LBL_EMAIL)
        arrView.append(lblEmail)
        
        txtEmail = MyTextField()
        txtEmail.keyboardType = UIKeyboardType.emailAddress
        arrView.append(txtEmail)
        
        vertical = "\(vertical)[v\(i)(21)]-4-[v\(i+1)(30)]-20-"
        i += 2
        
        //Add Dia chi
        let lblDiaChi = MyLabel()
        lblDiaChi.text = getTextUI(ui: UI.LBL_DIACHI)
        arrView.append(lblDiaChi)
        
        txtDiaChi = UITextView()
        txtDiaChi.font = UIFont.systemFont(ofSize: 15)
        txtDiaChi.clipsToBounds = true
        txtDiaChi.layer.cornerRadius = 5
        txtDiaChi.isEditable = true
        arrView.append(txtDiaChi)
        
        vertical = "\(vertical)[v\(i)(21)]-4-[v\(i+1)(60)]-20-"
        i += 2
        
        //Add Dia chi
        let lblWeb = MyLabel()
        lblWeb.text = getTextUI(ui: UI.LBL_WEB)
        arrView.append(lblWeb)
        
        txtWeb = MyTextField()
        arrView.append(txtWeb)
        
        vertical = "\(vertical)[v\(i)(21)]-4-[v\(i+1)(30)]-20-"
        i += 2
        
        //Add button
        let btnUpdate:MyButton = MyButton()
        btnUpdate.setTitle(getTextUI(ui: UI.BTN_UPDATE), for: UIControlState.normal)
        arrView.append(btnUpdate)
        
        vertical = "\(vertical)[v\(i)(30)]-20-|"
        
        for view in arrView {
            uvForm.addSubview(view)
            uvForm.addContraintByVSF(VSF: "H:|-20-[v0]-20-|", views: view)
        }
        uvForm.addContraintByVSF(VSF: vertical, views: arrView)
        
        btnUpdate.addTarget(self, action: #selector(SuaDNController.updateThongTinDN), for: .touchUpInside)
    }

    
    var txtTen, txtDienThoai, txtEmail, txtWeb:MyTextField!
    var txtDiaChi:UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(SuaDNController.show(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SuaDNController.hide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        setupDataForm()
    }
    
    func setupDataForm() {
        paramAdmin["truycap"] = "5"
        sendRequestAdmin(linkAPI: API.THONGTIN) { (data) in
            let thongtin = data?[getResultAPI(link: API.DATA_RETURN)] as! Dictionary<String,Any>
            self.txtTen.text = thongtin["ten"] as! String?
            self.txtWeb.text = thongtin["web"] as! String?
            self.txtEmail.text = thongtin["email"] as! String?
            self.txtDiaChi.text = thongtin["diachi"] as! String?
            self.txtDienThoai.text = thongtin["sodienthoai"] as! String?
        }
    }
    
    func show(_ notification:NSNotification)
    {
        let valueKeyboard:NSValue = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        let sizeKeyboard:CGRect = valueKeyboard.cgRectValue
        center.isActive = false
        top.isActive = true
        bottom = uvForm.bottomAnchor.constraint(equalTo: viewForScroll.bottomAnchor, constant: sizeKeyboard.height * (-1))
        bottom.isActive = true
    }
    
    func hide(_ notification:NSNotification)
    {
        if bottom != nil {
            bottom.isActive = false
            
        }
        top.isActive = false
        center.isActive = true
        UIView.animate(withDuration: 1) {
            self.view.layoutSubviews()
        }
    }
    
    func updateThongTinDN() {
        var param = paramAdmin
        param["ten"] = txtTen.text
        param["diachi"] = txtDiaChi.text
        param["sodienthoai"] = txtDienThoai.text
        param["email"] = txtEmail.text
        param["web"] = txtWeb.text
        param["newToken"] = "1"
        sendRequestAdmin(linkAPI: API.SUATHONGTIN, param: param, method: Method.post, extraLink: nil) { (data) in
            self.showAlertActionOK(title: getAlertMessage(msg: ALERT.NOTICE), mess: getAlertMessage(msg: ALERT.UPDATEOK), complete: {
                self.popToAdminController()
            })
        }
    }
    
}
