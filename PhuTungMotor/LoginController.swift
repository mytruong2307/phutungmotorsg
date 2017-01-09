//
//  LoginController.swift
//  PhuTungMotorSG
//
//  Created by admin on 12/22/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class LoginController: BaseController {
    
    var txtEmail, txtMatKhau:MyTextField!
    var remember = true
    let lblTitle:UILabel = {
        let v = UILabel()
        v.textColor = Constants.MY_TEXT_COLOR
        v.font = UIFont(name: "Hoefler Text", size: 36)
        v.textAlignment = .center
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let btnRegister:MyButton = {
        let v = MyButton()
        return v
    }()
    let btnLogin:MyButton = {
        let v = MyButton()
        return v
    }()
    let btnForgot:MyButton = {
        let v = MyButton()
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFormLogin()

    }
    
    override func addHomeIcon() {
        //Huy home menu
    }

    func setupFormLogin() {
        //Danh sach ca view de autolayout code tay
        var arrView:Array<UIView> = []
        //Add title
        lblTitle.text = getTextUI(ui: UI.FRM_LOGIN)
        arrView.append(lblTitle)
        
        //Add Email
        let lblEmail = MyLabel()
        lblEmail.text = getTextUI(ui: UI.LBL_EMAIL)
        arrView.append(lblEmail)
        txtEmail = MyTextField()
        txtEmail.keyboardType = UIKeyboardType.emailAddress
        arrView.append(txtEmail)
        
        
        //Add Mat khau
        let lblPass = MyLabel()
        lblPass.text = getTextUI(ui: UI.LBL_PASS)
        arrView.append(lblPass)
        txtMatKhau = MyTextField()
        txtMatKhau.isSecureTextEntry = true
        arrView.append(txtMatKhau)
        
        //Add view ghi nho dang nhap
        let uiView = UIView()
        arrView.append(uiView)
        let lblRem = MyLabel()
        lblRem.text = getTextUI(ui: UI.LBL_REMEMBER)
        let sw = UISwitch()
        sw.isOn = true
        uiView.addSubview(lblRem)
        uiView.addSubview(sw)
        uiView.addContraintByVSF(VSF: "H:|[v0][v1]|", views: lblRem, sw)
        uiView.addContraintByVSF(VSF: "V:|[v0(21)]", views: lblRem)
        uiView.addContraintByVSF(VSF: "V:|[v0(30)]", views: sw)
        
        //Add button
        btnLogin.setTitle(getTextUI(ui: UI.FRM_LOGIN), for: UIControlState.normal)
        arrView.append(btnLogin)
        btnForgot.setTitle(getTextUI(ui: UI.TTL_FORGOTPASS), for: UIControlState.normal)
        arrView.append(btnForgot)
        btnRegister.setTitle(getTextUI(ui: UI.FRM_REGISTER), for: UIControlState.normal)
        arrView.append(btnRegister)
        
        sw.addTarget(self, action: #selector(LoginController.ghiNhoLogin(_:)), for: UIControlEvents.valueChanged)
        
        for view in arrView {
            uvFormBase.addSubview(view)
            uvFormBase.addContraintByVSF(VSF: "H:|-20-[v0]-20-|", views: view)
        }
        uvFormBase.addContraintByVSF(VSF: "V:|[v0(70)][v1(21)]-4-[v2(30)]-20-[v3(21)]-4-[v4(30)]-20-[v5(30)]-20-[v6(30)]-10-[v7(30)]-10-[v8(30)]-20-|", views: arrView)
        
        btnLogin.addTarget(self, action: #selector(LoginController.actionButton(_:)), for: UIControlEvents.touchUpInside)
        btnRegister.addTarget(self, action: #selector(LoginController.actionButton(_:)), for: UIControlEvents.touchUpInside)
        btnForgot.addTarget(self, action: #selector(LoginController.actionButton(_:)), for: UIControlEvents.touchUpInside)

    }
    
    func ghiNhoLogin(_ sender:UISwitch) {
        remember = sender.isOn
    }
    func actionButton(_ sender:MyButton)  {
        if sender == btnLogin {
            let check = isEmptyTextField(txt: txtEmail, txtMatKhau)
            if check == "OK" {
                if isValidEmail(candidate: txtEmail.text!) {
                    var rem = "true"
                    if !remember {
                        rem = "false"
                    }
                    let param = ["email":txtEmail.text!, "password":txtMatKhau.text!, "remember":rem]
                    sendRequestToServer(linkAPI: API.LOGIN, param: param, method: Method.post, extraLink: nil, completion: { (data) in
                        if data?[getResultAPI(link: API.DATA_RES)] as! String == getResultAPI(link: API.RES_NOK) {
                            self.showAlert(title: getAlertMessage(msg: ALERT.ERROR), mess: data?[getResultAPI(link: API.DATA_ERR)] as! String)
                        } else {
                            let dic = data?["data"] as! Dictionary<String,Any>
                            kh = KhachHang(khachhang: dic)
                            if self.remember {
                                let user = UserDefaults()
                                user.setValue(dic, forKey: "email")
                                user.synchronize()
                            }
                            let scr = HomeController()
                            self.navigationController?.pushViewController(scr, animated: true)
                        }
                    })
                } else {
                    showAlert(title: getAlertMessage(msg: ALERT.ERROR), mess: getAlertMessage(msg: ALERT.INVALIDEMAIL))
                }
            } else {
                showAlert(title: getAlertMessage(msg: ALERT.ERROR), mess: check)
            }
        } else if (sender == btnRegister) {
            let scr = RegisterController()
            navigationController?.pushViewController(scr, animated: true)
        } else {
            let scr = ForgotPassController()
            navigationController?.pushViewController(scr, animated: true)

        }
    }
}
