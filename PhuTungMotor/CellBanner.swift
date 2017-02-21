//
//  CellBanner.swift
//  PhuTungMotor
//
//  Created by admin on 2/10/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class CellBanner: BaseCollectCell {
    
    let lblPage:UILabel = {
        let v = UILabel()
        v.font = UIFont.boldSystemFont(ofSize: 21)
        v.textAlignment = .center
        v.backgroundColor = Constants.MY_BG_COLOR.withAlphaComponent(0.5)
        v.textColor = Constants.MY_TEXT_COLOR
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let imgBanner:UIImageView = {
        let v = UIImageView()
        v.image = #imageLiteral(resourceName: "logo")
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var link:String = ""
    var title:String = ""
    var image:UIImage = UIImage()
    
    override func setupView() {
        addViewFullScreen(views: imgBanner)
        imgBanner.addSubview(lblPage)
        lblPage.widthAnchor.constraint(equalTo: imgBanner.widthAnchor, multiplier: 1).isActive = true
        lblPage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        lblPage.bottomAnchor.constraint(equalTo: imgBanner.bottomAnchor).isActive = true
        lblPage.centerXAnchor.constraint(equalTo: imgBanner.centerXAnchor).isActive = true
        
    }
    
    override func setupData() {
        if link != "" {
            imgBanner.loadImageFromInternet(link: link)
        } else {
            self.imgBanner.image = image
        }
        lblPage.text = title
    }
}
