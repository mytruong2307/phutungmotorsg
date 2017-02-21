//
//  DonHangController.swift
//  PhuTungMotor
//
//  Created by admin on 2/20/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class DonHangController: ProductController {
    
    var arrDonHang:Array<DonHang> = []
    let item = 3
    var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(DonHangController.xemChiTiet), name: NSNotification.Name.init("viewDetail"), object: nil)
        arrDonHang.append(DonHang())
        colSanPham.register(CellBanner.self, forCellWithReuseIdentifier: "CellBanner")
        colSanPham.register(CellDonHang.self, forCellWithReuseIdentifier: "CellDonHang")
        colSanPham.dataSource = self
        colSanPham.delegate = self
    }
    
    func xemChiTiet(object:Notification) {
        let donhang = object.object as! DonHang
        if let pos = arrDonHang.index(where: {$0.id == donhang.id}) {
            showDonHang(pos: pos)
        }
    }
    
    func showDonHang(pos:Int)  {
        let scr = ChiTietDHController()
        scr.pos = pos - 1
        arrDonHang = arrDonHang.filter({$0.id > 0})
        scr.arrDonHang = arrDonHang
        navigationController?.pushViewController(scr, animated: true)
    }
    
    override func setupDataSanPham() {
        let extra:String = "\(kh!.email)/\(item)/\(page)"
        if page == 0 {
            sendRequestToServer(linkAPI: API.DONHANG, param: nil, method: Method.get, extraLink: extra) { (object) in
                self.getdata(object: object!)
            }
        } else {
            sendRequestNoLoading(linkAPI: API.DONHANG, param: nil, method: Method.get, extraLink: extra) { (object) in
                self.getdata(object: object!)
            }
        }
    }
    
    func loadSanPham(pos:Int)  {
        var arrSp:Array<GioHang> = []
        let extra = "\(arrDonHang[pos].id)"
        sendRequestNoLoading(linkAPI: API.DONHANGSANPHAM, param: nil, method: Method.get, extraLink: extra) { (object) in
            let res = object?[getResultAPI(link: API.DATA_RES)] as? String
            if res == getResultAPI(link: API.RES_OK) {
                if let data = object?[getResultAPI(link: API.DATA_RETURN)] as? Array<Dictionary<String,Any>> {
                    for i in data {
                        var sanpham = SanPham(sanpham: i)
                        sanpham.gia = i["giaban"] as! Double
                        let soluong = i["soluong"] as! Int
                        arrSp.append(GioHang(sanpham: sanpham, soluong: soluong))
                    }
                    self.arrDonHang[pos].listSP = arrSp
                }
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == colSanPham {
            return arrDonHang.count
        } else {
            return super.collectionView(collectionView, numberOfItemsInSection: section)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == colSanPham {
            if indexPath.row == 0 {
                let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "CellBanner", for: indexPath) as! CellBanner
                cell1.isSelected = false
                cell1.title = getTextUI(ui: UI.LBL_LISTORDER)
                cell1.image = #imageLiteral(resourceName: "order")
                return cell1
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellDonHang", for: indexPath) as! CellDonHang
                cell.donhang = arrDonHang[indexPath.row]
                return cell
            }
        } else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == colSanPham {
            if indexPath.section > 0 {
                showDonHang(pos: indexPath.row)
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
                return CGSize(width: collectionView.frame.width, height: 170)
            }
        } else {
            return super.collectionView(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == colSanPham {
            return 5
        } else {
            return super.collectionView(collectionView, layout: collectionViewLayout, minimumLineSpacingForSectionAt: section)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == colSanPham {
            return 5
        } else {
            return super.collectionView(collectionView, layout: collectionViewLayout, minimumInteritemSpacingForSectionAt: section)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = 200 + CGFloat (arrDonHang.count - 1) * 175 - scrollView.frame.height
        showLog(mess: scrollView.contentOffset.y)
        showLog(mess: x)
        showLog(mess: page)
        if scrollView.contentOffset.y == x && page >= 0
        {
            setupDataSanPham()
        }
    }
    
    func getdata(object:Dictionary<String,Any>)  {
        let res = object[getResultAPI(link: API.DATA_RES)] as? String
        if res == getResultAPI(link: API.RES_OK) {
            if let data = object[getResultAPI(link: API.DATA_RETURN)] as? Array<Dictionary<String,Any>> {
                for i in data {
                    self.arrDonHang.append(DonHang(dic: i))
                    self.loadSanPham(pos: self.arrDonHang.count - 1)
                }
                self.colSanPham.reloadData()
            }
            self.page += 1
        } else {
            self.page = -1
        }
    }
    
}
