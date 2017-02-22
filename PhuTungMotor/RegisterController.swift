//
//  RegisterController.swift
//  PhuTungMotorSG
//
//  Created by admin on 12/19/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class RegisterController: BaseController {
    
    var txtTam, txtTen, txtDienThoai, txtEmail, txtMatKhau, txtReMatKhau, txtTinh, txtQuan, txtPhuong, txtSoNha, txtXeDangDung:MyTextField!
    var id = -1
    var arrDuLieu:Array<Address> = []
    var khoangCach:CGFloat = 0
    var point:CGPoint = CGPoint()
    var shopping = false // Đanhs dau mua hang
    
    let scroll:UIScrollView = {
        let v:UIScrollView = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let tblMain:UITableView = {
        let v:UITableView = UITableView()
        v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return v
    }()
    
    let lblTitle:UILabel = {
        let v = UILabel()
        v.textColor = Constants.MY_TEXT_COLOR
        v.font = UIFont(name: "Hoefler Text", size: 36)
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
    
    var gender = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterController.show(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterController.hide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        setupFormRegister()
        
        txtTam = MyTextField()
        
        tblMain.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tblMain.isHidden = true
        tblMain.delegate = self
        tblMain.dataSource = self
        
    }
    
    override func addHomeIcon() {
        //Huy home menu
    }
    override func addForm() {
        //Huy form goc
    }
    
    func setupFormRegister() {
        //ScrollView
        super.uvMain.addViewFullScreen(views: scroll)
        
        scroll.addViewFullScreen(views: viewForScroll)
        viewForScroll.widthAnchor.constraint(equalTo: super.uvMain.widthAnchor, multiplier: 1).isActive = true
        viewForScroll.heightAnchor.constraint(greaterThanOrEqualTo: super.uvMain.heightAnchor, multiplier: 1).isActive = true
        
        
        //Add 2 view de chen form vao
        viewForScroll.addSubview(uvBackground)
        viewForScroll.addSubview(uvForm)
        
        uvForm.centerXAnchor.constraint(equalTo: viewForScroll.centerXAnchor).isActive = true
        uvForm.centerYAnchor.constraint(equalTo: viewForScroll.centerYAnchor).isActive = true
        uvForm.widthAnchor.constraint(equalTo: viewForScroll.widthAnchor, multiplier: 0.85).isActive = true
        
        uvBackground.leftAnchor.constraint(equalTo: uvForm.leftAnchor).isActive = true
        uvBackground.topAnchor.constraint(equalTo: uvForm.topAnchor).isActive = true
        uvBackground.widthAnchor.constraint(equalTo: uvForm.widthAnchor).isActive = true
        uvBackground.heightAnchor.constraint(equalTo: uvForm.heightAnchor).isActive = true
        
        
        //Danh sach ca view de autolayout code tay
        var arrView:Array<UIView> = []
        
        
        //Add title
        lblTitle.text = getTextUI(ui: UI.FRM_REGISTER)
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
        
        //PHAN CA NHAN
        let lblContact = UILabel()
        lblContact.textColor = Constants.MY_TEXT_COLOR
        lblContact.text = getTextUI(ui: UI.LBL_PERSONALINFO)
        arrView.append(lblContact)
        
        let lblGach2 = UILabel()
        lblGach2.layer.borderColor = Constants.MY_TEXT_COLOR.cgColor
        lblGach2.layer.borderWidth = 1
        arrView.append(lblGach2)
        
        vertical = "\(vertical)[v\(i)(30)][v\(i+1)(1)]-10-"
        i += 2
        
        //Add Ten
        let lblTen = MyLabel()
        lblTen.text = getTextUI(ui: UI.LBL_NAME)
        arrView.append(lblTen)
        txtTen = MyTextField()
        arrView.append(txtTen)
        vertical = "\(vertical)[v\(i)(21)]-4-[v\(i+1)(30)]-20-"
        i += 2
        
        //Add Xe đang dùng
        let lblxe = MyLabel()
        lblxe.text = getTextUI(ui: UI.LBL_BIKETYPE)
        arrView.append(lblxe)
        txtXeDangDung = MyTextField()
        arrView.append(txtXeDangDung)
        vertical = "\(vertical)[v\(i)(21)]-4-[v\(i+1)(30)]-20-"
        i += 2
        
        //Add giới tính
        let uvGender = UIView()
        arrView.append(uvGender)
        vertical = "\(vertical)[v\(i)(30)]-20-"
        i += 1
        
        
        let lblGender = MyLabel()
        lblGender.text = getTextUI(ui: UI.LBL_GENDER)
        let btnGender = UISegmentedControl()
        btnGender.insertSegment(withTitle: getTextUI(ui: UI.LBL_FEMALE), at: 0, animated: true)
        btnGender.insertSegment(withTitle: getTextUI(ui: UI.LBL_MALE), at: 1, animated: true)
        btnGender.selectedSegmentIndex = 1
        btnGender.addTarget(self, action: #selector(RegisterController.chonGioiTinh(_:)), for: UIControlEvents.allEvents)
        
        uvGender.addSubview(lblGender)
        uvGender.addSubview(btnGender)
        uvGender.addContraintByVSF(VSF: "V:|[v0]|", views: lblGender)
        uvGender.addContraintByVSF(VSF: "V:|[v0]|", views: btnGender)
        uvGender.addContraintByVSF(VSF: "H:|[v0]-5-[v1]|", views: lblGender, btnGender)
        
        //PHAN THÔNG TIN LIÊN LẠC
        let lblPer = UILabel()
        lblPer.textColor = Constants.MY_TEXT_COLOR
        lblPer.text = getTextUI(ui: UI.LBL_CONTACT)
        arrView.append(lblPer)
        
        //Add duong gach
        let lblGach1 = UILabel()
        lblGach1.layer.borderColor = Constants.MY_TEXT_COLOR.cgColor
        lblGach1.layer.borderWidth = 1
        arrView.append(lblGach1)
        
        vertical = "\(vertical)[v\(i)(30)][v\(i+1)(1)]-10-"
        i += 2
        
        //Add Tỉnh
        let lbltinh = MyLabel()
        lbltinh.text = getTextUI(ui: UI.LBL_PROVINCE)
        arrView.append(lbltinh)
        txtTinh = MyTextField()
        arrView.append(txtTinh)
        vertical = "\(vertical)[v\(i)(21)]-4-[v\(i+1)(30)]-20-"
        i += 2
        
        //Add Quận
        let lblquan = MyLabel()
        lblquan.text = getTextUI(ui: UI.LBL_DISTRICT)
        arrView.append(lblquan)
        txtQuan = MyTextField()
        arrView.append(txtQuan)
        vertical = "\(vertical)[v\(i)(21)]-4-[v\(i+1)(30)]-20-"
        i += 2
        
        //Add Phường
        let lblPhuong = MyLabel()
        lblPhuong.text = getTextUI(ui: UI.LBL_WARD)
        arrView.append(lblPhuong)
        txtPhuong = MyTextField()
        arrView.append(txtPhuong)
        vertical = "\(vertical)[v\(i)(21)]-4-[v\(i+1)(30)]-20-"
        i += 2
        
        //Add Số nhà
        let lblsonha = MyLabel()
        lblsonha.text = getTextUI(ui: UI.LBL_ADDRESS)
        arrView.append(lblsonha)
        txtSoNha = MyTextField()
        arrView.append(txtSoNha)
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
        
        //Add button
        let btnRegister:MyButton = MyButton()
        btnRegister.setTitle(getTextUI(ui: UI.FRM_REGISTER), for: UIControlState.normal)
        arrView.append(btnRegister)
        
        vertical = "\(vertical)[v\(i)(30)]-20-|"
        showLog(mess: vertical)
        
        for view in arrView {
            uvForm.addSubview(view)
            uvForm.addContraintByVSF(VSF: "H:|-20-[v0]-20-|", views: view)
            if let textField = view as? MyTextField {
                textField.addTarget(self, action: #selector(RegisterController.nhapData(_:)), for: UIControlEvents.editingDidBegin)
            }
        }
        uvForm.addContraintByVSF(VSF: vertical, views: arrView)
        
        uvForm.bottomAnchor.constraint(equalTo: viewForScroll.bottomAnchor, constant: -50).isActive = true
        uvForm.addSubview(tblMain)
        
        btnRegister.addTarget(self, action: #selector(RegisterController.register), for: .touchUpInside)
    }
    
    func nhapData(_ sender:MyTextField) {
        point = (sender.superview?.convert(sender.frame.origin, to: nil))!
        khoangCach = uvForm.frame.origin.y + sender.frame.origin.y
        showLog(mess: khoangCach)
        txtTam = sender
        var link:String = getLinkService(link: API.PROVINCE)
        switch sender {
        case txtTinh:
            
            break
        case txtQuan:
            if txtTinh.text == "" {
                showAlert(title: getAlertMessage(msg: ALERT.ERROR), mess: getAlertMessage(msg: ALERT.CHOOSEPROVINCE))
                tblMain.isHidden = true
                txtQuan.text = ""
            } else {
                link = "\(link)/\(id)"
            }
            break
        case txtPhuong:
            if txtTinh.text == "" || txtQuan.text == "" {
                showAlert(title: getAlertMessage(msg: ALERT.ERROR), mess: getAlertMessage(msg: ALERT.CHOOSEDISTRICT))
                tblMain.isHidden = true
                txtPhuong.text = ""
            } else {
                link = "\(link)/\(id)/edit"
            }
            break
        case txtXeDangDung:
            link = ""
            arrDuLieu.removeAll()
            for i in arrLoaiXe
            {
                arrDuLieu.append(Address(loaixe: i))
            }
            tblMain.reloadData()
            tblMain.frame = CGRect(x: sender.frame.origin.x, y: sender.frame.origin.y - 201,  width: sender.frame.size.width, height: 200)
            tblMain.isHidden = false
            break
        default:
            link = ""
            tblMain.isHidden = true
            break
        }
        if link != "" {
            showLog(mess: link)
            arrDuLieu.removeAll()
            getJson(link: link, completion: { (object) in
                if let dic = object as? Dictionary<String,Any> {
                    let res = dic[getResultAPI(link: API.DATA_RES)] as? String
                    if res == getResultAPI(link: API.RES_OK){
                        if let data = dic[getResultAPI(link: API.DATA_RETURN)] as? Array<Dictionary<String, Any>> {
                            for i in data
                            {
                                self.arrDuLieu.append(Address(address: i))
                            }
                            DispatchQueue.main.async {
                                self.tblMain.reloadData()
                            }
                        }
                    }
                } else {
                    showLog(mess: CONSOLE.JSON)
                }
            })
            tblMain.frame = CGRect(x: sender.frame.origin.x, y: sender.frame.origin.y - 201,  width: sender.frame.size.width, height: 200)
            tblMain.isHidden = false
        }
    }
    
    func show(_ notification:NSNotification)
    {
        let valueKeyboard:NSValue = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        let sizeKeyboard:CGRect = valueKeyboard.cgRectValue
        uvForm.bottomAnchor.constraint(equalTo: viewForScroll.bottomAnchor, constant: -(1 + sizeKeyboard.size.height)).isActive = true
        UIView.animate(withDuration: 1, animations: {
            self.view.layoutSubviews()
            self.scroll.setContentOffset(CGPoint(x: 0, y: sizeKeyboard.size.height + self.khoangCach), animated: true)
        })
    }
    
    func hide(_ notification:NSNotification)
    {
        uvForm.bottomAnchor.constraint(equalTo: viewForScroll.bottomAnchor, constant: -50).isActive = true
        UIView.animate(withDuration: 1) {
            self.view.layoutSubviews()
        }
    }
    
    
    func chonGioiTinh(_ sender:UISegmentedControl) {
        gender = sender.selectedSegmentIndex
    }
    
    func register() {
        let checked:String = isEmptyTextField(txt: txtTen, txtDienThoai, txtEmail, txtMatKhau, txtReMatKhau, txtTinh, txtQuan, txtPhuong, txtSoNha, txtXeDangDung)
        if  checked != "OK" {
            showAlert(title: getAlertMessage(msg: ALERT.ERROR), mess: checked)
        } else {
            if !isValidEmail(candidate: txtEmail.text!) {
                showAlert(title: getAlertMessage(msg: ALERT.ERROR), mess: getAlertMessage(msg: ALERT.INVALIDEMAIL))
                txtEmail.becomeFirstResponder()
            } else {
                if !isValidPassword(candidate: txtMatKhau.text!) {
                    showAlert(title: getAlertMessage(msg: ALERT.ERROR), mess: getAlertMessage(msg: ALERT.INVALIDPASS))
                    txtMatKhau.becomeFirstResponder()
                } else if txtMatKhau.text != txtReMatKhau.text {
                    showAlert(title: getAlertMessage(msg: ALERT.ERROR), mess: getAlertMessage(msg: ALERT.PASSNOTMATCH))
                    txtMatKhau.becomeFirstResponder()
                } else {
                    var gioitinh = getTextUI(ui: UI.LBL_MALE)
                    if gender == 0 {
                        gioitinh = getTextUI(ui: UI.LBL_FEMALE)
                    }
                    var param = Dictionary<String,String>()
                    param["ten"] = txtTen.text!
                    param["email"] = txtEmail.text!
                    param["dienthoai"] = txtDienThoai.text!
                    param["xedangdung"] = txtXeDangDung.text!
                    param["tinh"] = txtTinh.text!
                    param["quan"] = txtQuan.text!
                    param["phuong"] = txtPhuong.text!
                    param["sonha"] = txtSoNha.text!
                    param["gioitinh"] = gioitinh
                    param["khachhang"] = "1"
                    param["password"] = txtMatKhau.text!
                    sendRequestToServer(linkAPI: API.REGISTER, param: param, method: Method.post, extraLink: nil, completion: { (data) in
                        if data?[getResultAPI(link: API.DATA_RES)] as! String == getResultAPI(link: API.RES_NOK) {
                            self.showAlert(title: getAlertMessage(msg: ALERT.ERROR), mess: getAlertMessage(msg: ALERT.USEDEMAIL))
                            self.txtEmail.becomeFirstResponder()
                        } else {
                            self.showAlertActionOK(title: getAlertMessage(msg: ALERT.NOTICE), mess: getAlertMessage(msg: ALERT.REGISTEROK), complete: {
                                let scr = LoginController()
                                scr.shopping = self.shopping
                                self.navigationController?.pushViewController(LoginController(), animated: true)
                            })
                        }
                    })
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == tblMain {
            return 1
        } else {
            return super.numberOfSections(in: tableView)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblMain {
            return arrDuLieu.count
        } else {
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblMain {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = arrDuLieu[indexPath.row].ten
            return cell
        } else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tblMain {
            txtTam.text = arrDuLieu[indexPath.row].ten
            id = arrDuLieu[indexPath.row].id
            tblMain.isHidden = true
        } else {
            super.tableView(tableView, didSelectRowAt: indexPath)
        }
    }
}

