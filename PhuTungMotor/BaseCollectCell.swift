//
//  BaseCollectCell.swift
//  PhuTungMotor
//
//  Created by admin on 1/2/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class BaseCollectCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        setupView()
    }
    
    override func layoutSubviews() {
        setupData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView() {
        
    }
    func setupData() {
        
    }
}
