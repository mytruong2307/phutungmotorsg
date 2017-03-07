//
//  TaiKhoanController.swift
//  PhuTungMotor
//
//  Created by admin on 3/4/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class TaiKhoanController: MenuAdminController {
    
    var arrNhanVien:Array<NhanVien> = []
    var isEmployee = true
    var item = 2
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector:  #selector(TaiKhoanController.activeAccount), name: NSNotification.Name.init("activeAccount"), object: nil)
        setupDataCol()
        col.delegate = self
        col.dataSource = self
        col.register(CellTaiKhoan.self, forCellWithReuseIdentifier: "CellTaiKhoan")
        col.register(CellBanner.self, forCellWithReuseIdentifier: "CellBanner")
    }
    
    
    func activeAccount(object:Notification)  {
        let nv = object.object as! NhanVien
        let link = getLinkAdminSer(link: API.ACTIVE) + "/\(nv.id)/\(nv.tinhtrang)"
        sendRequestAdmin(linkAPI: link) { (object) in
            let data = object?["data"] as! Dictionary<String,Any>
            let state = data["tinhtrang"] as! Int
            var mess = ""
            if state == 0 {
                mess = getAlertMessage(msg: ALERT.DEACTIVEOK)
            } else {
                mess = getAlertMessage(msg: ALERT.ACTIVEOK)
            }
            mess += data["email"] as! String
            self.showAlert(title: getAlertMessage(msg: ALERT.NOTICE), mess: mess)
        }
    }
    override func setupBackground() {
        //Huy background
    }
    
    override func addHomeIcon() {
        //Gan nut back
    }
    override func addForm() {
        uvMain.addViewFullScreen(views: col)
        //        uvMain.addSubview(col)
        //        uvMain.addContraintByVSF(VSF: "H:|-10-[v0]-10-|", views: col)
        //        uvMain.addContraintByVSF(VSF: "V:|[v0]|", views: col)
    }
    
    func setupDataCol()  {
        paramAdmin["truycap"] = "2"
        if isEmployee {
            let link = getLinkAdminSer(link: API.NHANVIEN) + "/\(item)/\(page)"
            sendRequestAdmin(linkAPI: link, completion: { (object) in
                if let data = object?[getResultAPI(link: API.DATA_RETURN)] as? Array<Dictionary<String,Any>>
                {
                    for nv in data {
                        self.arrNhanVien.append(NhanVien(dic: nv))
                        showLog(mess: self.arrNhanVien)
                    }
                    self.page += 1
                    self.col.reloadData()
                } else {
                    self.page = -1
                }
            })
        } else {
            item = 3
            let link = getLinkAdminSer(link: API.KHACHHANG) + "/\(item)/\(page)"
            sendRequestAdmin(linkAPI: link, completion: { (object) in
                if let data = object?[getResultAPI(link: API.DATA_RETURN)] as? Array<Dictionary<String,Any>>
                {
                    for nv in data {
                        self.arrNhanVien.append(NhanVien(dic: nv))
                        showLog(mess: self.arrNhanVien)
                    }
                    self.page += 1
                    self.col.reloadData()
                } else {
                    self.page = -1
                }
            })
        }
        
    }    
    override func them() {
        if isEmployee {
            navigationController?.pushViewController(AddAccController(), animated: true)
        } else {
            showAlert(title: getAlertMessage(msg: ALERT.NOTICE), mess: getAlertMessage(msg: ALERT.NOADDCUSTOMER))
        }
    }
}

extension TaiKhoanController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrNhanVien.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellBanner", for: indexPath) as! CellBanner
            if isEmployee {
                cell.image = #imageLiteral(resourceName: "employees")
                cell.title = getTextUI(ui: UI.LBL_EMPLOYEE)
            } else {
                cell.image = #imageLiteral(resourceName: "customers")
                cell.title = getTextUI(ui: UI.LBL_CUSTOMER)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellTaiKhoan", for: indexPath) as! CellTaiKhoan
            cell.nv = arrNhanVien[indexPath.row - 1]
            return cell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: collectionView.frame.width, height: 200)
        } else {
            if isEmployee {
                return CGSize(width: collectionView.frame.width, height: 200)
            } else {
                return CGSize(width: collectionView.frame.width, height: 160)
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if isEmployee {
            let x = 200 + CGFloat(arrNhanVien.count) * (200 + 3) - scrollView.frame.height
            showLog(mess: scrollView.contentOffset.y)
            showLog(mess: x)
            showLog(mess: page)
            if scrollView.contentOffset.y == x && page > 0
            {
                setupDataCol()
            }
        } else {
            let x = 200 + CGFloat(arrNhanVien.count) * (160 + 3) - scrollView.frame.height
            showLog(mess: scrollView.contentOffset.y)
            showLog(mess: x)
            showLog(mess: page)
            if scrollView.contentOffset.y == x && page > 0
            {
                setupDataCol()
            }
        }
        
    }
    
}
