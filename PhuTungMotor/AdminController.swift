//
//  AdminController.swift
//  PhuTungMotor
//
//  Created by admin on 2/23/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class AdminController: MenuAdminController {
    
    let col:UICollectionView = {
        let scrDirection = UICollectionViewFlowLayout()
        scrDirection.scrollDirection = .vertical
        let v = UICollectionView(frame: CGRect.zero, collectionViewLayout: scrDirection)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return v
    }()
    
    var load = false // animation lan dau tien
    
    var arrPer: Array<Permission> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataPermission()
        col.delegate = self
        col.dataSource = self
        col.register(CellPermission.self, forCellWithReuseIdentifier: "CellPermission")
        col.register(CellBanner.self, forCellWithReuseIdentifier: "CellBanner")
    }
    
    func setupDataPermission()  {
        if arrPer.count == 0 {
            for per in (kh?.quyen)! {
                var quyen:Permission = Permission()
                quyen.ten = per
                var link = ""
                switch per {
                case "Kết Quả":
                    link = getLinkAdminSer(link: API.DOANHTHU)
                    quyen.imgIcon = #imageLiteral(resourceName: "ketqua_black")
                    break
                case "Hỏi đáp":
                    link = getLinkAdminSer(link: API.SOHOIDAP)
                    quyen.imgIcon = #imageLiteral(resourceName: "faq_black")
                    break
                case "Tài khoản":
                    quyen.imgIcon = #imageLiteral(resourceName: "account_black")
                    break
                case "Tin tức":
                    quyen.imgIcon = #imageLiteral(resourceName: "new_black")
                    break
                case "Doanh nghiệp":
                    quyen.imgIcon = #imageLiteral(resourceName: "doanhnghiep_black")
                    break
                case "Hãng xe":
                    quyen.imgIcon = #imageLiteral(resourceName: "hangxe_black")
                    break
                case "Loại xe":
                    quyen.imgIcon = #imageLiteral(resourceName: "loaixe_black")
                    break
                case "Sản phẩm":
                    quyen.imgIcon = #imageLiteral(resourceName: "sanpham_black")
                    break
                case "Đơn hàng":
                    link = getLinkAdminSer(link: API.SODONHANG)
                    quyen.imgIcon = #imageLiteral(resourceName: "donhang_black")
                    break
                case "Slider":
                    quyen.imgIcon = #imageLiteral(resourceName: "slider_black")
                    break
                default:
                    quyen.imgIcon = #imageLiteral(resourceName: "mail_black")
                }
                if (link != ""){
                    let j = arrPer.count
                    sendRequestAdmin(linkAPI: link, completion: { (data) in
                        self.arrPer[j].soluong = data?[getResultAPI(link: API.DATA_RETURN)] as! Double
                        //                                    let indexPath:IndexPath = IndexPath(item: j, section: 0)
                        //                                    self.col.reloadItems(at: [indexPath])
                        //                                    showLog(mess: self.arrPer[j])
                        showLog(mess: "Start reload data")
                        self.col.reloadData()
                    })
                }
                arrPer.append(quyen)
            }
        }
    }
    
    //Huy form gan CollectionView
    override func addForm() {
        uvMain.addViewFullScreen(views: col)
    }
}

extension AdminController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrPer.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellBanner", for: indexPath) as! CellBanner
            cell.isSelected = false
            cell.image = #imageLiteral(resourceName: "cbr150r")
            cell.title = getTextUI(ui: UI.LBL_PERMISSION)
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellPermission", for: indexPath) as! CellPermission
            cell.per = arrPer[indexPath.row - 1]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: collectionView.frame.width, height: 200)
        } else {
            return CGSize(width: collectionView.frame.width, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == arrPer.count - 1 {
            load = true
        }
        if !load {
            let dichuyentrai = CATransform3DTranslate(CATransform3DIdentity, -200, 0, 0)
            let dichuyenphai = CATransform3DTranslate(CATransform3DIdentity, 200, 0, 0)
            if let cell1 = cell as? CellPermission {
                cell1.imgIcon.layer.transform = dichuyentrai
                cell1.lblPer.layer.transform = dichuyentrai
                cell1.vSoluong.layer.transform = dichuyenphai
                UIView.animate(withDuration: TimeInterval(indexPath.row)/4) {
                    cell1.imgIcon.layer.transform = CATransform3DIdentity
                    cell1.lblPer.layer.transform = CATransform3DIdentity
                    cell1.vSoluong.layer.transform = CATransform3DIdentity
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.5, animations: {
            cell?.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        }) { (true) in
            UIView.animate(withDuration: 0.25, animations: {
                cell?.layer.transform = CATransform3DRotate(CATransform3DIdentity, CGFloat(M_PI), 0, 1, 0)
            }, completion: { (true) in
                UIView.animate(withDuration: 0.25, animations: {
                    cell?.layer.transform = CATransform3DIdentity
                }, completion: { (true) in
                    self.changePer(per: self.arrPer[indexPath.row - 1])
                })
            })
            
        }
    }
    
}
