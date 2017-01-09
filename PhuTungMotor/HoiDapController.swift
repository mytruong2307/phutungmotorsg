//
//  HoiDapController.swift
//  PhuTungMotor
//
//  Created by admin on 1/6/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class HoiDapController: BaseController {
    
    var arrHoiDap:Array<HoiDap> = []
    let collectHoiDap:UICollectionView = {
        let v = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        v.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        return v
    }()
    
    override func setupBackground() {
        //Huy background
    }
    
    override func addHomeIcon() {
        //Huy home menu
    }
    
    override func addForm() {
        //Huy form
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollect()
        //Load data
        sendRequestToServer(linkAPI: API.FAQ, param: nil, method: Method.get, extraLink: "4/1") { (object) in
            if let data = object?[getResultAPI(link: API.DATA_RETURN)] as? Array<Dictionary<String,Any>> {
                for hoidap in data {
                    self.arrHoiDap.append(HoiDap(dic: hoidap))
                }
                self.collectHoiDap.reloadData()
            }
        }
    }
    
    func setupCollect()  {
        uvMain.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        uvMain.addSubview(collectHoiDap)
        uvMain.addContraintByVSF(VSF: "H:|-10-[v0]-10-|", views: collectHoiDap)
        uvMain.addContraintByVSF(VSF: "V:|-10-[v0]-10-|", views: collectHoiDap)
        collectHoiDap.delegate = self
        collectHoiDap.dataSource = self
        collectHoiDap.register(CellHoiDap.self, forCellWithReuseIdentifier: "Cell")
    }
    
}

extension HoiDapController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrHoiDap.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CellHoiDap
        cell.hoidap = arrHoiDap[indexPath.row]
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 7 //Kich thuoc giua 2 dong
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let dichuyen = CATransform3DTranslate(CATransform3DIdentity, 500, 0, 0)
        cell.layer.transform = dichuyen
        UIView.animate(withDuration: 1 , animations: {
            cell.layer.transform = CATransform3DIdentity
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let scr = HoiDapDetailController()
        scr.hoidap = arrHoiDap[indexPath.row]
        navigationController?.pushViewController(scr, animated: true)
    }

}
