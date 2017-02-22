//
//  ProductDetailController.swift
//  PhuTungMotor
//
//  Created by admin on 2/16/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class ProductDetailController: ProductController {
    
    var arrSanPham:Array<SanPham> = []
    var pos:Int = 0
    var width:CGFloat = 0
    var arrView:Array<Int> = []
    
    let page:UIPageControl = {
        let v = UIPageControl()
        v.currentPage = 0
        v.tintColor = UIColor.red
        v.pageIndicatorTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        v.currentPageIndicatorTintColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let scrImage:UIScrollView = {
        let v = UIScrollView()
        v.isPagingEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        return v
    }()
    
    let vBackground:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let vImage:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let vInfo:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblCode:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let lblMaSP:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = getTextUI(ui: UI.LBL_PRODUCTCODE)
        return v
    }()
    let lblName:UILabel = {
        let v = UILabel()
        v.textColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        v.numberOfLines = 2
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblTen:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = getTextUI(ui: UI.LBL_PRODUCTNAME)
        return v
    }()
    
    let lblPrice:UILabel = {
        let v = UILabel()
        v.textColor = Constants.MY_BG_COLOR
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let lblGiaBan:UILabel = {
        let v = UILabel()
        v.text = getTextUI(ui: UI.LBL_PRODUCTPRICE)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblBasePrice:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let lblGiaCu:UILabel = {
        let v = UILabel()
        v.text = getTextUI(ui: UI.LBL_PRODUCTBASEPRICE)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblTradeMark:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblThuongHieu:UILabel = {
        let v = UILabel()
        v.text = getTextUI(ui: UI.LBL_PRODUCTTRADEMARK)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblBikeKind:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblLoaiXe:UILabel = {
        let v = UILabel()
        v.text = getTextUI(ui: UI.LBL_BIKEKIND)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var btnShoppingCart:MyButton = MyButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnShoppingCart.setTitle(getTextUI(ui: UI.BTN_CART), for: UIControlState.normal)
        scrImage.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        arrView.append(pos)
        updateViewDB()
        width = vBackground.frame.width
        setupData()
        scrImage.addSubview(self.page)
        page.centerXAnchor.constraint(equalTo: scrImage.centerXAnchor).isActive = true
        page.bottomAnchor.constraint(equalTo: scrImage.bottomAnchor, constant: -20).isActive = true
    }
    
    override func addHomeIcon() {
        //Gan nut back
        self.navigationItem.rightBarButtonItems = [cartBtn]
    }
    
    override func setupColSanPham() {
        //Khong gan collection SanPham gan cac
        //Gan viewBackground
        let dis = 10
        let textHeight = 30
        let horVSF = "H:|-\(dis)-[v0(130)][v1]-\(dis)-|"
        let verVSF = "V:|[v0]-\(dis)-[v1(\(textHeight))]-\(dis)-[v2(\(textHeight))]-\(dis)-[v3(\(textHeight))]-\(dis)-[v4(\(textHeight))]-\(dis)-[v5(\(textHeight))]-\(dis)-[v6(\(textHeight))]"
        uvMain.addSubview(vBackground)
        vBackground.leftAnchor.constraint(equalTo: uvMain.leftAnchor, constant: 5).isActive = true
        vBackground.topAnchor.constraint(equalTo: uvMain.topAnchor, constant: 0).isActive = true
        vBackground.bottomAnchor.constraint(equalTo: uvLoaiXe.topAnchor, constant: 0).isActive = true
        vBackground.rightAnchor.constraint(equalTo: uvMain.rightAnchor, constant: -5).isActive = true
        
        //Gan Hinh va View chua thong tin
        vBackground.addSubview(vImage)
        vBackground.addSubview(vInfo)
        vBackground.addContraintByVSF(VSF: "H:|[v0]|", views: vImage)
        vBackground.addContraintByVSF(VSF: "H:|[v0]|", views: vInfo)
        vBackground.addContraintByVSF(VSF: "V:|[v0(250)]-30-[v1]|", views: vImage, vInfo)
        
        vImage.addViewFullScreen(views: scrImage)
        
        //Gan Thong tin san pham
        let vTen:UIView = UIView()
        vTen.translatesAutoresizingMaskIntoConstraints = false
        vInfo.addSubview(vTen)
        vInfo.addContraintByVSF(VSF: "H:|-10-[v0]-10-|", views: vTen)
        
        vTen.addSubview(lblTen)
        vTen.addSubview(lblName)
        vTen.addContraintByVSF(VSF: "H:|[v0(130)][v1]|", views: lblTen, lblName)
        vTen.addContraintByVSF(VSF: "V:|[v0]|", views: lblTen)
        vTen.addContraintByVSF(VSF: "V:|[v0]|", views: lblName)
        
        vInfo.addSubview(lblCode)
        vInfo.addSubview(lblPrice)
        vInfo.addSubview(lblBikeKind)
        vInfo.addSubview(lblBasePrice)
        vInfo.addSubview(lblTradeMark)
        vInfo.addSubview(btnShoppingCart)
        vInfo.addSubview(lblGiaCu)
        vInfo.addSubview(lblGiaBan)
        vInfo.addSubview(lblThuongHieu)
        vInfo.addSubview(lblLoaiXe)
        vInfo.addSubview(lblMaSP)
        
        vInfo.addContraintByVSF(VSF: horVSF, views: lblMaSP, lblCode)
        vInfo.addContraintByVSF(VSF: horVSF, views: lblLoaiXe, lblBikeKind)
        vInfo.addContraintByVSF(VSF: horVSF, views: lblThuongHieu, lblTradeMark)
        vInfo.addContraintByVSF(VSF: horVSF, views: lblGiaCu, lblBasePrice)
        vInfo.addContraintByVSF(VSF: horVSF, views: lblGiaBan, lblPrice)
        vInfo.addContraintByVSF(VSF: "H:|-10-[v0]-10-|", views: btnShoppingCart)
        
        vInfo.addContraintByVSF(VSF: verVSF, views: vTen, lblMaSP, lblLoaiXe, lblThuongHieu, lblGiaCu, lblGiaBan, btnShoppingCart)
        vInfo.addContraintByVSF(VSF: verVSF, views: vTen, lblCode, lblBikeKind, lblTradeMark, lblBasePrice, lblPrice, btnShoppingCart)
        
        setupGestureSanPham()
        
        btnShoppingCart.addTarget(self, action: #selector(ProductDetailController.buyProduct), for: UIControlEvents.touchUpInside)
    }
    
    func buyProduct() {
        var check = false
        if gioHang.count == 0 {
            //Animation
            animationCart(completed: {
                gioHang.append(GioHang(sanpham: self.arrSanPham[self.pos], soluong: 1 ))
                let _ = self.navigationController?.popViewController(animated: true)
            })
        } else {
            for (index,gh) in gioHang.enumerated() {
                if gh.sanpham.id == arrSanPham[pos].id {
                    showAlertAction(title: getAlertMessage(msg: ALERT.NOTICE), mess: getAlertMessage(msg: ALERT.ADDMOREPRODUCT), complete: {
                        gioHang[index].soluong += 1
                        self.animationCart(completed: {
                            let _ = self.navigationController?.popViewController(animated: true)
                        })
                    })
                    check = true
                    break
                }
            }
            if !check {
                animationCart(completed: {
                    gioHang.append(GioHang(sanpham: self.arrSanPham[self.pos], soluong: 1 ))
                    let _ = self.navigationController?.popViewController(animated: true)
                })
            }
            
        }
        
    }
    func setupData()  {
        showLog(mess: arrSanPham[pos])
        if pos >= 0 {
            lblName.text = arrSanPham[pos].ten
            lblCode.text = arrSanPham[pos].code
            lblBikeKind.text = arrSanPham[pos].loaixe
            lblTradeMark.text = arrSanPham[pos].hangxe
            lblPrice.text = showVNCurrency(gia: arrSanPham[pos].gia)
            lblBasePrice.attributedText = showPrice(sp: arrSanPham[pos])
            if arrSanPham[pos].hinh.count == 0 {
                downloadImageSanPham(sp: arrSanPham[pos], completion: { (image) in
                    showLog(mess: "Product Detail download them hinh")
                    self.arrSanPham[self.pos].hinh = image
                    self.setupScrImage()
                })
            } else {
                setupScrImage()
            }
        }
        if !arrView.contains(pos) {
            arrView.append(pos)
            updateViewDB()
        }
    }
    
    func setupScrImage() {
        var arrImgView:Array<UIImageView> = []
        var HSF = "H:|"
        for (index,image) in arrSanPham[pos].hinh.enumerated() {
            let img = UIImageView()
            img.translatesAutoresizingMaskIntoConstraints = false
            img.contentMode = .scaleToFill
            img.image = image
            scrImage.addSubview(img)
            scrImage.addContraintByVSF(VSF: "V:|[v0(250)]|", views: img)
            arrImgView.append(img)
            HSF += "[v\(index)(\(width))]"
        }
        HSF += "|"
        scrImage.addContraintByVSF(VSF: HSF, views: arrImgView)
        //Ađ Page Control
        let sohinh = arrSanPham[pos].hinh.count
        scrImage.addSubview(page)
        page.centerXAnchor.constraint(equalTo: vBackground.centerXAnchor).isActive = true
        page.bottomAnchor.constraint(equalTo: vInfo.topAnchor, constant: -20).isActive = true
        page.numberOfPages = sohinh
        scrImage.contentSize = CGSize(width: vBackground.frame.width * CGFloat (sohinh), height: 250)
        page.addTarget(self, action: #selector(ProductDetailController.changePage), for: UIControlEvents.valueChanged)
    }
    
    override func setupDataSanPham() {
        //Khong setup data san pham
    }
    
    func changePage()  {
        let x = CGFloat(page.currentPage) * width
        scrImage.setContentOffset(CGPoint(x: x,y :0), animated: true)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentX = scrollView.contentOffset.x
        let numberPage:Int = Int(contentX / width)
        page.currentPage = numberPage
    }
    
    func setupGestureSanPham() {
        let nextGesture:UISwipeGestureRecognizer = UISwipeGestureRecognizer()
        let previousGesture:UISwipeGestureRecognizer = UISwipeGestureRecognizer()
        previousGesture.direction = .right
        nextGesture.direction = .left
        vInfo.addGestureRecognizer(nextGesture)
        vInfo.addGestureRecognizer(previousGesture)
        nextGesture.addTarget(self, action: #selector(ProductDetailController.nextSanPham))
        previousGesture.addTarget(self, action: #selector(ProductDetailController.previousSanPham))
    }
    
    func nextSanPham()  {
        pos += 1
        if pos >= arrSanPham.count {
            pos = 0
        }
        setupData()       
    }
    func previousSanPham() {
        pos -= 1
        if pos < 0 {
            pos = arrSanPham.count - 1
        }
        setupData()
    }
    func animationCart(completed: @escaping () -> ())  {
        let imgTran:UIImageView = UIImageView()
        imgTran.contentMode = .scaleToFill
        imgTran.image = self.arrSanPham[self.pos].hinh[page.currentPage]
        imgTran.translatesAutoresizingMaskIntoConstraints = false
        imgTran.clipsToBounds = true
        imgTran.layer.borderWidth = 1
        imgTran.layer.cornerRadius = 25
        self.view.addSubview(imgTran)
        
        imgTran.centerXAnchor.constraint(equalTo: self.btnShoppingCart.centerXAnchor, constant: 0).isActive = true
        imgTran.centerYAnchor.constraint(equalTo: self.btnShoppingCart.centerYAnchor, constant: 0).isActive = true
        imgTran.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imgTran.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let x = self.view.frame.width / 2 - 30
        let y = self.btnShoppingCart.frame.origin.y + self.vInfo.frame.origin.y + 32
        
        showLog(mess: "\(x) & \(y)")
        let dest = CATransform3DTranslate(CATransform3DIdentity, x, -y, 0)
        let scale = CATransform3DScale(dest, 0.5, 0.5, 0)
        
        UIView.animate(withDuration: 1, animations: {
            imgTran.layer.transform = dest
        }, completion: { (true) in
            UIView.animate(withDuration: 0.5, animations: {
                imgTran.layer.transform = scale
            }, completion: { (true) in
                imgTran.removeFromSuperview()
                //Them vao gio hang
                completed()
            })
            
        })
    }
    
    func updateViewDB()  {
        sendRequestNoLoading(linkAPI: API.UPDATEVIEW, param: nil, method: Method.get, extraLink: "\(arrSanPham[pos].id)") { (object) in
            showLog(mess: object!)
        }
    }
    func animtionBuyProduct(completed:@escaping () -> ())  {
        let imgTran:UIImageView = UIImageView()
        imgTran.contentMode = .scaleToFill
        imgTran.image = self.arrSanPham[self.pos].hinh[0]
        imgTran.translatesAutoresizingMaskIntoConstraints = false
        imgTran.clipsToBounds = true
        self.view.addSubview(imgTran)
        
        imgTran.centerXAnchor.constraint(equalTo: self.vBackground.centerXAnchor, constant: 0).isActive = true
        imgTran.centerYAnchor.constraint(equalTo: self.vBackground.centerYAnchor, constant: 0).isActive = true
        imgTran.widthAnchor.constraint(equalTo: self.vBackground.widthAnchor, multiplier: 1).isActive = true
        imgTran.heightAnchor.constraint(equalTo: self.vBackground.heightAnchor, multiplier: 1).isActive = true
        
        let x = self.view.frame.width / 2 - 30
        let y = self.btnShoppingCart.frame.origin.y + self.vInfo.frame.origin.y + 32
        
        showLog(mess: "\(x) & \(y)")
        
        let scale = CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 0)
        let dest = CATransform3DTranslate(scale, x, -y, 0)
        
        UIView.animate(withDuration: 1, animations: {
            imgTran.layer.transform = scale
        }, completion: { (true) in
            UIView.animate(withDuration: 0.5, animations: {
                imgTran.layer.transform = dest
            }, completion: { (true) in
                imgTran.removeFromSuperview()
                //Them vao gio hang
                completed()
            })
            
        })
    }
}


