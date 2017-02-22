//
//  SearchController.swift
//  PhuTungMotor
//
//  Created by admin on 2/22/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class SearchController: ProductController {
    
    let vResult:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let vKeyword:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblKeyword:UILabel = {
        let v = UILabel()
        v.font = UIFont.systemFont(ofSize: 14)
        v.textAlignment = .right
        v.text = getTextUI(ui: UI.LBL_KEYWORD)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblResult:UILabel = {
        let v = UILabel()
        v.font = UIFont.boldSystemFont(ofSize: 15)
        v.textAlignment = .left
        v.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var keyword = ""
    var page = 0
    var num = 6
    var tong = 0
    var arrSanPham:Array<SanPham> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colSanPham.register(CellSanPham.self, forCellWithReuseIdentifier: "CellSanPham")
        colSanPham.delegate = self
        colSanPham.dataSource = self
    }
    
    override func setupColSanPham() {
        uvMain.addSubview(vResult)
        vResult.leftAnchor.constraint(equalTo: uvMain.leftAnchor, constant: 5).isActive = true
        vResult.topAnchor.constraint(equalTo: uvMain.topAnchor, constant: 0).isActive = true
        vResult.bottomAnchor.constraint(equalTo: uvLoaiXe.topAnchor, constant: 0).isActive = true
        vResult.rightAnchor.constraint(equalTo: uvMain.rightAnchor, constant: -5).isActive = true
        
        vResult.addSubview(vKeyword)
        vResult.addSubview(colSanPham)
        
        vResult.addContraintByVSF(VSF: "H:|[v0]|", views: vKeyword)
        vResult.addContraintByVSF(VSF: "H:|[v0]|", views: colSanPham)
        vResult.addContraintByVSF(VSF: "V:|-5-[v0(30)]-5-[v1]|", views: vKeyword, colSanPham)
        
        vKeyword.addSubview(lblKeyword)
        vKeyword.addSubview(lblResult)

        lblKeyword.widthAnchor.constraint(equalTo: vKeyword.widthAnchor, multiplier: 0.5).isActive = true
        
        vKeyword.addContraintByVSF(VSF: "V:|[v0]|", views: lblKeyword)
        vKeyword.addContraintByVSF(VSF: "V:|[v0]|", views: lblResult)
        vKeyword.addContraintByVSF(VSF: "H:|[v0][v1]|", views: lblKeyword, lblResult)
        
    }
    
    func loadDataSanPham() {
        let extra = keyword + "/\(num)/\(page)"
        sendRequestNoLoading(linkAPI: API.SEARCH, param: nil, method: Method.get, extraLink: extra) { (object) in
            let res = object?[getResultAPI(link: API.DATA_RES)] as! String
            if res == getResultAPI(link: API.RES_OK) {
                self.page += 1
                self.tong = object!["tong"] as! Int
                if let data = object?[getResultAPI(link: API.DATA_RETURN)] as? Array<Dictionary<String,Any>> {
                    for i in data {
                        let sp:SanPham = SanPham(sanpham: i)
                        self.arrSanPham.append(sp)
                        let j = self.arrSanPham.count - 1
                        self.downloadImageNoload(sp: sp, completion: { (arrImage) in
                            self.arrSanPham[j].hinh = arrImage
                            self.colSanPham.reloadItems(at: [IndexPath(item: j, section: 0)])
                        })
                    }
                    let hienthi = self.arrSanPham.count
                    self.lblResult.text = " '\(self.keyword)' : \(hienthi)/\(self.tong) "
                    self.colSanPham.reloadData()
                }
            } else {
                self.page = -1
            }
        }
        
    }
    
    override func setupDataSanPham() {
        loadDataSanPham()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == colSanPham {
            return arrSanPham.count
        } else {
            return super.collectionView(collectionView, numberOfItemsInSection: section)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == colSanPham {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellSanPham", for: indexPath) as! CellSanPham
            cell.sanpham = arrSanPham[indexPath.row]
            return cell
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
            return CGSize(width: collectionView.frame.width/2, height: 250)
        } else {
            return super.collectionView(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = 250 * CGFloat(arrSanPham.count) / 2 - scrollView.frame.height
        showLog(mess: "Vi tri y: \(scrollView.contentOffset.y)" )
        showLog(mess: "Vi tri: \(x - scrollView.frame.height)" )
        if scrollView.contentOffset.y == x
        {
            if page >= 0
            {
                showLog(mess: "Load more")
                loadDataSanPham()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == colSanPham {
            let detail = ProductDetailController()
            detail.arrSanPham = arrSanPham
            detail.pos = indexPath.row
            navigationController?.pushViewController(detail, animated: true)
        } else {
            super.collectionView(collectionView, didSelectItemAt: indexPath)
        }
    }
    
    override func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        keyword = searchBar.text!
        if keyword.characters.count > 0 {
            arrSanPham.removeAll()
            loadDataSanPham()
        }
    }
}
