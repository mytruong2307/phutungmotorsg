//
//  HoiDapDetailController.swift
//  PhuTungMotor
//
//  Created by admin on 1/6/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class HoiDapDetailController: BaseController {
    
    let wv:UIWebView = {
        let v = UIWebView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var hoidap:HoiDap = HoiDap()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupData()
    }
    
    func setupView() {
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        //add webview
        uvMain.addViewFullScreen(views: wv)
    }
    
    func setupData() {
        //Dua title vao html
        let nguoihoi = "<h3 style = 'color:#134267'>Khách hàng: " + hoidap.ten + "</h3>"
        //Kich thuoc chuan cua hinh
        let sizeImage = "style='width:\(view.frame.width - 15)px;height:\(view.frame.width * 0.8)px'"
        let ngayhoi = "<p style = 'float:right; color:#4a0602;'>" + hoidap.created_at.getDate() + "</p><br style = 'clear:both'>"
        var noidung = nguoihoi +  "<p>" + hoidap.cauhoi + "</p>" + ngayhoi
        if hoidap.cautraloi != "" {
            noidung += "<p>" + hoidap.cautraloi + "</p>"
        } else {
            noidung += "<p>" + hoidap.tomtat + "</p>"
        }
        if ip != "" {
            noidung = noidung.replacingOccurrences(of: "localhost", with: ip) //Su dung cho localhost
        } else {
            noidung = noidung.replacingOccurrences(of: "localhost", with: domain)
        }
        //Thay doi kich thuoc cho tat ca cac hinh
        while let tem = getSubString(str: noidung, findStart: "style=\"height", findEnd: "px\"") {
            noidung = noidung.replacingOccurrences(of: tem, with: sizeImage)
        }
        //Doi dau " thanh ' de hien hinh
        noidung = noidung.replacingOccurrences(of: "\"", with: "'")
        wv.loadHTMLString(noidung, baseURL: nil)
    }
    
    override func setupBackground() {
        //Huy background
    }
    
    override func addHomeIcon() {
        //Huy home menu
    }
    
    override func addForm() {
        //Huy form
    }
    
    
}
