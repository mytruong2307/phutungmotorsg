//
//  ChangePassController.swift
//  PhuTungMotor
//
//  Created by admin on 1/2/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class ChangePassController: BaseController {
    
    var txtEmail, txtMatKhauCu, txtMatKhau, txtReMatKhau:MyTextField!
    let lblTitle:UILabel = {
        let v = UILabel()
        v.textColor = Constants.MY_TEXT_COLOR
        v.font = UIFont(name: "Hoefler Text", size: 27)
        v.textAlignment = .center
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let btnChangePass:MyButton = {
        let v = MyButton()
        return v
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFormChangePass()
        
    }
    
    override func addHomeIcon() {
        //Huy home menu
    }
    
    func setupFormChangePass() {
        //Danh sach ca view de autolayout code tay
        var arrView:Array<UIView> = []
        var vertical = "V:|[v0(70)]"
        var i = 1
        //Add title
        lblTitle.text = getTextUI(ui: UI.FRM_CHANGEPASS)
        arrView.append(lblTitle)
        
        //Add Email
        let lblEmail = MyLabel()
        lblEmail.text = getTextUI(ui: UI.LBL_EMAIL)
        arrView.append(lblEmail)
        txtEmail = MyTextField()
        txtEmail.keyboardType = UIKeyboardType.emailAddress
        arrView.append(txtEmail)
        vertical = "\(vertical)[v\(i)(21)]-4-[v\(i+1)(30)]-20-"
        i += 2
        //Add Mat khau
        let lblOldPass = MyLabel()
        lblOldPass.text = getTextUI(ui: UI.LBL_OLDPASS)
        arrView.append(lblOldPass)
        txtMatKhauCu = MyTextField()
        txtMatKhauCu.isSecureTextEntry = true
        arrView.append(txtMatKhauCu)
        vertical = "\(vertical)[v\(i)(21)]-4-[v\(i+1)(30)]-20-"
        i += 2
        
        //Add Mat khau
        let lblPass = MyLabel()
        lblPass.text = getTextUI(ui: UI.LBL_NEWPASS)
        arrView.append(lblPass)
        txtMatKhau = MyTextField()
        txtMatKhau.isSecureTextEntry = true
        arrView.append(txtMatKhau)
        vertical = "\(vertical)[v\(i)(21)]-4-[v\(i+1)(30)]-20-"
        i += 2
        
        //Add Re Mat khau
        let lblRePass = MyLabel()
        lblRePass.text = getTextUI(ui: UI.LBL_RENEWPASS)
        arrView.append(lblRePass)
        txtReMatKhau = MyTextField()
        txtReMatKhau.isSecureTextEntry = true
        arrView.append(txtReMatKhau)
        vertical = "\(vertical)[v\(i)(21)]-4-[v\(i+1)(30)]-20-"
        i += 2
        
        //Add button
        arrView.append(btnChangePass)
        btnChangePass.setTitle(getTextUI(ui: UI.FRM_CHANGEPASS), for: UIControlState.normal)
        vertical = "\(vertical)[v\(i)(30)]-20-|"
        
        for view in arrView {
            uvFormBase.addSubview(view)
            uvFormBase.addContraintByVSF(VSF: "H:|-20-[v0]-20-|", views: view)
        }
        uvFormBase.addContraintByVSF(VSF: vertical, views: arrView)
        
        btnChangePass.addTarget(self, action: #selector(ChangePassController.changePass), for: UIControlEvents.touchUpInside)
    }
    
    func changePass()  {
        let check = isEmptyTextField(txt: txtEmail, txtMatKhau)
        if check == "OK" {
            if isValidEmail(candidate: txtEmail.text!) {
                if isValidPassword(candidate: txtMatKhau.text!) {
                    if txtMatKhau.text == txtReMatKhau.text {
                        let param = ["email":txtEmail.text!,"oldpass":txtMatKhauCu.text!,"newpass":txtMatKhau.text!]
                        sendRequestToServer(linkAPI: API.CHANGEPASS, param: param, method: .post, extraLink: nil, completion: { (data) in
                            if data?[getResultAPI(link: API.DATA_RES)] as! String != getResultAPI(link: API.RES_OK) {
                                self.showAlert(title: getAlertMessage(msg: ALERT.ERROR), mess: data?[getResultAPI(link: API.DATA_ERR)] as! String)
                            } else {
                                self.showAlertActionOK(title: getAlertMessage(msg: ALERT.NOTICE), mess: getAlertMessage(msg: ALERT.CHANGEPASSOK), complete: {
                                    showLog(mess: kh!)
                                    _ = self.navigationController?.popToRootViewController(animated: true)
                                })
                            }
                        })
                    } else {
                        self.showAlert(title: getAlertMessage(msg: ALERT.ERROR), mess: getAlertMessage(msg: ALERT.NEWPASSNOTMATCH))
                    }
                } else {
                    self.showAlert(title: getAlertMessage(msg: ALERT.ERROR), mess: getAlertMessage(msg: ALERT.INVALIDNEWPASS))
                }
            } else {
                self.showAlert(title: getAlertMessage(msg: ALERT.ERROR), mess: getAlertMessage(msg: ALERT.INVALIDEMAIL))
            }
        } else {
            self.showAlert(title: getAlertMessage(msg: ALERT.ERROR), mess: check)
        }
    }
}
