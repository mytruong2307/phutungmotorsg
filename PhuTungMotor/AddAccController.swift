//
//  AddAccController.swift
//  PhuTungMotor
//
//  Created by admin on 3/5/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class AddAccController: MenuAdminController {
    
    var arrPer:Array<Int> = []
    var txtName, txtEmail, txtMatKhau, txtReMatKhau:MyTextField!
    var btnAdd:MyButton!
    
    let lblTitle:UILabel = {
        let v = UILabel()
        v.textColor = Constants.MY_TEXT_COLOR
        v.font = UIFont(name: "Hoefler Text", size: 27)
        v.textAlignment = .center
        v.text = getTextUI(ui: UI.LBL_ADDEMPLOYEE)
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
    
    let btnAddAccount:MyButton = MyButton()
    var bottom_Normal:NSLayoutConstraint!
    var bottom_Key:NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(AddAccController.show(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddAccController.hide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        setupView()
    }
    
    override func addHomeIcon() {
        //Huy home menu
    }
    override func addForm() {
        //Huy form goc
    }
    
    func show(_ notification:NSNotification)
    {
        let valueKeyboard:NSValue = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        let sizeKeyboard:CGRect = valueKeyboard.cgRectValue
        let khoangCach = 40 - sizeKeyboard.height
        bottom_Key = uvForm.bottomAnchor.constraint(equalTo: viewForScroll.bottomAnchor, constant: -40 + khoangCach)
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
    
    func setupView()  {
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
        
        
        //Danh sach ca view de autolayout code tay
        var arrView:Array<UIView> = []
        
        
        //Add title
        arrView.append(lblTitle)
        
        //PHAN TAI KHOAN
        let lblAccount = UILabel()
        lblAccount.text = getTextUI(ui: UI.LBL_ACCOUNT)
        lblAccount.textColor = Constants.MY_TEXT_COLOR
        arrView.append(lblAccount)
        
        //Add duong gach
        let lblGach = UILabel()
        lblGach.layer.borderColor = Constants.MY_TEXT_COLOR.cgColor
        lblGach.layer.borderWidth = 1
        arrView.append(lblGach)
        
        var vertical = "V:|[v0(70)][v1(30)][v2(1)]-10-"
        var i = 3
        
        //Add Ten
        let lblName = MyLabel()
        lblName.text = getTextUI(ui: UI.LBL_NAME)
        arrView.append(lblName)
        txtName = MyTextField()
        arrView.append(txtName)
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
        
        //Add Mat khau
        let lblPass = MyLabel()
        lblPass.text = getTextUI(ui: UI.LBL_PASS)
        arrView.append(lblPass)
        txtMatKhau = MyTextField()
        txtMatKhau.isSecureTextEntry = true
        arrView.append(txtMatKhau)
        vertical = "\(vertical)[v\(i)(21)]-4-[v\(i+1)(30)]-20-"
        i += 2
        
        //Add Nhập lại Mat khau
        let lblRePass = MyLabel()
        lblRePass.text = getTextUI(ui: UI.LBL_REPASS)
        arrView.append(lblRePass)
        txtReMatKhau = MyTextField()
        txtReMatKhau.isSecureTextEntry = true
        arrView.append(txtReMatKhau)
        vertical = "\(vertical)[v\(i)(21)]-4-[v\(i+1)(30)]-20-"
        i += 2
        
        //PHAN QUYEN
        let lblContact = UILabel()
        lblContact.textColor = Constants.MY_TEXT_COLOR
        lblContact.text = getTextUI(ui: UI.LBL_ROLE)
        arrView.append(lblContact)
        
        let lblGach2 = UILabel()
        lblGach2.layer.borderColor = Constants.MY_TEXT_COLOR.cgColor
        lblGach2.layer.borderWidth = 1
        arrView.append(lblGach2)
        
        vertical = "\(vertical)[v\(i)(30)][v\(i+1)(1)]-10-"
        i += 2
        
        if paramAdmin["quyen"] as! String == "10" {
            let vAdmin:UIView = UIView()
            arrView.append(vAdmin)
            
            vertical = "\(vertical)[v\(i)(30)]-10-"
            i += 1
            
            let lblAdmin = UILabel()
            lblAdmin.translatesAutoresizingMaskIntoConstraints = false
            lblAdmin.textColor = Constants.MY_TEXT_COLOR
            lblAdmin.text = getTextUI(ui: UI.LBL_PERADMIN)
            
            let swAdmin = UISwitch()
            swAdmin.tag = 1
            swAdmin.translatesAutoresizingMaskIntoConstraints = false
            swAdmin.isOn = false
            swAdmin.addTarget(self, action: #selector(AddAccController.capQuyen(_:)), for: UIControlEvents.valueChanged)
            
            vAdmin.addSubview(views: lblAdmin, swAdmin)
            vAdmin.addContraintByVSF(VSF: "H:|[v0][v1(51)]|", views: lblAdmin, swAdmin)
            vAdmin.addContraintByVSF(VSF: "V:|[v0]|", views: lblAdmin)
            vAdmin.addContraintByVSF(VSF: "V:|[v0]|", views: swAdmin)
            
            let vAcc:UIView = UIView()
            arrView.append(vAcc)
            vertical = "\(vertical)[v\(i)(30)]-10-"
            i += 1
            
            let lblAcc = UILabel()
            lblAcc.translatesAutoresizingMaskIntoConstraints = false
            lblAcc.textColor = Constants.MY_TEXT_COLOR
            lblAcc.text = getTextUI(ui: UI.LBL_PERACC)
            
            let swAcc = UISwitch()
            swAcc.translatesAutoresizingMaskIntoConstraints = false
            swAcc.isOn = false
            swAcc.tag = 2
            swAcc.addTarget(self, action: #selector(AddAccController.capQuyen(_:)), for: UIControlEvents.valueChanged)
            
            vAcc.addSubview(views: lblAcc, swAcc)
            vAcc.addContraintByVSF(VSF: "H:|[v0][v1(51)]|", views: lblAcc, swAcc)
            vAcc.addContraintByVSF(VSF: "V:|[v0]|", views: lblAcc)
            vAcc.addContraintByVSF(VSF: "V:|[v0]|", views: swAcc)
            
            let VThongTin:UIView = UIView()
            arrView.append(VThongTin)
            
            vertical = "\(vertical)[v\(i)(30)]-10-"
            i += 1
            
            let lblThongTin = UILabel()
            lblThongTin.translatesAutoresizingMaskIntoConstraints = false
            lblThongTin.textColor = Constants.MY_TEXT_COLOR
            lblThongTin.text = getTextUI(ui: UI.LBL_PERDOANHNGHIEP)
            
            let swDN = UISwitch()
            swDN.translatesAutoresizingMaskIntoConstraints = false
            swDN.isOn = false
            swDN.tag = 5
            swDN.addTarget(self, action: #selector(AddAccController.capQuyen(_:)), for: UIControlEvents.valueChanged)
            
            VThongTin.addSubview(views: lblThongTin, swDN)
            VThongTin.addContraintByVSF(VSF: "H:|[v0][v1(51)]|", views: lblThongTin, swDN)
            VThongTin.addContraintByVSF(VSF: "V:|[v0]|", views: lblThongTin)
            VThongTin.addContraintByVSF(VSF: "V:|[v0]|", views: swDN)
            
        } else if paramAdmin["quyen"] as! String == "1" {
            let vAcc:UIView = UIView()
            arrView.append(vAcc)
            vertical = "\(vertical)[v\(i)(30)]-10-"
            i += 1
            
            let lblAcc = UILabel()
            lblAcc.translatesAutoresizingMaskIntoConstraints = false
            lblAcc.textColor = Constants.MY_TEXT_COLOR
            lblAcc.text = getTextUI(ui: UI.LBL_PERACC)
            
            let swAcc = UISwitch()
            swAcc.translatesAutoresizingMaskIntoConstraints = false
            swAcc.isOn = false
            swAcc.tag = 2
            swAcc.addTarget(self, action: #selector(AddAccController.capQuyen(_:)), for: UIControlEvents.valueChanged)
            
            vAcc.addSubview(views: lblAcc, swAcc)
            vAcc.addContraintByVSF(VSF: "H:|[v0][v1(51)]|", views: lblAcc, swAcc)
            vAcc.addContraintByVSF(VSF: "V:|[v0]|", views: lblAcc)
            vAcc.addContraintByVSF(VSF: "V:|[v0]|", views: swAcc)
        }
        
        let vHoiDap:UIView = UIView()
        arrView.append(vHoiDap)
        vertical = "\(vertical)[v\(i)(30)]-10-"
        i += 1
        
        let lblHoiDap = UILabel()
        lblHoiDap.translatesAutoresizingMaskIntoConstraints = false
        lblHoiDap.textColor = Constants.MY_TEXT_COLOR
        lblHoiDap.text = getTextUI(ui: UI.LBL_PERHOIDAP)
        
        let swHoiDap = UISwitch()
        swHoiDap.translatesAutoresizingMaskIntoConstraints = false
        swHoiDap.isOn = false
        swHoiDap.tag = 3
        swHoiDap.addTarget(self, action: #selector(AddAccController.capQuyen(_:)), for: UIControlEvents.valueChanged)
        
        vHoiDap.addSubview(views: lblHoiDap, swHoiDap)
        vHoiDap.addContraintByVSF(VSF: "H:|[v0][v1(51)]|", views: lblHoiDap, swHoiDap)
        vHoiDap.addContraintByVSF(VSF: "V:|[v0]|", views: lblHoiDap)
        vHoiDap.addContraintByVSF(VSF: "V:|[v0]|", views: swHoiDap)
        
        let vTinTuc:UIView = UIView()
        arrView.append(vTinTuc)
        vertical = "\(vertical)[v\(i)(30)]-10-"
        i += 1
        
        let lblTinTuc = UILabel()
        lblTinTuc.translatesAutoresizingMaskIntoConstraints = false
        lblTinTuc.textColor = Constants.MY_TEXT_COLOR
        lblTinTuc.text = getTextUI(ui: UI.LBL_PERTINTUC)
        
        let swTinTuc = UISwitch()
        swTinTuc.translatesAutoresizingMaskIntoConstraints = false
        swTinTuc.isOn = false
        swTinTuc.tag = 4
        swTinTuc.addTarget(self, action: #selector(AddAccController.capQuyen(_:)), for: UIControlEvents.valueChanged)
        
        vTinTuc.addSubview(views: lblTinTuc, swTinTuc)
        vTinTuc.addContraintByVSF(VSF: "H:|[v0][v1(51)]|", views: lblTinTuc, swTinTuc)
        vTinTuc.addContraintByVSF(VSF: "V:|[v0]|", views: lblTinTuc)
        vTinTuc.addContraintByVSF(VSF: "V:|[v0]|", views: swTinTuc)
        
        let vHangxe:UIView = UIView()
        arrView.append(vHangxe)
        vertical = "\(vertical)[v\(i)(30)]-10-"
        i += 1
        
        let lblHangXe = UILabel()
        lblHangXe.translatesAutoresizingMaskIntoConstraints = false
        lblHangXe.textColor = Constants.MY_TEXT_COLOR
        lblHangXe.text = getTextUI(ui: UI.LBL_PRODUCTTRADEMARK)
        
        let swHangXe = UISwitch()
        swHangXe.translatesAutoresizingMaskIntoConstraints = false
        swHangXe.isOn = false
        swHangXe.tag = 6
        swHangXe.addTarget(self, action: #selector(AddAccController.capQuyen(_:)), for: UIControlEvents.valueChanged)
        
        vHangxe.addSubview(views: lblHangXe, swHangXe)
        vHangxe.addContraintByVSF(VSF: "H:|[v0][v1(51)]|", views: lblHangXe, swHangXe)
        vHangxe.addContraintByVSF(VSF: "V:|[v0]|", views: lblHangXe)
        vHangxe.addContraintByVSF(VSF: "V:|[v0]|", views: swHangXe)
        
        let vLoaixe:UIView = UIView()
        arrView.append(vLoaixe)
        vertical = "\(vertical)[v\(i)(30)]-10-"
        i += 1
        
        let lblLoaiXe = UILabel()
        lblLoaiXe.translatesAutoresizingMaskIntoConstraints = false
        lblLoaiXe.textColor = Constants.MY_TEXT_COLOR
        lblLoaiXe.text = getTextUI(ui: UI.LBL_BIKEKIND)
        
        let swLoaiXe = UISwitch()
        swLoaiXe.translatesAutoresizingMaskIntoConstraints = false
        swLoaiXe.isOn = false
        swLoaiXe.tag = 7
        swLoaiXe.addTarget(self, action: #selector(AddAccController.capQuyen(_:)), for: UIControlEvents.valueChanged)
        
        vLoaixe.addSubview(views: lblLoaiXe, swLoaiXe)
        vLoaixe.addContraintByVSF(VSF: "H:|[v0][v1(51)]|", views: lblLoaiXe, swLoaiXe)
        vLoaixe.addContraintByVSF(VSF: "V:|[v0]|", views: lblLoaiXe)
        vLoaixe.addContraintByVSF(VSF: "V:|[v0]|", views: swLoaiXe)
        
        let vSanPham:UIView = UIView()
        arrView.append(vSanPham)
        vertical = "\(vertical)[v\(i)(30)]-10-"
        i += 1
        
        let lblSanPham = UILabel()
        lblSanPham.translatesAutoresizingMaskIntoConstraints = false
        lblSanPham.textColor = Constants.MY_TEXT_COLOR
        lblSanPham.text = getTextUI(ui: UI.LBL_PERSANPHAM)
        
        let swSanPham = UISwitch()
        swSanPham.translatesAutoresizingMaskIntoConstraints = false
        swSanPham.isOn = false
        swSanPham.tag = 8
        swSanPham.addTarget(self, action: #selector(AddAccController.capQuyen(_:)), for: UIControlEvents.valueChanged)
        
        vSanPham.addSubview(views: lblSanPham, swSanPham)
        vSanPham.addContraintByVSF(VSF: "H:|[v0][v1(51)]|", views: lblSanPham, swSanPham)
        vSanPham.addContraintByVSF(VSF: "V:|[v0]|", views: lblSanPham)
        vSanPham.addContraintByVSF(VSF: "V:|[v0]|", views: swSanPham)
        
        let vDonHang:UIView = UIView()
        arrView.append(vDonHang)
        vertical = "\(vertical)[v\(i)(30)]-10-"
        i += 1
        
        let lblDonHang = UILabel()
        lblDonHang.translatesAutoresizingMaskIntoConstraints = false
        lblDonHang.textColor = Constants.MY_TEXT_COLOR
        lblDonHang.text = getTextUI(ui: UI.LBL_PERDONHANG)
        
        let swDonHang = UISwitch()
        swDonHang.translatesAutoresizingMaskIntoConstraints = false
        swDonHang.isOn = false
        swDonHang.tag = 9
        swDonHang.addTarget(self, action: #selector(AddAccController.capQuyen(_:)), for: UIControlEvents.valueChanged)
        
        vDonHang.addSubview(views: lblDonHang, swDonHang)
        vDonHang.addContraintByVSF(VSF: "H:|[v0][v1(51)]|", views: lblDonHang, swDonHang)
        vDonHang.addContraintByVSF(VSF: "V:|[v0]|", views: lblDonHang)
        vDonHang.addContraintByVSF(VSF: "V:|[v0]|", views: swDonHang)
        
        let vSlider:UIView = UIView()
        arrView.append(vSlider)
        vertical = "\(vertical)[v\(i)(30)]-10-"
        i += 1
        
        let lblSlider = UILabel()
        lblSlider.translatesAutoresizingMaskIntoConstraints = false
        lblSlider.textColor = Constants.MY_TEXT_COLOR
        lblSlider.text = getTextUI(ui: UI.LBL_PERSLIDER)
        
        let swSlider = UISwitch()
        swSlider.translatesAutoresizingMaskIntoConstraints = false
        swSlider.isOn = false
        swSlider.tag = 11
        swSlider.addTarget(self, action: #selector(AddAccController.capQuyen(_:)), for: UIControlEvents.valueChanged)
        
        vSlider.addSubview(views: lblSlider, swSlider)
        vSlider.addContraintByVSF(VSF: "H:|[v0][v1(51)]|", views: lblSlider, swSlider)
        vSlider.addContraintByVSF(VSF: "V:|[v0]|", views: lblSlider)
        vSlider.addContraintByVSF(VSF: "V:|[v0]|", views: swSlider)
        
        let vEmail:UIView = UIView()
        arrView.append(vEmail)
        vertical = "\(vertical)[v\(i)(30)]-10-"
        i += 1
        
        let lblGuiEmail = UILabel()
        lblGuiEmail.translatesAutoresizingMaskIntoConstraints = false
        lblGuiEmail.textColor = Constants.MY_TEXT_COLOR
        lblGuiEmail.text = getTextUI(ui: UI.LBL_PERSENDMAIL)
        
        let swEmail = UISwitch()
        swEmail.translatesAutoresizingMaskIntoConstraints = false
        swEmail.isOn = false
        swEmail.tag = 12
        swEmail.addTarget(self, action: #selector(AddAccController.capQuyen(_:)), for: UIControlEvents.valueChanged)
        
        vEmail.addSubview(views: lblGuiEmail, swEmail)
        vEmail.addContraintByVSF(VSF: "H:|[v0][v1(51)]|", views: lblGuiEmail, swEmail)
        vEmail.addContraintByVSF(VSF: "V:|[v0]|", views: lblGuiEmail)
        vEmail.addContraintByVSF(VSF: "V:|[v0]|", views: swEmail)
        
        btnAdd = MyButton()
        btnAdd.setTitle(getTextUI(ui: UI.LBL_ADDEMPLOYEE), for: UIControlState.normal)
        arrView.append(btnAdd)
        vertical = "\(vertical)[v\(i)(30)]-20-|"
        
        for view in arrView {
            view.translatesAutoresizingMaskIntoConstraints = false
            uvForm.addSubview(view)
            uvForm.addContraintByVSF(VSF: "H:|-20-[v0]-20-|", views: view)
        }
        
        uvForm.addContraintByVSF(VSF: vertical, views: arrView)
        
        btnAdd.addTarget(self, action: #selector(AddAccController.themNhanVien), for: UIControlEvents.touchUpInside)
        
    }
    
    func themNhanVien()  {
        paramAdmin["truycap"] = "2"
        var param = paramAdmin
        let check = isEmptyTextField(txt: txtName, txtEmail, txtMatKhau, txtReMatKhau)
        if check != "OK" {
            showAlert(title: getAlertMessage(msg: ALERT.NOTICE), mess: check)
        } else {
            if isValidEmail(candidate: txtEmail.text!) {
                if isValidPassword(candidate: txtMatKhau.text!) {
                    if txtMatKhau.text == txtReMatKhau.text {
                        let quyen = getPermission();
                        if quyen == "" {
                            showAlert(title: getAlertMessage(msg: ALERT.NOTICE), mess: getAlertMessage(msg: ALERT.NOROLE))
                        } else {
                            param["ten"] = txtName.text
                            param["email"] = txtEmail.text
                            param["pass"] = txtMatKhau .text
                            param["quyen"] = quyen
                            param["newToken"] = "1"
                            param["truycap"] = "2"
                            showLog(mess: param)
                            sendRequestAdmin(linkAPI: API.THEMNHANVIEN, param: param, method: Method.post, extraLink: nil, completion: { (object) in
                                if let err = object?[getResultAPI(link: API.DATA_ERR)] as? Int {
                                    showLog(mess: "Err nhan duoc: \(err)")
                                    switch err {
                                    case 0:
                                        if let mess = object?[getResultAPI(link: API.DATA_RETURN)] as? String {
                                            self.showAlert(title: getAlertMessage(msg: ALERT.ERROR), mess: mess)
                                        }
                                        break
                                    case 1:
                                        self.showAlertAction(title: getAlertMessage(msg: ALERT.NOTICE), mess: getAlertMessage(msg: ALERT.CUSTOMERTOEMPLOYEE), complete: {
                                            if let data = object?[getResultAPI(link: API.DATA_RETURN)] as? Dictionary<String, Any> {
                                                let extra = "\(data["id"] as! Int)"
                                                param["token"] = paramAdmin["token"]
                                                self.changeCustomerToEmployee(param: param, extra: extra)
                                            }
                                        })
                                        break
                                    default:
                                        let msg:String = getAlertMessage(msg: ALERT.ADDEMPLOYEEOK) + self.txtEmail.text!
                                        let tem = getAlertMessage(msg: ALERT.ACTIVEACC)
                                        self.showAlertActionOK(title: getAlertMessage(msg: ALERT.NOTICE), mess: msg + tem, complete: {
                                            let _ = self.navigationController?.popViewController(animated: true)
                                        })
                                        break
                                    }
                                }
                            })
                        }
                    } else {
                        showAlert(title: getAlertMessage(msg: ALERT.NOTICE), mess: getAlertMessage(msg: ALERT.PASSNOTMATCH))
                    }
                } else {
                    showAlert(title: getAlertMessage(msg: ALERT.NOTICE), mess: getAlertMessage(msg: ALERT.INVALIDPASS))
                }
            } else {
                showAlert(title: getAlertMessage(msg: ALERT.NOTICE), mess: getAlertMessage(msg: ALERT.INVALIDEMAIL))
            }
            
        }
        
        
        
    }
    
    func changeCustomerToEmployee(param:Dictionary<String,Any>, extra:String)  {
        self.sendRequestAdmin(linkAPI: API.CHUYENNHANVIEN, param: param, method: Method.post, extraLink: extra, completion: { (object) in
            if let err = object?[getResultAPI(link: API.DATA_ERR)] as? Int {
                switch err {
                case 0:
                    if let mess = object?[getResultAPI(link: API.DATA_RETURN)] as? String {
                        self.showAlert(title: getAlertMessage(msg: ALERT.ERROR), mess: mess)
                    }
                    break
                case 1:
                    if let mess = object?[getResultAPI(link: API.DATA_RETURN)] as? String {
                        self.showAlert(title: getAlertMessage(msg: ALERT.ERROR), mess: mess)
                        let _ = self.navigationController?.popViewController(animated: true)
                    }
                    break
                default:
                    let msg:String = getAlertMessage(msg: ALERT.ADDEMPLOYEEOK) + self.txtEmail.text!
                    self.showAlertActionOK(title: getAlertMessage(msg: ALERT.NOTICE), mess: msg, complete: {
                        let _ = self.navigationController?.popViewController(animated: true)
                    })
                    break
                }
            }
        })
    }
    
    func capQuyen(_ sender:UISwitch){
        if sender.isOn {
            arrPer.append(sender.tag)
        } else {
            arrPer = arrPer.filter() {$0 != sender.tag}
        }
        showLog(mess: arrPer)
    }
    
    func getPermission() -> String {
        var result = ""
        if arrPer.count > 0 {
            arrPer = arrPer.sorted { $0 < $1 }
            for value in arrPer {
                switch value {
                case 1:
                    result = "1"
                    break
                case 11:
                    if result == "" {
                        result = "s"
                    } else {
                        result = "\(result),s"
                    }
                    break
                case 12:
                    if result == "" {
                        result = "m"
                    } else {
                        result = "\(result),m"
                    }
                    break
                default:
                    if result == "" {
                        result = "\(value)"
                    } else {
                        result = "\(result),\(value)"
                    }
                }
                if result == "1" {
                    return result
                }
            }
        }
        return result
    }
}
