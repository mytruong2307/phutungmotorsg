//
//  BaseCollReusableView.swift
//  PhuTungMotor
//
//  Created by admin on 2/19/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class BaseCollReusableView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView()  {
        
    }
    
    override func layoutSubviews() {
        setupData()
    }
    
    func setupData() {
        
    }
}
