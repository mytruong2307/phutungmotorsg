//
//  ShoppingController.swift
//  PhuTungMotor
//
//  Created by admin on 2/18/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class ShoppingController: ProductController {
    
    let btnShopping = MyButton()
    var tongtien:Double = 0
    
    let lblTong:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = getTextUI(ui: UI.LBL_SUM)
        v.font = UIFont.boldSystemFont(ofSize: 17)
        v.textAlignment = .right
        return v
    }()
    
    let lblSum:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont.boldSystemFont(ofSize: 17)
        v.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        v.textAlignment = .right
        return v
    }()
    
    
    let vTongTien:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector:  #selector(ShoppingController.updateShopping), name: NSNotification.Name.init("updateShopping"), object: nil)
        btnShopping.setTitle(getTextUI(ui: UI.BTN_SHOPPING), for: UIControlState.normal)
        colSanPham.register(CellBanner.self, forCellWithReuseIdentifier: "CellBanner")
        colSanPham.register(CellShopping.self, forCellWithReuseIdentifier: "CellShopping")
        colSanPham.delegate = self
        colSanPham.dataSource = self
        updateTotal()
        showLog(mess: gioHang)
    }
    
    override func setupColLoaiXe() {
        uvMain.addSubview(uvLoaiXe)
        uvLoaiXe.bottomAnchor.constraint(equalTo: uvMain.bottomAnchor, constant: 0).isActive = true
        uvLoaiXe.heightAnchor.constraint(equalToConstant: 94).isActive = true
        uvLoaiXe.rightAnchor.constraint(equalTo: uvMain.rightAnchor, constant: -5).isActive = true
        uvLoaiXe.leftAnchor.constraint(equalTo: uvMain.leftAnchor, constant: 5).isActive = true
        
        uvLoaiXe.addSubview(btnShopping)
        uvLoaiXe.addSubview(vTongTien)
        uvLoaiXe.addSubview(colLoaiXe)
        uvLoaiXe.addContraintByVSF(VSF: "H:|[v0]|", views: vTongTien)
        uvLoaiXe.addContraintByVSF(VSF: "H:|[v0]|", views: btnShopping)
        uvLoaiXe.addContraintByVSF(VSF: "H:|[v0]|", views: colLoaiXe)
        uvLoaiXe.addContraintByVSF(VSF: "V:|[v0(30)]-2-[v1(30)]-2-[v2(30)]|", views: vTongTien,btnShopping,colLoaiXe)
        
        btnShopping.addTarget(self, action: #selector(ShoppingController.datHangSanPham), for: UIControlEvents.touchUpInside)
        btnShopping.becomeFirstResponder()
        
        vTongTien.addSubview(lblSum)
        vTongTien.addSubview(lblTong)
        
        lblSum.widthAnchor.constraint(equalTo: vTongTien.widthAnchor, multiplier: 0.5).isActive = true
        
        vTongTien.addContraintByVSF(VSF: "V:|[v0]|", views: lblTong)
        vTongTien.addContraintByVSF(VSF: "V:|[v0]|", views: lblSum)
        vTongTien.addContraintByVSF(VSF: "H:|[v0]-10-[v1]|", views: lblTong, lblSum)
        
    }
    
    func datHang()  {
        if kh == nil {
            showAlert2Action(title: getAlertMessage(msg: ALERT.NOTICE), mess: getAlertMessage(msg: ALERT.LOGINREGISTER), btnATitle: getAlertMessage(msg: ALERT.LOGIN), btnBTitle: getAlertMessage(msg: ALERT.REGISTER), actionA: {
                let scr = LoginController()
                scr.shopping = true
                self.navigationController?.pushViewController(scr, animated: true)
            }) {
                let scr = RegisterController()
                scr.shopping = true
                self.navigationController?.pushViewController(scr, animated: true)
            }
        } else {
            var param = Dictionary<String,String>()
            param["id"] = "\(kh!.id)"
            param["ten"] = kh?.ten
            param["email"] = kh?.email
            param["dienthoai"] = kh?.dienthoai
            param["tinh"] = kh?.tinh
            param["quan"] = kh?.quan
            param["phuong"] = kh?.phuong
            param["sonha"] = kh?.sonha
            param["cachthanhtoan"] = "\(thanhtoan)"
            let tien = NSString(format: "%.0f", tongtien)
            param["tongtien"] = tien as String
            let json = convertGioHangToJSON()
            showLog(mess: "San pham " + json)
            if json != "" {
                param["list"] = json
            }
            sendRequestToServer(linkAPI: API.SHOPPING, param: param, method: Method.post, extraLink: nil, completion: { (object) in
                if object != nil {
                    let data = object?[getResultAPI(link: API.DATA_RES)] as! String
                    if data == getResultAPI(link: API.RES_OK) {
                        gioHang.removeAll()
                        self.showAlertAction(title: getAlertMessage(msg: ALERT.NOTICE), mess: getAlertMessage(msg: ALERT.SHOPPINGOK), complete: {
                            thanhtoan = -1
                            let _ = self.navigationController?.popToRootViewController(animated: true)
                        })
                    }
                } else {
                    self.showAlert(title: getAlertMessage(msg: ALERT.ERROR), mess: getAlertMessage(msg: ALERT.SHOPPINGNOK))
                }
            })
        }
    }
    
    func datHangSanPham() {
        showAlert2Action(title: getAlertMessage(msg: ALERT.NOTICE), mess: getAlertMessage(msg: ALERT.THANHTOAN), btnATitle: getAlertMessage(msg: ALERT.TIENMAT), btnBTitle: getAlertMessage(msg: ALERT.CHUYENKHOAN), actionA: {
            thanhtoan = 0
            self.datHang()
        }) {
            thanhtoan = 1
            self.datHang()
        }
    }
    
    func updateTotal() {
        var sum:Double = 0
        var soluong:Int = 0
        for gh in gioHang {
            sum += gh.sanpham.gia * Double (gh.soluong)
            soluong += gh.soluong
        }
        lblCart.text = String (soluong)
        lblSum.text = showVNCurrency(gia: sum)
        tongtien = sum
    }
    
    func updateShopping(object:Notification)  {
        let gh = object.object as! GioHang
        if gh.soluong <= 0 {
            showAlertAction(title: getAlertMessage(msg: ALERT.NOTICE), mess: getAlertMessage(msg: ALERT.DELETESHOPPING), complete: {
                for (index,shop) in gioHang.enumerated() {
                    if shop.sanpham.id == gh.sanpham.id {
                        gioHang.remove(at: index)
                        break
                    }
                }
                self.updateTotal()
                self.colSanPham.reloadData()
                showLog(mess: gioHang)
                self.colSanPham.reloadData()
            })
        } else {
            showAlertAction(title: getAlertMessage(msg: ALERT.NOTICE), mess: getAlertMessage(msg: ALERT.UPDATESL), complete: {
                var indexPath = IndexPath(item: 0, section: 0)
                for (index,shop) in gioHang.enumerated() {
                    if shop.sanpham.id == gh.sanpham.id {
                        gioHang[index].soluong = gh.soluong
                        indexPath.item = index
                        break
                    }
                }
                self.updateTotal()
                self.colSanPham.reloadItems(at: [indexPath])
                showLog(mess: gioHang)
            })
            
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == colSanPham {
            return gioHang.count + 1
        } else {
            return super.collectionView(collectionView, numberOfItemsInSection: section)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == colSanPham {
            if indexPath.row == 0 {
                let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "CellBanner", for: indexPath) as! CellBanner
                cell1.isSelected = false
                cell1.title = getTextUI(ui: UI.LBL_SHOPPINGCART)
                cell1.image = #imageLiteral(resourceName: "shopping_cart")
                return cell1
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellShopping", for: indexPath) as! CellShopping
                cell.gh = gioHang[indexPath.row - 1]
                return cell
            }
        } else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == colSanPham {
            if indexPath.row > 0 {
                let detail = ProductDetailController()
                var arrSP:Array<SanPham> = []
                for gh in gioHang {
                    arrSP.append(gh.sanpham)
                }
                detail.arrSanPham = arrSP
                detail.pos = indexPath.row - 1
                navigationController?.pushViewController(detail, animated: true)
            }
        } else {
            super.collectionView(collectionView, didSelectItemAt: indexPath)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == colSanPham {
            if indexPath.row == 0 {
                return CGSize(width: collectionView.frame.width, height: 200)
            } else {
                return CGSize(width: collectionView.frame.width, height: 70)
            }
        } else {
            return super.collectionView(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == colSanPham {
            return 3
        } else {
            return super.collectionView(collectionView, layout: collectionViewLayout, minimumLineSpacingForSectionAt: section)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == colSanPham {
            return 3
        } else {
            return super.collectionView(collectionView, layout: collectionViewLayout, minimumInteritemSpacingForSectionAt: section)
        }
    }
    
    func convertGioHangToJSON() -> String {
        let jsonCompatibleArray = gioHang.map { model in
            return [
                "sanpham_id" : model.sanpham.id,
                "gia" : model.sanpham.gia,
                "soluong" : model.soluong
            ]
        }
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonCompatibleArray, options: JSONSerialization.WritingOptions.prettyPrinted)
            let jsonString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            return jsonString! as String
        } catch {
            return ""
        }
        
    }
}
