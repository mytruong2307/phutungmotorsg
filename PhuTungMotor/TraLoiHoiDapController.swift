//
//  TraLoiHoiDapController.swift
//  PhuTungMotor
//
//  Created by admin on 3/8/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class TraLoiHoiDapController: BaseController {
    
    let lblTitle:UILabel = {
        let v = UILabel()
        v.textAlignment = .center
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textColor = Constants.MY_TEXT_COLOR
        v.text = getTextUI(ui: UI.LBL_ANSWER)
        v.font = UIFont(name: "Hoefler Text", size: 27)
        return v
    }()
    
    let vTen:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblNguoiHoi:UILabel = {
        let v = UILabel()
        v.textColor = Constants.MY_TEXT_COLOR
        v.text = getTextUI(ui: UI.LBL_NGUOIHOI)
        v.font = UIFont.italicSystemFont(ofSize: 14)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblNameKH:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont.boldSystemFont(ofSize: 17)
        v.textColor = Constants.MY_TEXT_COLOR
        return v
    }()
    
    let lblDay:UILabel = {
        let v = UILabel()
        v.font = UIFont.italicSystemFont(ofSize: 14)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textColor = Constants.MY_TEXT_COLOR
        v.textAlignment = .right
        return v

    }()
    
    let lblCauHoi:UILabel = {
        let v = UILabel()
        v.font = UIFont.italicSystemFont(ofSize: 14)
        v.textColor = Constants.MY_TEXT_COLOR
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = getTextUI(ui: UI.LBL_CAUHOI)
        return v
    }()
    
    let lblDCauHoi:UILabel = {
        let v = UILabel()
        v.font = UIFont.systemFont(ofSize: 16)
        v.textColor = Constants.MY_TEXT_COLOR
        v.numberOfLines = 0
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblTraLoi:UILabel = {
        let v = UILabel()
        v.font = UIFont.italicSystemFont(ofSize: 14)
        v.textColor = Constants.MY_TEXT_COLOR
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = getTextUI(ui: UI.LBL_TRALOI)
        return v
    }()
    
    let txtDTraLoi:UITextView = {
        let v = UITextView()
        v.font = UIFont.systemFont(ofSize: 16)
        v.clipsToBounds = true
        v.layer.cornerRadius = 10
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let scroll:UIScrollView = {
        let v:UIScrollView = UIScrollView()
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
    
    var hoiDap:HoiDap = HoiDap()
    let btnTraLoi:MyButton = MyButton()
    var bottom_Normal:NSLayoutConstraint!
    var bottom_Key:NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(TraLoiHoiDapController.show(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TraLoiHoiDapController.hide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        setupView()
        setupData()
    }
    
    override func addMenuIcon() {
        //Huy nut
    }
    
    override func addHomeIcon() {
        //Gan nut back
    }
    
    override func addForm() {
        //Huy form goc
    }
    
    func setupView()  {
        //ScrollView
        uvMain.addViewFullScreen(views: scroll)
        
        scroll.addViewFullScreen(views: viewForScroll)
        viewForScroll.widthAnchor.constraint(equalTo: uvMain.widthAnchor, multiplier: 1).isActive = true
        viewForScroll.heightAnchor.constraint(greaterThanOrEqualTo: uvMain.heightAnchor, multiplier: 1).isActive = true
        
        
        //Add 2 view de chen form vao
        viewForScroll.addSubview(uvBackground)
        viewForScroll.addSubview(uvForm)
        
        uvForm.centerXAnchor.constraint(equalTo: viewForScroll.centerXAnchor).isActive = true
        uvForm.topAnchor.constraint(equalTo: viewForScroll.topAnchor, constant: 20).isActive = true
        uvForm.widthAnchor.constraint(equalTo: viewForScroll.widthAnchor, multiplier: 0.85).isActive = true
        bottom_Normal = uvForm.bottomAnchor.constraint(equalTo: viewForScroll.bottomAnchor, constant: -20)
        bottom_Normal.isActive = true
        
        uvBackground.leftAnchor.constraint(equalTo: uvForm.leftAnchor).isActive = true
        uvBackground.topAnchor.constraint(equalTo: uvForm.topAnchor).isActive = true
        uvBackground.widthAnchor.constraint(equalTo: uvForm.widthAnchor).isActive = true
        uvBackground.heightAnchor.constraint(equalTo: uvForm.heightAnchor).isActive = true

        
        let HSL:String = "H:|-10-[v0]-10-|"
        let HSL1:String = "H:|-20-[v0]-10-|"
        let VSL:String = "V:|-20-[v0]-10-[v1]-5-[v2]-5-[v3]-4-[v4]-20-[v5]-4-[v6]-20-[v7(30)]-20-|"
        
        uvForm.addSubview(views: lblTitle, vTen, lblDay, lblCauHoi, lblDCauHoi, lblTraLoi, txtDTraLoi, btnTraLoi)
        
        txtDTraLoi.heightAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true
        
        uvForm.addContraintByVSF(VSF: HSL, views: lblTitle)
        uvForm.addContraintByVSF(VSF: HSL, views: vTen)
        uvForm.addContraintByVSF(VSF: HSL, views: lblDay)
        uvForm.addContraintByVSF(VSF: HSL, views: lblCauHoi)
        uvForm.addContraintByVSF(VSF: HSL1, views: lblDCauHoi)
        uvForm.addContraintByVSF(VSF: HSL, views: lblTraLoi)
        uvForm.addContraintByVSF(VSF: HSL, views: txtDTraLoi)
        uvForm.addContraintByVSF(VSF: HSL, views: btnTraLoi)
        
        uvForm.addContraintByVSF(VSF: VSL, views: lblTitle, vTen, lblDay, lblCauHoi, lblDCauHoi, lblTraLoi, txtDTraLoi, btnTraLoi)
        
        
        vTen.addSubview(views: lblNguoiHoi, lblNameKH)
        lblDay.rightAnchor.constraint(equalTo: vTen.rightAnchor, constant: 0).isActive = true
        
        vTen.addContraintByVSF(VSF: "H:|[v0][v1]|", views: lblNguoiHoi, lblNameKH)
        vTen.addContraintByVSF(VSF: "V:|[v0]|", views: lblNguoiHoi)
        vTen.addContraintByVSF(VSF: "V:|[v0]|", views: lblNameKH)
    }
    
    func setupData() {
        paramAdmin["truycap"] = "3"
        lblNameKH.text = hoiDap.ten
        lblDay.text = hoiDap.created_at.getDurationTime()
        lblDCauHoi.text = hoiDap.cauhoi
        txtDTraLoi.text = hoiDap.tomtat
        
        btnTraLoi.setTitle(getTextUI(ui: UI.BTN_ANSWER), for: UIControlState.normal)
        btnTraLoi.addTarget(self, action: #selector(TraLoiHoiDapController.traLoiHoiDap), for: .touchUpInside)
    }
    
    func show(_ notification:NSNotification)
    {
        let valueKeyboard:NSValue = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        let sizeKeyboard:CGRect = valueKeyboard.cgRectValue
        bottom_Key = uvForm.bottomAnchor.constraint(equalTo: viewForScroll.bottomAnchor, constant: -sizeKeyboard.height)
        bottom_Key.isActive = true
        bottom_Normal.isActive = false
    }
    
    func hide(_ notification:NSNotification)
    {
        if bottom_Key != nil {
            bottom_Key.isActive = false
        }
        bottom_Normal.isActive = true
        UIView.animate(withDuration: 1) {
            self.view.layoutSubviews()
        }
    }
    
    func traLoiHoiDap()  {
        showLog(mess: "Tra loi")
        var tomtat = txtDTraLoi.text
        tomtat = tomtat?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if tomtat != "" {
            var param = paramAdmin
            param["tomtat"] = txtDTraLoi.text
            param["id"] = "\(hoiDap.id)"
            param["hanhdong"] = "answer"
            showAlertAction(title: getAlertMessage(msg: ALERT.NOTICE), mess: getAlertMessage(msg: ALERT.ANSWER), complete: {
                self.sendRequestAdmin(linkAPI: API.TRALOI, param: param, method: Method.post, extraLink: nil, completion: { (object) in
                    if let _ = object?[getResultAPI(link: API.DATA_RETURN)] as? Dictionary<String,Any> {
                        self.showAlertActionOK(title: getAlertMessage(msg: ALERT.NOTICE), mess: getAlertMessage(msg: ALERT.OKANSWER), complete: {
                            let _ = self.navigationController?.popViewController(animated: true)
                        })
                    } else {
                        let mes = object?[getResultAPI(link: API.DATA_ERR)] as! String
                        self.showAlert(title: getAlertMessage(msg: ALERT.ERROR), mess: mes)
                    }
                })
            })
            
        } else {
            showAlert(title: getAlertMessage(msg: ALERT.ERROR), mess: getAlertMessage(msg: ALERT.EMPTYTEXTFIELD))
        }
        
    }
}
