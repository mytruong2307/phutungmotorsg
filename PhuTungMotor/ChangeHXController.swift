//
//  ChangeHXController.swift
//  PhuTungMotor
//
//  Created by admin on 3/9/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class ChangeHXController: MenuAdminController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let lblTitle:UILabel = {
        let v = UILabel()
        v.font = UIFont(name: "Hoefler Text", size: 27)
        v.textColor = Constants.MY_TEXT_COLOR
        v.textAlignment = .center
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblTen:UILabel = {
        let v = UILabel()
        v.textColor = Constants.MY_TEXT_COLOR
        v.text = getTextUI(ui: UI.LBL_PRODUCTNAME)
        v.font = UIFont.italicSystemFont(ofSize: 14)
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
    
    
    let txtDTen:MyTextField = MyTextField()
    
    let imgHinh:UIImageView = {
        let v = UIImageView()
        v.clipsToBounds = true
        v.layer.cornerRadius = 5
        v.image = #imageLiteral(resourceName: "camera")
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let btnPost:MyButton = MyButton()
    var top:NSLayoutConstraint!
    var bottom:NSLayoutConstraint!
    var isHadPicture = false
    var isAddHangXe = true
    var hangxe = HangXe()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(ChangeHXController.show(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChangeHXController.hide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        setupView()
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
        uvForm.widthAnchor.constraint(equalTo: viewForScroll.widthAnchor, multiplier: 0.85).isActive = true
        center = uvForm.centerYAnchor.constraint(equalTo: viewForScroll.centerYAnchor)
        center.isActive = true
        top = uvForm.topAnchor.constraint(equalTo: viewForScroll.topAnchor, constant: 20)
        
        
        uvBackground.leftAnchor.constraint(equalTo: uvForm.leftAnchor).isActive = true
        uvBackground.topAnchor.constraint(equalTo: uvForm.topAnchor).isActive = true
        uvBackground.widthAnchor.constraint(equalTo: uvForm.widthAnchor).isActive = true
        uvBackground.heightAnchor.constraint(equalTo: uvForm.heightAnchor).isActive = true
        
        let HSL:String = "H:|-20-[v0]-20-|"
        uvForm.addSubview(views: lblTitle, imgHinh, lblTen, txtDTen, btnPost)
        
        imgHinh.heightAnchor.constraint(equalTo: imgHinh.widthAnchor, multiplier: 1).isActive = true
        
        
        uvForm.addContraintByVSF(VSF: HSL, views: lblTitle)
        uvForm.addContraintByVSF(VSF: HSL, views: imgHinh)
        uvForm.addContraintByVSF(VSF: HSL, views: lblTen)
        uvForm.addContraintByVSF(VSF: HSL, views: txtDTen)
        uvForm.addContraintByVSF(VSF: HSL, views: btnPost)
        
        uvForm.addContraintByVSF(VSF: "V:|[v0(70)][v1]-20-[v2]-4-[v3]-20-[v4]-20-|", views: lblTitle, imgHinh, lblTen, txtDTen, btnPost)
        
        if isAddHangXe {
            btnPost.setTitle(getTextUI(ui: UI.BTN_ADD), for: UIControlState.normal)
            lblTitle.text = getTextUI(ui: UI.LBL_ADDHANGXE)
        } else {
            btnPost.setTitle(getTextUI(ui: UI.BTN_UPDATE), for: UIControlState.normal)
            txtDTen.text = hangxe.ten
            let link = getLinkImage(link: API.HANGXE) + "/" + hangxe.hinh
            imgHinh.loadImageFromInternet(link: link)
            lblTitle.text = getTextUI(ui: UI.LBL_UPDATEHANGXE)
        }
        
        btnPost.addTarget(self, action: #selector(ChangeHXController.actionHangXe), for: UIControlEvents.touchUpInside)
        
        let ges:UITapGestureRecognizer = UITapGestureRecognizer()
        ges.numberOfTapsRequired = 1
        ges.numberOfTouchesRequired = 1
        imgHinh.isUserInteractionEnabled = true
        imgHinh.addGestureRecognizer(ges)
        ges.addTarget(self, action: #selector(ChangeHXController.chonHinh(_:)))
    }
    
    func chonHinh(_ sender:UITapGestureRecognizer)  {
        if sender.state == .ended {
            let picker:UIImagePickerController = UIImagePickerController()
            picker.delegate = self
            showAlert2Action(title: getAlertMessage(msg: .NOTICE), mess: getAlertMessage(msg: ALERT.CHONHINH), btnATitle: getAlertMessage(msg: ALERT.CHUP), btnBTitle: getAlertMessage(msg: ALERT.GALLERY), actionA: {
                if UIImagePickerController.isSourceTypeAvailable(.camera){
                    picker.sourceType = .camera
                    picker.allowsEditing = true
                    picker.cameraCaptureMode = .photo
                    picker.modalPresentationStyle = .fullScreen
                    self.present(picker, animated: true, completion: nil)
                } else {
                    self.showAlert(title: getAlertMessage(msg: ALERT.NOTICE), mess: getAlertMessage(msg: ALERT.NOCAMERA))
                    
                }
                
            }) {
                picker.sourceType = .photoLibrary
                picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: UIImagePickerControllerSourceType.photoLibrary)!
                picker.allowsEditing = false
                self.present(picker, animated: true, completion: nil)
            }
        }
        
    }
    
    func show(_ notification:NSNotification)
    {
        let valueKeyboard:NSValue = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        let sizeKeyboard:CGRect = valueKeyboard.cgRectValue
        let khoangcach = UIScreen.main.bounds.height - uvForm.frame.origin.y - uvForm.frame.height
        
        if khoangcach < sizeKeyboard.height {
            center.isActive = false
            bottom = uvForm.bottomAnchor.constraint(equalTo: viewForScroll.bottomAnchor, constant: -sizeKeyboard.height)
            bottom.isActive = true
            top.isActive = true
        }
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
    
    func mainAction(param:Dictionary<String,Any>)  {
        let check = isEmptyTextField(txt: txtDTen)
        if check == "OK" {
            let filename = txtDTen.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).replacingOccurrences(of: " ", with: "_")
            sendRequestAdmin(linkAPI: API.ADDHANGXE, param: param, method: Method.post, extraLink: nil, isLoading: true, filename: filename!, completion: { (object) in
                showLog(mess: object!)
                if let _ = object?[getResultAPI(link: API.DATA_RETURN)] as? Dictionary<String,Any> {
                    var mess = getAlertMessage(msg: ALERT.OKADD)
                    if !self.isAddHangXe {
                        mess = getAlertMessage(msg: ALERT.UPDATEOK)
                    }
                    self.showAlertActionOK(title: getAlertMessage(msg: ALERT.NOTICE), mess: mess, complete: {
                        let _ = self.navigationController?.popViewController(animated: true)
                    })
                } else {
                    let err = object?[getResultAPI(link: API.DATA_RETURN)] as! String
                    self.showAlert(title: getAlertMessage(msg: ALERT.ERROR), mess: err)
                }
            })
        } else {
            showAlert(title: getAlertMessage(msg: ALERT.ERROR), mess: getAlertMessage(msg: ALERT.EMPTYTEXTFIELD))
        }
    }
    
    func actionHangXe()  {
        var param = paramAdmin
        param["newToken"] = "1"
        param["truycap"] = "6"
        param["ten"] = txtDTen.text
        param["hinh"] = [imgHinh.image]
        if isAddHangXe {
            param["action"] = "add"
            if isHadPicture {
                mainAction(param: param)
            } else {
                showAlert(title: getAlertMessage(msg: ALERT.NOTICE), mess: getAlertMessage(msg: ALERT.NOPHOTO))
            }
        } else {
            param["action"] = "change"
            param["id"] = "\(hangxe.id)"
            param["doihinh"] = "0"
            if isHadPicture {
                // Co thay doi hinh
                param["doihinh"] = "1"
            }
            mainAction(param: param)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        isHadPicture = true
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            //Luu anh
            let hangxe = (txtDTen.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))! + ".jpg"
            let filename = fileInDocumentsDirectory(filename: hangxe)
            let _ = saveImage(image: image, path: filename)
            
            imgHinh.image = image
            dismiss(animated: true, completion: nil)
        } else if let hinh = info[UIImagePickerControllerEditedImage] as? UIImage
        {
            //Luu anh
            imgHinh.image = hinh
            dismiss(animated: true, completion: nil)
        }
        
    }
}
