//
//  HangXeController.swift
//  PhuTungMotor
//
//  Created by admin on 3/8/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class HangXeController: MenuAdminController {
    
    var arrHangXe:Array<HangXe> = []
    let item = 6
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        col.delegate = self
        col.dataSource = self
        col.register(CellHangXe.self, forCellWithReuseIdentifier: "CellHangXe")
        col.register(CellBanner.self, forCellWithReuseIdentifier: "CellBanner")

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        page = 1
        arrHangXe.removeAll()
        setupDataCol()
        col.reloadData()
    }
    
    
    override func setupBackground() {
        //Huy background
    }
    
    override func addHomeIcon() {
        //Gan nut back
    }
    
    
    override func addForm() {
        uvMain.addSubview(col)
        uvMain.addContraintByVSF(VSF: "H:|-10-[v0]-10-|", views: col)
        uvMain.addContraintByVSF(VSF: "V:|[v0]|", views: col)
    }
    
    func setupDataCol()  {
        paramAdmin["truycap"] = "6"
        let extra = "\(item)/\(page)"

        sendRequestAdmin(linkAPI: API.HANGXE, param: paramAdmin, method: Method.post, extraLink: extra) { (object) in
            if let data = object?[getResultAPI(link: API.DATA_RETURN)] as? Array<Dictionary<String,Any>> {
                for dic in data {
                    self.arrHangXe.append(HangXe(hangxe: dic))
                }
                if data.count < self.item {
                    self.page = -1
                } else {
                    self.page += 1
                }
                self.col.reloadData()
            } else {
                self.page = -1
            }
        }
    }
    
    override func them() {
        navigationController?.pushViewController(ChangeHXController(), animated: true)
    }
    
}

extension HangXeController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrHangXe.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellBanner", for: indexPath) as! CellBanner
            cell.image = #imageLiteral(resourceName: "cbr150r")
            cell.title =  getTextUI(ui: UI.LBL_HANGXE)
            cell.isSelected = false
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellHangXe", for: indexPath) as! CellHangXe
            cell.hx = arrHangXe[indexPath.row - 1]
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: collectionView.frame.width, height: 200)
        } else {
            return CGSize(width: collectionView.frame.width / 2 - 5, height: collectionView.frame.width / 2 - 5 + 30)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = 200 + CGFloat(arrHangXe.count / 2) * (col.frame.width/2 + 25) - scrollView.frame.height
        showLog(mess: scrollView.contentOffset.y)
        showLog(mess: x)
        showLog(mess: page)
        if scrollView.contentOffset.y == x && page > 0
        {
            showLog(mess: "load more page = \(page)")
            setupDataCol()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showAlert2Action(title: getAlertMessage(msg: ALERT.NOTICE), mess: getAlertMessage(msg: ALERT.CHONTRANG), btnATitle: getAlertMessage(msg: ALERT.UPDATEHX), btnBTitle: getAlertMessage(msg: ALERT.DELETEHX), actionA: {
            let scr = ChangeHXController()
            scr.isAddHangXe = false
            scr.hangxe = self.arrHangXe[indexPath.row - 1]
            self.navigationController?.pushViewController(scr, animated: true)
        }) { 
            self.showAlertAction(title: getAlertMessage(msg: .NOTICE), mess: getAlertMessage(msg: ALERT.DISABLESURE), complete: {
                var param = paramAdmin
                param["truycap"] = "6"
                param["id"] = "\(self.arrHangXe[indexPath.row - 1].id)"
                showLog(mess: param)
                self.sendRequestAdmin(linkAPI: API.DISABLEHANGXE, param: param, method: Method.post, extraLink: nil, completion: { (object) in
                    //Disable Hang xe
                    showLog(mess: object!)
                    if let _ = object?[getResultAPI(link: API.DATA_RETURN)] as? Dictionary<String,Any> {
                        self.arrHangXe.remove(at: indexPath.row - 1)
                        collectionView.reloadData()
                        self.showAlert(title: getAlertMessage(msg: ALERT.NOTICE), mess: getAlertMessage(msg: ALERT.OKDISHANGXE))
                    } else {
                        let mess = object?[getResultAPI(link: API.DATA_RETURN)] as! String
                        self.showAlert(title: getAlertMessage(msg: ALERT.ERROR), mess: mess)
                    }
                })
            })
        }
        
    }
    
}
