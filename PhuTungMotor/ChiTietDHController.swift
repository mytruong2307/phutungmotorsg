//
//  ChiTietDHController.swift
//  PhuTungMotor
//
//  Created by admin on 2/21/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class ChiTietDHController: ProductController {
    
    let vTongTien:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let btnPrevious:UIButton = {
        let v = UIButton()
        v.setImage(#imageLiteral(resourceName: "left"), for: UIControlState.normal)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let btnNext:UIButton = {
        let v = UIButton()
        v.setImage(#imageLiteral(resourceName: "right"), for: UIControlState.normal)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblVTongTien:UILabel = {
        let v = UILabel()
        v.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        v.textAlignment = .center
        v.text = getTextUI(ui: UI.LBL_SUM)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblVHaiCham:UILabel = {
        let v = UILabel()
        v.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        v.textAlignment = .center
        v.text = ":"
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblDTongTien:UILabel = {
        let v = UILabel()
        v.font = UIFont.boldSystemFont(ofSize: 17)
        v.textAlignment = .center
        v.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var arrDonHang:Array<DonHang> = []
    var pos:Int = 0
    var arrSP:Array<GioHang> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colSanPham.register(CellProduct.self, forCellWithReuseIdentifier: "CellProduct")
        colSanPham.delegate = self
        colSanPham.dataSource = self
        colSanPham.allowsSelection = false
        downloadAllData()
    }
    
    func downloadAllData()  {
        for (index,dh) in arrDonHang.enumerated() {
            if index != pos {
                let arrGH = dh.listSP
                for (vitri,sp) in arrGH.enumerated() {
                    if sp.sanpham.hinh.count == 0 {
                        downloadImageSanPham(sp: sp.sanpham, completion: { (image) in
                            self.arrDonHang[index].listSP[vitri].sanpham.hinh = image
                            showLog(mess: "Down xong anh cua SP: \(vitri + 1) thuoc don hang :\(dh.id)")
                            if index == self.pos {
                                self.colSanPham.reloadItems(at: [IndexPath(item: vitri, section: 0)])
                                showLog(mess: "Reload Item \(vitri)")
                            }
                        })
                    }
                }
            }
        }
    }
    override func addHomeIcon() {
        //Bo menu icon
        self.navigationItem.rightBarButtonItems = [cartBtn]
    }
    
    override func setupColLoaiXe() {
        uvMain.addSubview(uvLoaiXe)
        uvLoaiXe.bottomAnchor.constraint(equalTo: uvMain.bottomAnchor, constant: 0).isActive = true
        uvLoaiXe.heightAnchor.constraint(equalToConstant: 70).isActive = true
        uvLoaiXe.rightAnchor.constraint(equalTo: uvMain.rightAnchor, constant: -5).isActive = true
        uvLoaiXe.leftAnchor.constraint(equalTo: uvMain.leftAnchor, constant: 5).isActive = true
        
        uvLoaiXe.addSubview(vTongTien)
        uvLoaiXe.addSubview(colLoaiXe)
        
        uvLoaiXe.addContraintByVSF(VSF: "H:|[v0]|", views: vTongTien)
        uvLoaiXe.addContraintByVSF(VSF: "H:|[v0]|", views: colLoaiXe)
        uvLoaiXe.addContraintByVSF(VSF: "V:|[v0][v1(30)]|", views: vTongTien, colLoaiXe)
        
        vTongTien.addSubview(lblVTongTien)
        vTongTien.addSubview(lblVHaiCham)
        vTongTien.addSubview(lblDTongTien)
        vTongTien.addSubview(btnPrevious)
        vTongTien.addSubview(btnNext)
        
        btnPrevious.widthAnchor.constraint(equalTo: vTongTien.heightAnchor, multiplier: 1).isActive = true
        btnNext.widthAnchor.constraint(equalTo: vTongTien.heightAnchor, multiplier: 1).isActive = true
        
        lblVTongTien.widthAnchor.constraint(equalTo: vTongTien.widthAnchor, multiplier: 0.35).isActive = true
        lblDTongTien.widthAnchor.constraint(equalTo: vTongTien.widthAnchor, multiplier: 0.35).isActive = true
        vTongTien.addContraintByVSF(VSF: "V:|[v0]|", views: btnPrevious)
        vTongTien.addContraintByVSF(VSF: "V:|[v0]|", views: btnNext)
        vTongTien.addContraintByVSF(VSF: "V:|[v0]|", views: lblVTongTien)
        vTongTien.addContraintByVSF(VSF: "V:|[v0]|", views: lblVHaiCham)
        vTongTien.addContraintByVSF(VSF: "V:|[v0]|", views: lblDTongTien)
        vTongTien.addContraintByVSF(VSF: "H:|[v0][v1][v2(20)][v3][v4]|", views: btnPrevious, lblVTongTien,lblVHaiCham, lblDTongTien, btnNext)
        
        btnPrevious.addTarget(self, action: #selector(ChiTietDHController.showDonHangTruoc), for: UIControlEvents.touchUpInside)
        btnNext.addTarget(self, action: #selector(ChiTietDHController.showDonHangSau), for: UIControlEvents.touchUpInside)
    }
    
    func showDonHangTruoc()  {
        pos -= 1
        if pos < 0 {
            pos = arrDonHang.count - 1
        }
        setupData()
    }
    
    func showDonHangSau()  {
        pos += 1
        if pos >= arrDonHang.count {
            pos = 0
        }
        setupData()
    }
    
    func setupData() {
        arrSP.removeAll()
        arrSP = arrDonHang[pos].listSP
        var sum:Double = 0
        for gh in arrSP {
            sum += gh.sanpham.gia * Double (gh.soluong)
        }
        lblDTongTien.text = showVNCurrency(gia: sum)
        showLog(mess: pos)
        showLog(mess: arrSP)
        colSanPham.reloadData()
    }
    
    override func setupDataSanPham() {
        arrSP = arrDonHang[pos].listSP
        var sum:Double = 0
        for (index,gh) in arrSP.enumerated() {
            sum += gh.sanpham.gia * Double (gh.soluong)
            if gh.sanpham.hinh.count == 0 {
                downloadImageSanPham(sp: gh.sanpham, completion: { (image) in
                    self.arrSP[index].sanpham.hinh = image
                    self.colSanPham.reloadItems(at: [IndexPath(item: index, section: 0)])
                    showLog(mess: "Load xong hinh san pham \(self.arrSP[index].sanpham.ten)")
                    self.arrDonHang[self.pos].listSP[index] = self.arrSP[index]
                })
            }
        }
        lblDTongTien.text = showVNCurrency(gia: sum)
        showLog(mess: arrSP)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == colSanPham {
            return arrSP.count
        } else {
            return super.collectionView(collectionView, numberOfItemsInSection: section)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == colSanPham {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellProduct", for: indexPath) as! CellProduct
            cell.gioHang = arrSP[indexPath.row]
            cell.pos = indexPath.row
            return cell
        } else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == colSanPham {
            return CGSize(width: collectionView.frame.width, height: 250)
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
    
}
