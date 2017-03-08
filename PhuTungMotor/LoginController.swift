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
    var shopping = false
    
    var top:NSLayoutConstraint!
    
    let lblTitle:UILabel = {
        let v = UILabel()
        v.textColor = Constants.MY_TEXT_COLOR
        v.font = UIFont(name: "Hoefler Text", size: 27)
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
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterController.show(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterController.hide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        setupFormLogin()
        top = uvFormBase.topAnchor.constraint(equalTo: uvMain.topAnchor, constant: 30)
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
    
    func show(_ notification:NSNotification)
    {
        let valueKeyboard:NSValue = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        let sizeKeyboard:CGRect = valueKeyboard.cgRectValue
        
        let khoangcach = UIScreen.main.bounds.height - (uvFormBase.frame.height + uvFormBase.frame.origin.y) - sizeKeyboard.height
        if khoangcach < 0 {
            top = uvFormBase.topAnchor.constraint(equalTo: uvMain.topAnchor, constant: uvFormBase.frame.origin.y + khoangcach - 54)
            top.isActive = true
            center.isActive = false
        }
        showLog(mess: khoangcach)
        
    }
    
    func hide(_ notification:NSNotification)
    {
        center.isActive = true
        top.isActive = false
        UIView.animate(withDuration: 1) {
            self.view.layoutSubviews()
        }
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
                        if let res = data?[getResultAPI(link: API.DATA_RES)] as? String {
                            if res == getResultAPI(link: API.RES_NOK) {
                                self.showAlert(title: getAlertMessage(msg: ALERT.ERROR), mess: data?[getResultAPI(link: API.DATA_ERR)] as! String)
                            } else {
                                //Login OK
                                var dic = data?["data"] as! Dictionary<String,Any>
                                //Them quyen vao KH truong hop muon dung luu mat khau
                                if let quyen = data?["quyen"] as? Array<String> {
                                    dic["quyen"] = quyen
                                }
                                
                                
                                kh = KhachHang(khachhang: dic)
                                if let token = data?["token"] as? String {
                                    paramAdmin["token"] = token
                                    paramAdmin["newToken"] = "0"
                                }
                                
                                if self.remember {
                                    let user = UserDefaults()
                                    user.setValue(dic, forKey: "email")
                                    user.synchronize()
                                }
                                if let nv = data?["nv"] as? Dictionary<String,Any> {
//                                    Them quyen vao KH truong hop muon khong luu mat khau
//                                    kh?.quyen = data?["quyen"] as! Array<String>
                                    if nv["lanlogin"] as! Int == 1 {
                                        let scr = ChangePassController()
                                        scr.isFirstLogin = "1"
                                        self.navigationController?.pushViewController(scr, animated: true)
                                    } else {
                                        self.showAlert2Action(title: getAlertMessage(msg: ALERT.NOTICE), mess: getAlertMessage(msg: ALERT.CHONTRANG), btnATitle: getAlertMessage(msg: ALERT.ADMIN), btnBTitle: getAlertMessage(msg: ALERT.KHACHHANG), actionA: {
                                            self.navigationController?.pushViewController(AdminController(), animated: true)
                                        }, actionB: {
                                            self.changePageKhachHang()
                                        })
                                    }
                                }
                                else {
                                    self.changePageKhachHang()
                                }
                                
                            }
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
    
    func changePageKhachHang()  {
        if self.shopping {
            //Dat hang thanh cong
            let scr = ShoppingController()
            self.navigationController?.pushViewController(scr, animated: true)
        } else {
            let _ = self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
