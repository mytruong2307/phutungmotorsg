//
//  ForgotPassController.swift
//  PhuTungMotorSG
//
//  Created by admin on 12/22/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class ForgotPassController: BaseController {
    
    var txtEmail:MyTextField!
    let lblTitle:UILabel = {
        let v = UILabel()
        v.textColor = Constants.MY_TEXT_COLOR
        v.font = UIFont(name: "Hoefler Text", size: 27)
        v.textAlignment = .center
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFormForgot()
    }
    
    override func addHomeIcon() {
        //Huy home menu
    }
    
    func setupFormForgot() {
        //Danh sach ca view de autolayout code tay
        var arrView:Array<UIView> = []
        //Add title
        lblTitle.text = getTextUI(ui: UI.TTL_FORGOTPASS)
        arrView.append(lblTitle)
        
        //Add Email
        let lblEmail = MyLabel()
        lblEmail.text = getTextUI(ui: UI.LBL_EMAIL)
        arrView.append(lblEmail)
        txtEmail = MyTextField()
        txtEmail.keyboardType = UIKeyboardType.emailAddress
        arrView.append(txtEmail)
        
        //Add button
        let btnSubmit:MyButton = MyButton()
        btnSubmit.setTitle(getTextUI(ui: UI.BTN_FORGOTPASS), for: UIControlState.normal)
        arrView.append(btnSubmit)
        
        for view in arrView {
            uvFormBase.addSubview(view)
            uvFormBase.addContraintByVSF(VSF: "H:|-20-[v0]-20-|", views: view)
        }
        uvFormBase.addContraintByVSF(VSF: "V:|[v0(70)][v1(21)]-4-[v2(30)]-20-[v3(30)]-20-|", views: arrView)
        btnSubmit.addTarget(self, action: #selector(ForgotPassController.resetMatKhau), for: UIControlEvents.touchUpInside)
    }
    
    func resetMatKhau()  {
        if isValidEmail(candidate: txtEmail.text!) {
            sendRequestToServer(linkAPI: API.FORGOTPASS, param: nil, method: Method.get, extraLink: txtEmail.text!, completion: { (data) in
                if data?[getResultAPI(link: API.DATA_RES)] as! String != getResultAPI(link: API.RES_OK) {
                    self.showAlert(title: getAlertMessage(msg: ALERT.ERROR), mess: getAlertMessage(msg: ALERT.NOTEXISTEMAIL))
                } else {
                    self.showAlertActionOK(title: getAlertMessage(msg: ALERT.NOTICE), mess: getAlertMessage(msg: ALERT.CHECKEMAIL), complete: {
                        _ = self.navigationController?.popViewController(animated: true)
                    })
                }
                
            })
            
        } else {
            showAlert(title: getAlertMessage(msg: ALERT.ERROR), mess: getAlertMessage(msg: ALERT.INVALIDEMAIL))
        }
    }
}
