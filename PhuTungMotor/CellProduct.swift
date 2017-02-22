//
//  CellProduct.swift
//  PhuTungMotor
//
//  Created by admin on 2/21/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class CellProduct: BaseCollectCell, UIScrollViewDelegate {
    
    var gioHang:GioHang = GioHang()
    var pos:Int = 0
    let imgHinh:UIImageView = {
        let v = UIImageView()
        v.image = #imageLiteral(resourceName: "logo")
        v.contentMode = .center
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let act:UIActivityIndicatorView = {
        let v = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        v.color = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
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
        return v
    }()
    
    let vGia:UIView = {
        let v = UIView()
        v.backgroundColor = Constants.MY_BG_COLOR
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    
    let vHinh:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let vText:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let lblCode:UILabel = {
        let v = UILabel()
        v.font = UIFont.systemFont(ofSize: 14)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let lblMaSP:UILabel = {
        let v = UILabel()
        v.font = UIFont.systemFont(ofSize: 14)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = getTextUI(ui: UI.LBL_PRODUCTCODE)
        return v
    }()
    let lblName:UILabel = {
        let v = UILabel()
        v.font = UIFont.systemFont(ofSize: 14)
        v.textColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        v.numberOfLines = 2
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblTen:UILabel = {
        let v = UILabel()
        v.font = UIFont.systemFont(ofSize: 14)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = getTextUI(ui: UI.LBL_PRODUCTNAME)
        return v
    }()
    
    let lblPrice:UILabel = {
        let v = UILabel()
        v.textAlignment = .center
        v.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblSoLuong:UILabel = {
        let v = UILabel()
        v.textAlignment = .center
        v.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let lblVNhan:UILabel = {
        let v = UILabel()
        v.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        v.text = getTextUI(ui: UI.LBL_NHAN)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let lblVBang:UILabel = {
        let v = UILabel()
        v.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        v.text = getTextUI(ui: UI.LBL_BANG)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblTradeMark:UILabel = {
        let v = UILabel()
        v.font = UIFont.systemFont(ofSize: 14)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblThanhTien:UILabel = {
        let v = UILabel()
        v.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        v.textAlignment = .center
        v.font = UIFont.boldSystemFont(ofSize: 17)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblThuongHieu:UILabel = {
        let v = UILabel()
        v.font = UIFont.systemFont(ofSize: 14)
        v.text = getTextUI(ui: UI.LBL_PRODUCTTRADEMARK)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblBikeKind:UILabel = {
        let v = UILabel()
        v.font = UIFont.systemFont(ofSize: 14)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    
    
    let lblLoaiXe:UILabel = {
        let v = UILabel()
        v.font = UIFont.systemFont(ofSize: 14)
        v.text = getTextUI(ui: UI.LBL_BIKEKIND)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func setupView() {
        addSubview(vHinh)
        addSubview(vText)
        addSubview(vGia)
        
        vHinh.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        addContraintByVSF(VSF: "H:|[v0]|", views: vHinh)
        addContraintByVSF(VSF: "H:|[v0]|", views: vText)
        addContraintByVSF(VSF: "H:|[v0]|", views: vGia)
        addContraintByVSF(VSF: "V:|[v0]-5-[v1]-5-[v2]|", views: vHinh, vText, vGia)
        
        vHinh.addViewFullScreen(views: imgHinh)
        imgHinh.addSubview(act)
        act.centerXAnchor.constraint(equalTo: imgHinh.centerXAnchor).isActive = true
        act.centerYAnchor.constraint(equalTo: imgHinh.centerYAnchor).isActive = true
        
        act.startAnimating()
        vHinh.addViewFullScreen(views: scrImage)
        
        vText.addSubview(lblTen)
        vText.addSubview(lblMaSP)
        vText.addSubview(lblCode)
        vText.addSubview(lblName)
        vText.addSubview(lblBikeKind)
        vText.addSubview(lblLoaiXe)
        vText.addSubview(lblThuongHieu)
        vText.addSubview(lblTradeMark)
        
        let VSF:String = "V:|[v0][v1]|"
        let HSF:String = "H:|[v0(40)][v1]-10-[v2(70)][v3(70)]|"
        
        vText.addContraintByVSF(VSF: VSF, views: lblTen,  lblMaSP)
        vText.addContraintByVSF(VSF: VSF, views: lblName, lblCode)
        vText.addContraintByVSF(VSF: VSF, views: lblLoaiXe, lblThuongHieu)
        vText.addContraintByVSF(VSF: VSF, views: lblBikeKind , lblTradeMark)
        
        vText.addContraintByVSF(VSF: HSF, views: lblTen, lblName, lblLoaiXe, lblBikeKind)
        vText.addContraintByVSF(VSF: HSF, views: lblMaSP, lblCode, lblThuongHieu, lblTradeMark)
        
        vGia.addSubview(lblPrice)
        vGia.addSubview(lblVNhan)
        vGia.addSubview(lblSoLuong)
        vGia.addSubview(lblVBang)
        vGia.addSubview(lblThanhTien)
        
        vGia.addContraintByVSF(VSF: "H:|-10-[v0(100)]-5-[v1(20)]-5-[v2(50)]-5-[v3(20)][v4]|", views: lblPrice, lblVNhan, lblSoLuong, lblVBang, lblThanhTien)
        
        vGia.addContraintByVSF(VSF: "V:|[v0]|", views: lblPrice)
        vGia.addContraintByVSF(VSF: "V:|[v0]|", views: lblVNhan)
        vGia.addContraintByVSF(VSF: "V:|[v0]|", views: lblSoLuong)
        vGia.addContraintByVSF(VSF: "V:|[v0]|", views: lblVBang)
        vGia.addContraintByVSF(VSF: "V:|[v0]|", views: lblThanhTien)
        
        scrImage.delegate = self
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentX = scrollView.contentOffset.x
        let numberPage:Int = Int(contentX / vHinh.frame.width)
        page.currentPage = numberPage
    }
    func setupScrImage() {
        var arrImgView:Array<UIImageView> = []
        var HSF = "H:|"
        for (index,image) in gioHang.sanpham.hinh.enumerated() {
            let img = UIImageView()
            img.translatesAutoresizingMaskIntoConstraints = false
            img.contentMode = .scaleToFill
            img.image = image
            scrImage.addSubview(img)
            img.widthAnchor.constraint(equalTo: vHinh.widthAnchor, multiplier: 1).isActive = true
            img.heightAnchor.constraint(equalTo: vHinh.heightAnchor, multiplier: 1).isActive = true
            scrImage.addContraintByVSF(VSF: "V:|[v0]|", views: img)
            arrImgView.append(img)
            HSF += "[v\(index)]"
        }
        HSF += "|"
        showLog(mess: HSF)
        scrImage.addContraintByVSF(VSF: HSF, views: arrImgView)
        //Ađ Page Control
        let sohinh = gioHang.sanpham.hinh.count
        scrImage.addSubview(page)
        page.centerXAnchor.constraint(equalTo: vHinh.centerXAnchor).isActive = true
        page.bottomAnchor.constraint(equalTo: vHinh.bottomAnchor, constant: 10).isActive = true
        page.numberOfPages = sohinh
        scrImage.contentSize = CGSize(width: vHinh.frame.width * CGFloat (sohinh), height: 250)
        page.addTarget(self, action: #selector(CellProduct.changePage), for: UIControlEvents.valueChanged)
    }

    func changePage()  {
        let x = CGFloat(page.currentPage) * vHinh.frame.width
        scrImage.setContentOffset(CGPoint(x: x,y :0), animated: true)
    }
    
    override func setupData() {
        lblName.text = gioHang.sanpham.ten
        lblPrice.text = showVNCurrency(gia: gioHang.sanpham.gia)
        lblTradeMark.text = gioHang.sanpham.hangxe
        lblBikeKind.text = gioHang.sanpham.loaixe
        lblCode.text = gioHang.sanpham.code
        lblSoLuong.text = String (gioHang.soluong)
        lblThanhTien.text = showVNCurrency(gia: gioHang.sanpham.gia * Double (gioHang.soluong))
        if gioHang.sanpham.hinh.count > 0 {
            act.stopAnimating()
            act.removeFromSuperview()
            imgHinh.removeFromSuperview()
            setupScrImage()
        }
    }
    
}
