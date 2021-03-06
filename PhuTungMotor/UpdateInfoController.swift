//
//  UpdateInfoController.swift
//  PhuTungMotorSG
//
//  Created by admin on 12/22/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class UpdateInfoController: BaseController {
    
    var txtTam, txtTen, txtDienThoai, txtTinh, txtQuan, txtPhuong, txtSoNha, txtXeDangDung:MyTextField!
    var idTinh = -1
    var idQuan = -1
    var arrDuLieu:Array<Address> = []
    var khoangCach:CGFloat = 0
    var point:CGPoint = CGPoint()
    
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
    
    var gender = 1
    var bottom_Normal:NSLayoutConstraint!
    var bottom_Key:NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(UpdateInfoController.show(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UpdateInfoController.hide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        var param = Dictionary<String,String>()
        param["tenTinh"] = kh!.tinh
        param["tenQuan"] = kh!.quan
        sendRequestNoLoading(linkAPI: API.ADDRESS, param: param, method: Method.post, extraLink: nil) { (data) in
            if data?[getResultAPI(link: API.DATA_RES)] as! String == getResultAPI(link: API.RES_OK) {
                self.idTinh = data?["tinh"] as! Int
                self.idQuan = data?["quan"] as! Int
            }
        }
                
        setupFormUpdate()
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
    
    func setupFormUpdate() {
        //ScrollView
        super.uvMain.addViewFullScreen(views: scroll)
        
        scroll.addViewFullScreen(views: viewForScroll)
        viewForScroll.widthAnchor.constraint(equalTo: super.uvMain.widthAnchor, multiplier: 1).isActive = true
        viewForScroll.heightAnchor.constraint(greaterThanOrEqualTo: super.uvMain.heightAnchor, multiplier: 1).isActive = true
        
        
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
        lblTitle.text = getTextUI(ui: UI.TTL_UPDATEINFO)
        arrView.append(lblTitle)
        
        //PHAN CA NHAN
        let lblContact = UILabel()
        lblContact.textColor = Constants.MY_TEXT_COLOR
        lblContact.text = getTextUI(ui: UI.LBL_PERSONALINFO)
        arrView.append(lblContact)
        
        let lblGach2 = UILabel()
        lblGach2.layer.borderColor = Constants.MY_TEXT_COLOR.cgColor
        lblGach2.layer.borderWidth = 1
        arrView.append(lblGach2)
        
        var vertical = "V:|[v0(70)][v1(30)][v2(1)]-10-"
        var i = 3
        
        
        //Add Ten
        let lblTen = MyLabel()
        lblTen.text = getTextUI(ui: UI.LBL_NAME)
        arrView.append(lblTen)
        
        txtTen = MyTextField()
        txtTen.text = kh?.ten
        arrView.append(txtTen)
        vertical = "\(vertical)[v\(i)(21)]-4-[v\(i+1)(30)]-20-"
        i += 2
        
        //Add Xe đang dùng
        let lblxe = MyLabel()
        lblxe.text = getTextUI(ui: UI.LBL_BIKETYPE)
        arrView.append(lblxe)
        
        txtXeDangDung = MyTextField()
        txtXeDangDung.text = kh?.xedangdung
        arrView.append(txtXeDangDung)
        vertical = "\(vertical)[v\(i)(21)]-4-[v\(i+1)(30)]-20-"
        i += 2
        
        //Add giới tính
        let uvGender = UIView()
        arrView.append(uvGender)
        vertical = "\(vertical)[v\(i)(30)]-20-"
        i += 1
        
        if kh?.gioitinh == getTextUI(ui: UI.LBL_FEMALE) {
            gender = 0
        }
        
        let lblGender = MyLabel()
        lblGender.text = getTextUI(ui: UI.LBL_GENDER)
        let btnGender = UISegmentedControl()
        btnGender.insertSegment(withTitle: getTextUI(ui: UI.LBL_FEMALE), at: 0, animated: true)
        btnGender.insertSegment(withTitle: getTextUI(ui: UI.LBL_MALE), at: 1, animated: true)
        if kh?.gioitinh == getTextUI(ui: UI.LBL_MALE) {
            btnGender.selectedSegmentIndex = 1
        } else {
            btnGender.selectedSegmentIndex = 0
        }
        btnGender.addTarget(self, action: #selector(UpdateInfoController.chonGioiTinh(_:)), for: UIControlEvents.allEvents)
        
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
        txtTinh.text = kh?.tinh
        arrView.append(txtTinh)
        vertical = "\(vertical)[v\(i)(21)]-4-[v\(i+1)(30)]-20-"
        i += 2
        
        //Add Quận
        let lblquan = MyLabel()
        lblquan.text = getTextUI(ui: UI.LBL_DISTRICT)
        arrView.append(lblquan)
        
        txtQuan = MyTextField()
        txtQuan.text = kh?.quan
        arrView.append(txtQuan)
        vertical = "\(vertical)[v\(i)(21)]-4-[v\(i+1)(30)]-20-"
        i += 2
        
        //Add Phường
        let lblPhuong = MyLabel()
        lblPhuong.text = getTextUI(ui: UI.LBL_WARD)
        arrView.append(lblPhuong)
        
        txtPhuong = MyTextField()
        txtPhuong.text = kh?.phuong
        arrView.append(txtPhuong)
        vertical = "\(vertical)[v\(i)(21)]-4-[v\(i+1)(30)]-20-"
        i += 2
        
        //Add Số nhà
        let lblsonha = MyLabel()
        lblsonha.text = getTextUI(ui: UI.LBL_ADDRESS)
        arrView.append(lblsonha)
        
        txtSoNha = MyTextField()
        txtSoNha.text = kh?.sonha
        arrView.append(txtSoNha)
        
        vertical = "\(vertical)[v\(i)(21)]-4-[v\(i+1)(30)]-20-"
        i += 2
        
        //Add Điện thoại
        let lblPhone = MyLabel()
        lblPhone.text = getTextUI(ui: UI.LBL_PHONE)
        arrView.append(lblPhone)
        
        txtDienThoai = MyTextField()
        txtDienThoai.text = kh?.dienthoai
        txtDienThoai.keyboardType = UIKeyboardType.numberPad
        arrView.append(txtDienThoai)
        
        vertical = "\(vertical)[v\(i)(21)]-4-[v\(i+1)(30)]-20-"
        i += 2
        
        //Add button
        let btnUpdate:MyButton = MyButton()
        btnUpdate.setTitle(getTextUI(ui: UI.BTN_UPDATE), for: UIControlState.normal)
        arrView.append(btnUpdate)
        
        vertical = "\(vertical)[v\(i)(30)]-20-|"
        showLog(mess: arrView.count)
        showLog(mess: vertical)
        
        for view in arrView {
            uvForm.addSubview(view)
            uvForm.addContraintByVSF(VSF: "H:|-20-[v0]-20-|", views: view)
            if let textField = view as? MyTextField {
                textField.addTarget(self, action: #selector(RegisterController.nhapData(_:)), for: UIControlEvents.editingDidBegin)
            }
        }
        uvForm.addContraintByVSF(VSF: vertical, views: arrView)
        uvForm.addSubview(tblMain)
        
        btnUpdate.addTarget(self, action: #selector(UpdateInfoController.update), for: .touchUpInside)
    }
    func show(_ notification:NSNotification)
    {
        let valueKeyboard:NSValue = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        let sizeKeyboard:CGRect = valueKeyboard.cgRectValue
        khoangCach = 40 - sizeKeyboard.height
        showLog(mess: khoangCach)
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

    func nhapData(_ sender:MyTextField) {
        txtTam = sender
        var link:String = getLinkService(link: API.PROVINCE)
        switch sender {
        case txtTinh:
            
            break
        case txtQuan:
            if txtTinh.text == "" {
                showAlert(title: getAlertMessage(msg: ALERT.NOTICE), mess: getAlertMessage(msg: ALERT.CHOOSEPROVINCE))
                tblMain.isHidden = true
                txtQuan.text = ""
            } else {
                link = "\(link)/\(idTinh)"
            }
            break
        case txtPhuong:
            if txtTinh.text == "" || txtQuan.text == "" {
                showAlert(title: getAlertMessage(msg: ALERT.NOTICE), mess: getAlertMessage(msg: ALERT.CHOOSEDISTRICT))
                tblMain.isHidden = true
                txtPhuong.text = ""
            } else {
                link = "\(link)/\(idQuan)/edit"
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
    
    func chonGioiTinh(_ sender:UISegmentedControl) {
        gender = sender.selectedSegmentIndex
    }
    
    func update() {
        let checked:String = isEmptyTextField(txt: txtTen, txtDienThoai, txtTinh, txtQuan, txtPhuong, txtSoNha, txtXeDangDung)
        if  checked != "OK" {
            showAlert(title: getAlertMessage(msg: ALERT.ERROR), mess: checked)
        } else {
            var gioitinh = getTextUI(ui: UI.LBL_MALE)
            if gender == 0 {
                gioitinh = getTextUI(ui: UI.LBL_FEMALE)
            }
            var param = Dictionary<String,String>()
            param["ten"] = txtTen.text!
            param["dienthoai"] = txtDienThoai.text!
            param["xedangdung"] = txtXeDangDung.text!
            param["tinh"] = txtTinh.text!
            param["quan"] = txtQuan.text!
            param["phuong"] = txtPhuong.text!
            param["sonha"] = txtSoNha.text!
            param["gioitinh"] = gioitinh
            param["khachhang"] = "1"
            param["_method"] = "PUT"
            
            sendRequestToServer(linkAPI: API.REGISTER, param: param, method: Method.post, extraLink: "\(kh!.id)", completion: { (data) in
                if data?[getResultAPI(link: API.DATA_RES)] as! String == getResultAPI(link: API.RES_NOK) {
                    self.showAlert(title: getAlertMessage(msg: ALERT.ERROR), mess: getAlertMessage(msg: ALERT.ERRORSERVER))
                    self.txtTen.becomeFirstResponder()
                } else {
                    self.showAlertActionOK(title: getAlertMessage(msg: ALERT.NOTICE), mess: getAlertMessage(msg: ALERT.UPDATEOK), complete: {
                        let dic = data?[getResultAPI(link: API.DATA_RETURN)] as! Dictionary<String,Any>
                        kh = KhachHang(khachhang: dic)
                        if self.user.object(forKey: "email") != nil {
                            self.user.setValue(dic, forKey: "email")
                            self.user.synchronize()
                        }
                        let scr = TrangChuController()
                        self.navigationController?.pushViewController(scr, animated: true)
                    })
                    
                }

            })
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
            if txtTam == txtTinh {
                idTinh = arrDuLieu[indexPath.row].id
            } else {
                idQuan = arrDuLieu[indexPath.row].id
            }
            tblMain.isHidden = true
        } else {
            super.tableView(tableView, didSelectRowAt: indexPath)
        }
    }
    
}
