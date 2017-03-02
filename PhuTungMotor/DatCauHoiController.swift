//
//  DatCauHoiController.swift
//  PhuTungMotor
//
//  Created by admin on 3/2/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class DatCauHoiController: BaseController {
    
    let lblTitle:UILabel = {
        let v = UILabel()
        v.textColor = Constants.MY_TEXT_COLOR
        v.font = UIFont(name: "Hoefler Text", size: 21)
        v.textAlignment = .center
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let btnPost:MyButton = MyButton()
    var txtTen, txtEmail, txtDienThoai:MyTextField!
    let txtCauHoi:UITextView = UITextView()
    var sendmail = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func addHomeIcon() {
        //Huy home menu
    }
    
    func setupView()  {
        //ve form
        //Danh sach ca view de autolayout code tay
        var arrView:Array<UIView> = []
        
        
        //Add title
        lblTitle.text = getTextUI(ui: UI.BTN_ASK)
        arrView.append(lblTitle)
        
        var vertical = "V:|[v0(70)]"
        var i = 1

        //Add Ten
        let lblTen = MyLabel()
        lblTen.text = getTextUI(ui: UI.LBL_NAME)
        arrView.append(lblTen)
        
        txtTen = MyTextField()
        arrView.append(txtTen)
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
        
        //Add Điện thoại
        let lblPhone = MyLabel()
        lblPhone.text = getTextUI(ui: UI.LBL_PHONE)
        arrView.append(lblPhone)
        
        txtDienThoai = MyTextField()
        txtDienThoai.keyboardType = UIKeyboardType.numberPad
        arrView.append(txtDienThoai)
        
        vertical = "\(vertical)[v\(i)(21)]-4-[v\(i+1)(30)]-20-"
        i += 2
        
        //Add Cau hoi
        let lblCauHoi = MyLabel()
        lblCauHoi.text = getTextUI(ui: UI.LBL_ASKCONTENT)
        arrView.append(lblCauHoi)
        
        txtCauHoi.clipsToBounds = true
        txtCauHoi.layer.cornerRadius = 10
        txtCauHoi.font = UIFont.systemFont(ofSize: 15)
        arrView.append(txtCauHoi)
        
        vertical = "\(vertical)[v\(i)(21)]-4-[v\(i+1)(120)]-20-"
        i += 2
        
                
        //add button
        btnPost.setTitle(getTextUI(ui: UI.BTN_POSTASK), for: UIControlState.normal)
        arrView.append(btnPost)
        
        vertical = "\(vertical)[v\(i)(30)][v\(i + 1)(30)]-20-|"
        showLog(mess: arrView.count)
        showLog(mess: vertical)

        for view in arrView {
            uvFormBase.addSubview(view)
            uvFormBase.addContraintByVSF(VSF: "H:|-20-[v0]-20-|", views: view)
        }
        uvFormBase.addContraintByVSF(VSF: vertical, views: arrView)

        if kh != nil {
            txtTen.text = kh?.ten
            txtEmail.text = kh?.email
            txtDienThoai.text = kh?.dienthoai
        }
        
        btnPost.addTarget(self, action: #selector(DatCauHoiController.postCauHoi), for: UIControlEvents.touchUpInside)

    }
    
    func isSendMail(_ sender:UISwitch)  {
        sendmail = sender.isOn
    }
    
    
    func postCauHoi() {
        var param = Dictionary<String,String>()
        var id = 0
        if kh != nil {
            id = (kh?.id)!
        }
        param["id"] = "\(id)"
        param["ten"] = txtTen.text
        param["dienthoai"] = txtDienThoai.text
        param["email"] = txtEmail.text
        param["cauhoi"] = txtCauHoi.text
        if sendmail {
            param["sendmail"] = "1"
        } else {
            param["sendmail"] = "0"
        }
        sendRequestToServer(linkAPI: API.DATCAUHOI, param: param, method: Method.post, extraLink: nil) { (object) in
            if object != nil {
                if let res = object?[getResultAPI(link: API.DATA_RES)] as? String {
                    if res == getResultAPI(link: API.RES_OK) {
                        self.showAlertAction(title: getAlertMessage(msg: ALERT.NOTICE), mess: getAlertMessage(msg: ALERT.ASKOK), complete: {
                            let _ = self.navigationController?.popViewController(animated: true)
                        })
                    } else {
                        self.showAlert(title: getAlertMessage(msg: ALERT.ERROR), mess: getAlertMessage(msg: ALERT.ASKNOK))
                    }
                }
            } else {
                self.showAlert(title: getAlertMessage(msg: ALERT.ERROR), mess: getAlertMessage(msg: ALERT.ASKNOK))
            }
        }
    }
}
