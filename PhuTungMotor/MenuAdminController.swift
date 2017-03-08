//
//  MenuAdminController.swift
//  PhuTungMotor
//
//  Created by admin on 2/24/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class MenuAdminController: BaseController {
    
    let col:UICollectionView = {
        let scrDirection = UICollectionViewFlowLayout()
        scrDirection.scrollDirection = .vertical
        let v = UICollectionView(frame: CGRect.zero, collectionViewLayout: scrDirection)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if kh == nil || kh?.quyen.count == 0 {
            let _ = navigationController?.popToRootViewController(animated: true)
        }
    }
    
    override func setupDataMenu() {        
        cartBtn.image = #imageLiteral(resourceName: "donhang")
        arrMenu = [["Đăng xuất","Đổi mật khẩu","Cập nhật thông tin"]]
        arrIcon = [[#imageLiteral(resourceName: "Logout"),#imageLiteral(resourceName: "key"),#imageLiteral(resourceName: "Contacts")]]
        var arrImage:Array<UIImage> = []
        for per in (kh?.quyen)! {
            switch per {
            case "Kết Quả":
                arrImage.append(#imageLiteral(resourceName: "ketqua"))
                break
            case "Hỏi đáp":
                arrImage.append(#imageLiteral(resourceName: "faq"))
                break
            case "Tài khoản":
                arrImage.append(#imageLiteral(resourceName: "account"))
                break
            case "Tin tức":
                arrImage.append(#imageLiteral(resourceName: "new"))
                break
            case "Doanh nghiệp":
                arrImage.append(#imageLiteral(resourceName: "doanhnghiep"))
                break
            case "Hãng xe":
                arrImage.append(#imageLiteral(resourceName: "hangxe"))
                break
            case "Loại xe":
                arrImage.append(#imageLiteral(resourceName: "loaixe"))
                break
            case "Sản phẩm":
                arrImage.append(#imageLiteral(resourceName: "sanpham"))
                break
            case "Đơn hàng":
                arrImage.append(#imageLiteral(resourceName: "donhang"))
                break
            case "Slider":
                arrImage.append(#imageLiteral(resourceName: "slider"))
                break
            default:
                arrImage.append(#imageLiteral(resourceName: "mail"))
                break
            }
        }
        arrMenu.append((kh?.quyen)!)
        arrIcon.append(arrImage)
        tbl.reloadData()
    }
    override func addHomeIcon() {
        let leftmenu = UIBarButtonItem(image: #imageLiteral(resourceName: "Menu Filled-50"), style: .plain, target: self, action: #selector(BaseController.openMenu))

        self.navigationItem.leftBarButtonItem = leftmenu
    }
    
    override func addMenuIcon() {
        //Bo cart
        let searchBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "search"), style: .plain, target: self, action: #selector(BaseController.search))
        let right = UIBarButtonItem(image: #imageLiteral(resourceName: "add"), style: .plain, target: self, action: #selector(MenuAdminController.them))
        self.navigationItem.rightBarButtonItems = [right, searchBtn]
    }
    
    func them() {
        
    }
    func changePer(per:Permission) {
        switch per.ten {
        case "Kết Quả":
            
            break
        case "Hỏi đáp":
            navigationController?.pushViewController(HoiDapAdController(), animated: true)
            break
        case "Tài khoản":
            showAlert2Action(title: getAlertMessage(msg: ALERT.NOTICE), mess: getAlertMessage(msg: ALERT.CHOOSEACCOUNT), btnATitle: getAlertMessage(msg: ALERT.NHANVIEN), btnBTitle: getAlertMessage(msg: ALERT.KHACHHANG), actionA: { 
                self.navigationController?.pushViewController(TaiKhoanController(), animated: true)
            }, actionB: {
                let scr = TaiKhoanController()
                scr.isEmployee = false
                self.navigationController?.pushViewController(scr, animated: true)
            })
            break
        case "Tin tức":
            
            break
        case "Doanh nghiệp":
            navigationController?.pushViewController(SuaDNController(), animated: true)
            break
        case "Hãng xe":
            
            break
        case "Loại xe":
            
            break
        case "Sản phẩm":
            
            break
        case "Đơn hàng":
            
            break
        case "Slider":
            
            break
        default:
            
            break
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            super.tableView(tableView, didSelectRowAt: indexPath)
        } else {
            var per:Permission = Permission()
            per.ten = arrMenu[indexPath.section][indexPath.row]
            changePer(per: per)
        }
    }
}
