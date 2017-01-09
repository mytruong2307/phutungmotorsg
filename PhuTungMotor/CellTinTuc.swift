//
//  CellTinTuc.swift
//  PhuTungMotor
//
//  Created by admin on 1/2/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class CellTinTuc: BaseCollectCell {
    
    let uvBackground:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let imgHinh:UIImageView = {
        let v = UIImageView()
        v.image = #imageLiteral(resourceName: "logo")
        v.contentMode = .scaleToFill
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblTieuDe:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        v.font = UIFont.boldSystemFont(ofSize: 15)
        v.numberOfLines = 0
        return v
    }()
    
    let lblTomTat:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.numberOfLines = 3
        v.font = UIFont.italicSystemFont(ofSize: 14)
        return v
    }()
    
    let lblTacGia:UILabel = {
        let v = UILabel()
        v.font = UIFont.italicSystemFont(ofSize: 14)
        v.textColor = Constants.MY_BG_COLOR
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let lblDate:UILabel = {
        let v = UILabel()
        v.font = UIFont.systemFont(ofSize: 14)
        v.textAlignment = .right
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let uvInfo:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var tintuc:TinTuc!
    var linkHinh:String = ""
    
    override func setupView() {
        addSubview(uvBackground)
        addContraintByVSF(VSF: "H:|-5-[v0]-5-|", views: uvBackground)
        addContraintByVSF(VSF: "V:|-5-[v0]-5-|", views: uvBackground)
        
        uvBackground.addSubview(lblTieuDe)
        uvBackground.addSubview(imgHinh)
        uvBackground.addSubview(lblTomTat)
        uvBackground.addSubview(lblTacGia)
        uvBackground.addSubview(lblDate)
        
        imgHinh.widthAnchor.constraint(equalTo: uvBackground.widthAnchor, multiplier: 1).isActive = true
        imgHinh.heightAnchor.constraint(equalTo: uvBackground.widthAnchor, multiplier: 0.8).isActive = true
        
        uvBackground.addContraintByVSF(VSF: "H:|[v0]|", views: lblTieuDe)
        uvBackground.addContraintByVSF(VSF: "H:|[v0]|", views: imgHinh)
        uvBackground.addContraintByVSF(VSF: "H:|[v0]|", views: lblTomTat)
        uvBackground.addContraintByVSF(VSF: "H:|[v0]|", views: lblTacGia)
        uvBackground.addContraintByVSF(VSF: "H:|[v0]|", views: lblDate)
        uvBackground.addContraintByVSF(VSF: "V:|[v0]-4-[v1]-4-[v2]-4-[v3]-4-[v4]|", views: lblTieuDe, imgHinh, lblTomTat, lblTacGia, lblDate)

    }
    
    override func setupData() {
        let link:String = "\(linkHinh)/\(tintuc.hinhtin)"
        imgHinh.loadImageFromInternet(link: link)
        lblTieuDe.text = tintuc.tieude
        lblTomTat.text = tintuc.tomtat
        lblTacGia.text = tintuc.nguoiviet
        lblDate.text = tintuc.created_at
    }
    
}
