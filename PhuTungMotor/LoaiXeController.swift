//
//  LoaiXeController.swift
//  PhuTungMotor
//
//  Created by admin on 2/10/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class LoaiXeController: ProductController {
    
    var arrSanPham:Array<SanPham> = []
    var loaixe:LoaiXe = LoaiXe()
    var page = 0
    var items = 6
    var pos = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colSanPham.delegate = self
        colSanPham.dataSource = self
        colSanPham.register(CellSanPham.self, forCellWithReuseIdentifier: "CellSanPham")
        colSanPham.register(CellBanner.self, forCellWithReuseIdentifier: "CellBanner")
        setupDataProduct()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        let index = IndexPath(item: pos, section: 0)
        colLoaiXe.selectItem(at: index, animated: true, scrollPosition: UICollectionViewScrollPosition.right)
    }
    func setupDataProduct() {
        let extra = "\(loaixe.id)/\(page)/\(items)"
        showLog(mess: extra)
        sendRequestNoLoading(linkAPI: API.PRODUCT, param: nil, method: Method.get, extraLink: extra) { (object) in
            if object?[getResultAPI(link: API.DATA_RES)] as! String == getResultAPI(link: API.RES_OK) {
                self.page = self.page + 1
                if let data = object?[getResultAPI(link: API.DATA_RETURN)] as? Array<Dictionary<String,Any>> {
                    for i in data {
                        let sp:SanPham = SanPham(sanpham: i)
                        self.arrSanPham.append(sp)
                        let j = self.arrSanPham.count - 1
                        self.downloadImageNoload(sp: sp, completion: { (arrImage) in
                            self.arrSanPham[j].hinh = arrImage
                            self.colSanPham.reloadItems(at: [IndexPath(item: j + 1, section: 0)])
                        })
                      
                    }
                    showLog(mess: self.arrSanPham.count)
                    self.colSanPham.reloadData()
                }
            }
            else {
                self.page = -1
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == colSanPham {
            return arrSanPham.count + 1
        } else {
            return super.collectionView(collectionView, numberOfItemsInSection: section)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == colSanPham {
            if indexPath.row == 0 {
                let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "CellBanner", for: indexPath) as! CellBanner
                cell1.isSelected = false
                cell1.title = loaixe.ten
                cell1.link = getLinkImage(link: API.BIKETYPE) + "/" + loaixe.hinh
                return cell1
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellSanPham", for: indexPath) as! CellSanPham
                showLog(mess: "so phan tu trong mang\(arrSanPham.count)")
                showLog(mess: "vi tri: \(indexPath.row - 1)")
                cell.sanpham = arrSanPham[indexPath.row - 1]
                cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                return cell
            }
        } else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == colSanPham {
            return 0
        } else {
            return super.collectionView(collectionView, layout: collectionViewLayout, minimumLineSpacingForSectionAt: section)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == colSanPham {
            return 0
        } else {
            return super.collectionView(collectionView, layout: collectionViewLayout, minimumInteritemSpacingForSectionAt: section)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == colSanPham {
            if indexPath.row == 0 {
                return CGSize(width: collectionView.frame.width, height: 200)
            } else {
                return CGSize(width: collectionView.frame.width/2, height: 250)
            }
        } else {
            return super.collectionView(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = 200 + 250 * CGFloat(arrSanPham.count) / 2  - scrollView.frame.height
        showLog(mess: "Vi tri y: \(scrollView.contentOffset.y)" )
        showLog(mess: "Vi tri: \(x - scrollView.frame.height)" )
        if scrollView.contentOffset.y == x
        {
            if page >= 0
            {
                showLog(mess: "Load more")
                setupDataProduct()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == colSanPham {
            let detail = ProductDetailController()
            showLog(mess: "so phan tu: \(arrSanPham.count)")
            showLog(mess: "vi tri: \(indexPath.row - 1)")
            detail.arrSanPham = arrSanPham
            detail.pos = indexPath.row - 1
            navigationController?.pushViewController(detail, animated: true)
        } else {
            super.collectionView(collectionView, didSelectItemAt: indexPath)
        }
    }
    
}
