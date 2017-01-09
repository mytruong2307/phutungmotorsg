//
//  AppStyle.swift
//  PhuTungMotor
//
//  Created by admin on 12/23/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
import UIKit

class MyButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = Constants.MY_TEXT_COLOR.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.layer.backgroundColor = UIColor(colorLiteralRed: 0.04 , green: 0.17, blue: 0.25, alpha: 1).cgColor
        self.tintColor = Constants.MY_TEXT_COLOR
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class MyTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont.systemFont(ofSize: 15)
        self.borderStyle = UITextBorderStyle.roundedRect
        self.autocorrectionType = UITextAutocorrectionType.no
        self.keyboardType = UIKeyboardType.default
        self.returnKeyType = UIReturnKeyType.done
        self.clearButtonMode = UITextFieldViewMode.whileEditing;
        self.contentVerticalAlignment = UIControlContentVerticalAlignment.center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class MyLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textColor = Constants.MY_TEXT_COLOR
        self.font = UIFont(name: "Hoefler Text", size: 15)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
