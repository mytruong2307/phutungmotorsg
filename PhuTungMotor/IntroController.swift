//
//  IntroController.swift
//  PhuTungMotor
//
//  Created by admin on 12/23/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class IntroController: UIViewController {

    var imgLogo:UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.MY_BG_COLOR
        imgLogo = UIImageView()
        view.addSubview(imgLogo)
        imgLogo.translatesAutoresizingMaskIntoConstraints = false
        imgLogo.image = #imageLiteral(resourceName: "logo")
        
        //autolayout
        imgLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imgLogo.centerYAnchor.constraint(lessThanOrEqualTo: view.centerYAnchor, constant: -70).isActive = true
        imgLogo.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        imgLogo.heightAnchor.constraint(equalTo: imgLogo.widthAnchor, multiplier: 1).isActive = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        imgLogo.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    }
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.imgLogo.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        self.perform(#selector(IntroController.GotoScreen), with: nil, afterDelay: 1.5)
    }
    
    func GotoScreen()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let nav = UINavigationController()
        nav.viewControllers = [HomeController()]
        appDelegate.window?.rootViewController = nav
        navigationController?.pushViewController(nav, animated: true)
    }
}
