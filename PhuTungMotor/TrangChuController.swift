//
//  TrangChuController.swift
//  PhuTungMotor
//
//  Created by admin on 2/10/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class TrangChuController: ProductController {
    
    var arrSanPham:Array<Array<SanPham>> = []
    var pos = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colSanPham.register(CellSanPham.self, forCellWithReuseIdentifier: "CellSanPham")
        colSanPham.register(CellBanner.self, forCellWithReuseIdentifier: "CellBanner")
        colSanPham.register(HeaderSanPham.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        colSanPham.delegate = self
        colSanPham.dataSource = self
    }
    
    override func setupDataSanPham() {
        var arr:Array<SanPham> = []
        arr.append(SanPham())
        arrSanPham.append(arr)
        loadSanPhamHangXe(lx: arrLoaiXe[pos])
        loadSanPhamHangXe(lx: arrLoaiXe[pos])
    }
    
    func loadSanPhamHangXe(lx:LoaiXe)  {
        sendRequestNoLoading(linkAPI: API.HOME, param: nil, method: Method.get, extraLink: "\(lx.id)/4", completion: { (object) in
            if object != nil {
                if object?["result"] as! String == getResultAPI(link: API.RES_OK) {
                    if let data = object?[getResultAPI(link: API.DATA_RETURN)] as? Array<Dictionary<String,Any>> {
                        let section = self.arrSanPham.count
                        var arrTam:Array<SanPham> = []
                        for i in data {
                            let sp = SanPham(sanpham: i)
                            arrTam.append(sp)
                            let j = arrTam.count - 1
                            self.downloadImageNoload(sp: sp, completion: { (arrImage) in
                                self.arrSanPham[section][j].hinh = arrImage
                                self.colSanPham.reloadItems(at: [IndexPath(row: j, section: section)])
                                showLog(mess: self.arrSanPham[section][j])
                            })
                        }
                        self.arrSanPham.append(arrTam)
                        showLog(mess: arrTam)
                        self.colSanPham.reloadData()
                    }
                } else {
                    self.pos = -1
                }
            } else {
                self.pos = -1
            }
        })
        if pos < arrLoaiXe.count {
            pos += 1
        } else {
            pos = -1
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == colSanPham {
            return arrSanPham.count
        } else {
            return super.numberOfSections(in: collectionView)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == colSanPham {
            return arrSanPham[section].count
        } else {
            return super.collectionView(collectionView, numberOfItemsInSection: section)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == colSanPham {
            if indexPath.section == 0 {
                let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "CellBanner", for: indexPath) as! CellBanner
                cell1.isSelected = false
                cell1.title = getTextUI(ui: UI.LBL_TRADEMARK)
                cell1.image = #imageLiteral(resourceName: "cbr150r")
                return cell1
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellSanPham", for: indexPath) as! CellSanPham
                cell.sanpham = arrSanPham[indexPath.section][indexPath.row]
                cell.borderwidth = 0.25
                cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                return cell
            }
        } else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == colSanPham {
            switch kind {
            case UICollectionElementKindSectionHeader:
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! HeaderSanPham
                if indexPath.section == 0 {
                    view.loaixe = LoaiXe()
                } else {
                    view.loaixe = arrLoaiXe[indexPath.section - 1]
                }
                return view
            default:
                return UICollectionReusableView()
            }
        } else {
            return UICollectionReusableView()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == colSanPham {
            if indexPath.section > 0 {
                let detail = ProductDetailController()
                detail.arrSanPham = arrSanPham[indexPath.section]
                detail.pos = indexPath.row
                navigationController?.pushViewController(detail, animated: true)
            }
        } else {
            super.collectionView(collectionView, didSelectItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if (collectionView == colSanPham) {
            if arrSanPham.count == 0 || section == 0{
                return CGSize.zero
            } else {
                return CGSize(width: view.frame.width, height: 50)
            }
        }
        else {
            return CGSize.zero
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == colSanPham {
            if indexPath.section == 0 {
                return CGSize(width: collectionView.frame.width, height: 200)
            } else {
                return CGSize(width: collectionView.frame.width/2, height: 250)
            }
        } else {
            return super.collectionView(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath)
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = 200 + CGFloat(arrSanPham.count - 1) * (50 + 250 * 2) - scrollView.frame.height
        showLog(mess: scrollView.contentOffset.y)
        showLog(mess: x)
        showLog(mess: pos)
        if scrollView.contentOffset.y == x && pos >= 0
        {
            loadSanPhamHangXe(lx: arrLoaiXe[pos])
        }
    }
    
}
