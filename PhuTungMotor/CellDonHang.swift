//
//  CellDonHang.swift
//  PhuTungMotor
//
//  Created by admin on 2/20/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class CellDonHang: BaseCollectCell {
    
    let vDonHang:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblDonHangId:UILabel = {
        let v = UILabel()
        v.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = getTextUI(ui: UI.LBL_DONHANGNO)
        v.font = UIFont.boldSystemFont(ofSize: 17)
        return v
    }()
    
    let lblCreatedAt:UILabel = {
        let v = UILabel()
        v.text = getTextUI(ui: UI.LBL_CREATEDAT)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let lblTrangThai:UILabel = {
        let v = UILabel()
        v.text = getTextUI(ui: UI.LBL_TRANGTHAI)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblCachThanhToan:UILabel = {
        let v = UILabel()
        v.text = getTextUI(ui: UI.LBL_CACHTHANHTOAN)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblThanhToan:UILabel = {
        let v = UILabel()
        v.text = getTextUI(ui: UI.LBL_THANHTOAN)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblTongTien:UILabel = {
        let v = UILabel()
        v.text = getTextUI(ui: UI.LBL_TONGTIEN)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblDataDonHangId:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        v.font = UIFont.boldSystemFont(ofSize: 17)
        return v
    }()
    
    let lblDataCreatedAt:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblDataTrangThai:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblDataCachThanhToan:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblDataThanhToan:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblDataTongTien:UILabel = {
        let v = UILabel()
        v.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        v.font = UIFont.boldSystemFont(ofSize: 17)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let btnXemChiTiet:UIButton = {
        let v = UIButton()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setTitle(getTextUI(ui: UI.BTN_DETAIL), for: UIControlState.normal)
        v.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: UIControlState.normal)
        v.setTitleColor(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1), for: UIControlState.highlighted)
        return v
    }()

    var donhang:DonHang = DonHang()
    
    override func setupView() {
        
        let VSL:String = "V:|[v0]-5-[v1]-5-[v2]-5-[v3]-5-[v4]-5-[v5]|"
        let HSL:String = "H:|-5-[v0(150)][v1]-5-|"

        addSubview(vDonHang)
        addSubview(lblTongTien)
        addSubview(lblCreatedAt)
        addSubview(lblThanhToan)
        addSubview(lblTrangThai)
        addSubview(lblCachThanhToan)
        addSubview(lblDataTongTien)
        addSubview(lblDataCreatedAt)
        addSubview(lblDataThanhToan)
        addSubview(lblDataTrangThai)
        addSubview(lblDataCachThanhToan)
        
        addContraintByVSF(VSF: "H:|[v0]|", views: vDonHang)
        addContraintByVSF(VSF: HSL, views: lblCreatedAt, lblDataCreatedAt)
        addContraintByVSF(VSF: HSL, views: lblTrangThai, lblDataTrangThai)
        addContraintByVSF(VSF: HSL, views: lblCachThanhToan, lblDataCachThanhToan)
        addContraintByVSF(VSF: HSL, views: lblThanhToan, lblDataThanhToan)
        addContraintByVSF(VSF: HSL, views: lblTongTien, lblDataTongTien)
        
        addContraintByVSF(VSF: VSL, views: vDonHang, lblCreatedAt, lblTrangThai, lblCachThanhToan, lblThanhToan, lblTongTien)
        addContraintByVSF(VSF: VSL, views: vDonHang, lblDataCreatedAt, lblDataTrangThai, lblDataCachThanhToan, lblDataThanhToan, lblDataTongTien)
        
        //Setup view Don hang
        vDonHang.addSubview(lblDonHangId)
        vDonHang.addSubview(lblDataDonHangId)
        vDonHang.addSubview(btnXemChiTiet)
        
        vDonHang.addContraintByVSF(VSF: "H:|-5-[v0(150)][v1][v2(150)]-5-|", views: lblDonHangId, lblDataDonHangId,btnXemChiTiet)
        vDonHang.addContraintByVSF(VSF: "V:|[v0]|", views: lblDonHangId)
        vDonHang.addContraintByVSF(VSF: "V:|[v0]|", views: lblDataDonHangId)
        vDonHang.addContraintByVSF(VSF: "V:|[v0]|", views: btnXemChiTiet)
        
        //Setup hanh dong khi nhan nut xem chi tiet
        btnXemChiTiet.addTarget(self, action: #selector(CellDonHang.xemChiTiet), for: UIControlEvents.touchUpInside)
        
    }
    
    func xemChiTiet()  {
        NotificationCenter.default.post(name: NSNotification.Name.init("viewDetail"), object: donhang)
    }
    
    override func setupData() {
        lblDataDonHangId.text = String (donhang.id)
        lblDataCreatedAt.text = convertDateFromMySQL(strFromMySql: donhang.createdAt)
        lblDataTongTien.text = showVNCurrency(gia: donhang.tongtien)
        if donhang.cachthanhtoan == 0 {
            lblDataCachThanhToan.text = getTextUI(ui: UI.LBL_TIENMAT)
        } else {
            lblDataCachThanhToan.text = getTextUI(ui: UI.LBL_CHUYENKHOAN)
        }
        if donhang.thanhtoan == 0 {
            lblDataThanhToan.text = getTextUI(ui: UI.LBL_CHUATT)
        } else {
            lblDataThanhToan.text = getTextUI(ui: UI.LBL_DATT)
        }
        switch donhang.trangthai {
        case 0:
            lblDataTrangThai.text = getTextUI(ui: UI.LBL_CHUAXN)
            break
        case 1:
            lblDataTrangThai.text = getTextUI(ui: UI.LBL_DAXN)
            break
        case 2:
            lblDataTrangThai.text = getTextUI(ui: UI.LBL_VANCHUYEN)
            break
        case 3:
            lblDataTrangThai.text = getTextUI(ui: UI.LBL_HUY)
            break
        default:
            lblDataTrangThai.text = getTextUI(ui: UI.LBL_HOANTHANH)
        }
    }
}
