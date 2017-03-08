//
//  LstHoiDapAdController.swift
//  PhuTungMotor
//
//  Created by admin on 3/8/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class LstHoiDapController: MenuAdminController {
    
    var arrHoiDap:Array<HoiDap>  = []
    var loaixe:LoaiXe = LoaiXe()
    let item = 6
    var page = 1
    var choice = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupDataCol()
        col.delegate = self
        col.dataSource = self
        col.register(CellHoiDap.self, forCellWithReuseIdentifier: "CellHoiDap")
        col.register(CellBanner.self, forCellWithReuseIdentifier: "CellBanner")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        arrHoiDap.removeAll()
        setupDataCol()
        col.reloadData()
    }
    
    func setupDataCol()  {
        let i = loaixe.id
        sendRequestAdmin(linkAPI: API.FAQ, param: paramAdmin, method: Method.post, extraLink: "\(page)/\(i)/\(item)", completion: { (object) in
            if let data = object?[getResultAPI(link: API.DATA_RETURN)] as? Array<Dictionary<String,Any>> {
                for dic in data {
                    self.arrHoiDap.append(HoiDap(dic: dic))
                }
                self.col.reloadData()
                if data.count < self.item {
                    self.page = -1
                } else {
                    self.page += 1
                }
            } else {
                self.page = -1
            }
            showLog(mess: "page = \(self.page)")
        })
    }
    
    override func setupBackground() {
        //Huy background
    }
    
    override func addHomeIcon() {
        //Gan nut back
    }
    
    override func addMenuIcon() {
        //Bo cart
        let searchBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "search"), style: .plain, target: self, action: #selector(BaseController.search))
        self.navigationItem.rightBarButtonItem = searchBtn
    }
    
    override func addForm() {
        uvMain.addSubview(col)
        uvMain.addContraintByVSF(VSF: "H:|-10-[v0]-10-|", views: col)
        uvMain.addContraintByVSF(VSF: "V:|[v0]|", views: col)
    }
}

extension LstHoiDapController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrHoiDap.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellBanner", for: indexPath) as! CellBanner
            cell.image = #imageLiteral(resourceName: "question")
            cell.title =  getTextUI(ui: UI.LBL_LIST) + loaixe.ten
            cell.isSelected = false
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellHoiDap", for: indexPath) as! CellHoiDap
            cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.hoidap = arrHoiDap[indexPath.row - 1]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: collectionView.frame.width, height: 200)
        } else {
            return CGSize(width: collectionView.frame.width, height: 90)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = 200 + CGFloat(arrHoiDap.count) * (90 + 1) - scrollView.frame.height
        showLog(mess: scrollView.contentOffset.y)
        showLog(mess: x)
        showLog(mess: page)
        if scrollView.contentOffset.y == x && page > 0
        {
            showLog(mess: "page = \(page)")
            setupDataCol()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        choice = indexPath.row - 1
        actionHoiDap(hd: arrHoiDap[choice])
    }
    
}
