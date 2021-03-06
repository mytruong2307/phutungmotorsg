//
//  TinTucDetailController.swift
//  PhuTungMotor
//
//  Created by admin on 1/3/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class TinTucDetailController: BaseController {
    
    let wv:UIWebView = {
        let v = UIWebView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var tintuc:TinTuc = TinTuc()
    var linkHinh:String = ""
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
    
    override func setupBackground() {
        //Huy background
    }
    
    override func addHomeIcon() {
        //Huy home menu
    }
    
    override func addForm() {
        //Huy form
    }
    
    func setupData() {
        var noidung:String = tintuc.noidung
        if ip != "" {
            noidung = noidung.replacingOccurrences(of: "localhost", with: ip) //Su dung cho localhost
        } else {
            noidung = noidung.replacingOccurrences(of: "localhost", with: domain) //Su dung cho
        }
        //Dua title vao html
        let title = "<h3 style = 'color:#134267'>" + tintuc.tieude + " (" +  tintuc.created_at.getDate() + ")</h3>"
        //Kich thuoc chuan cua hinh
        let sizeImage = "style='width:\(view.frame.width - 15)px;height:\(view.frame.width * 0.8)px'"
        let img = "<img src = '" + linkHinh + "/" + tintuc.hinhtin + "' \(sizeImage)/>"
        let tacgia = "<p style = 'float:right; color:#4a0602;'>" + tintuc.nguoiviet + "</p>"
        noidung = title + img + noidung + tacgia
        //Thay doi kich thuoc cho tat ca cac hinh
        while let tem = getSubString(str: noidung, findStart: "style=\"height", findEnd: "px\"") {
            noidung = noidung.replacingOccurrences(of: tem, with: sizeImage)
        }
        //Doi dau " thanh ' de hien hinh
        noidung = noidung.replacingOccurrences(of: "\"", with: "'")
        wv.loadHTMLString(noidung, baseURL: nil)
    }
}
