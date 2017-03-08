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
    
    let btnDatCauHoi:MyButton = MyButton()
    var page = 1
    var arrHoiDap:Array<HoiDap> = []
    var arrAll:Array<HoiDap> = []
    var arrMySelf:Array<HoiDap> = []
    
    let numberItem = 8
    var flag = true
    var flagMy = true
    var posLoaded = 0
    let collectHoiDap:UICollectionView = {
        let v = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        v.contentInset = UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
        return v
    }()
    
    let btnAction:UISegmentedControl = {
        let v = UISegmentedControl()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblAction:UILabel = {
        let v = UILabel()
        v.text = getTextUI(ui: UI.LBL_ASKOBJECT)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let vTemp:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
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
        loadData()
    }
    
    func loadData() {
        if btnAction.selectedSegmentIndex == 1 {
            if flag {
                sendRequestNoLoading(linkAPI: API.FAQ, param: nil, method: Method.get, extraLink: "\(numberItem)/\(page)", completion: { (object) in
                    if let data = object?[getResultAPI(link: API.DATA_RETURN)] as? Array<Dictionary<String,Any>> {
                        self.page += 1
                        for hoidap in data {
                            self.arrAll.append(HoiDap(dic: hoidap))
                            self.arrHoiDap.append(HoiDap(dic: hoidap))
                        }
                        if data.count < self.numberItem {
                            self.flag = false
                        }
                    } else {
                        self.flag = false
                    }
                    self.collectHoiDap.reloadData()
                })
            } else {
                arrHoiDap = arrAll
            }
        } else {
            if flagMy {
                let extra = "\(numberItem)/\(page)/\(kh!.email)"
                sendRequestNoLoading(linkAPI: API.MYFAQ, param: nil, method: Method.get, extraLink: extra, completion: { (object) in
                    if let data = object?[getResultAPI(link: API.DATA_RETURN)] as? Array<Dictionary<String,Any>> {
                        self.page += 1
                        for hoidap in data {
                            self.arrMySelf.append(HoiDap(dic: hoidap))
                            self.arrHoiDap.append(HoiDap(dic: hoidap))
                        }
                        if data.count < self.numberItem {
                            self.flagMy = false
                        }
                    } else {
                        self.flagMy = false
                    }
                    self.collectHoiDap.reloadData()
                })
            } else {
                arrHoiDap = arrMySelf
            }
        }
    }
    
    
    func setupCollect()  {
        //Add segment
        
        btnDatCauHoi.setTitle(getTextUI(ui: UI.BTN_ASK), for: UIControlState.normal)
        uvMain.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        uvMain.addSubview(vTemp)
        uvMain.addSubview(collectHoiDap)
        uvMain.addSubview(btnDatCauHoi)
        
        uvMain.addContraintByVSF(VSF: "H:|-10-[v0]-10-|", views: collectHoiDap)
        uvMain.addContraintByVSF(VSF: "H:|-10-[v0]-10-|", views: vTemp)
        uvMain.addContraintByVSF(VSF: "H:|-10-[v0]-10-|", views: btnDatCauHoi)
        uvMain.addContraintByVSF(VSF: "V:|[v0][v1][v2]|", views: collectHoiDap, vTemp, btnDatCauHoi)
        collectHoiDap.delegate = self
        collectHoiDap.dataSource = self
        collectHoiDap.register(CellHoiDap.self, forCellWithReuseIdentifier: "Cell")
        collectHoiDap.register(CellBanner.self, forCellWithReuseIdentifier: "CellBanner")
        
        vTemp.addSubview(lblAction)
        vTemp.addSubview(btnAction)
        vTemp.addContraintByVSF(VSF: "V:|[v0]|", views: lblAction)
        vTemp.addContraintByVSF(VSF: "V:|[v0]|", views: btnAction)
        vTemp.addContraintByVSF(VSF: "H:|-20-[v0]-5-[v1]|", views: lblAction, btnAction)
        
        btnAction.insertSegment(withTitle: getTextUI(ui: UI.LBL_MYASK), at: 0, animated: true)
        btnAction.insertSegment(withTitle: getTextUI(ui: UI.LBL_ALLASK), at: 1, animated: true)
        btnAction.selectedSegmentIndex = 1
        btnAction.addTarget(self, action:#selector(HoiDapController.xemCauHoi(_:)), for: UIControlEvents.valueChanged)
        
        btnDatCauHoi.addTarget(self, action: #selector(HoiDapController.datCauHoi), for: UIControlEvents.touchUpInside)
    }
    
    func datCauHoi() {
        navigationController?.pushViewController(DatCauHoiController(), animated: true)
    }
    
    func xemCauHoi(_ sender:UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            if kh != nil {
                arrHoiDap = arrMySelf
                showLog(mess: arrHoiDap.count)
                page = arrMySelf.count / numberItem + 1
                loadData()
                flagMy = true
                flag = false
            } else {
                flagMy = false
                flag = true
                btnAction.selectedSegmentIndex = 1
                showAlert(title: getAlertMessage(msg: ALERT.NOTICE), mess: getAlertMessage(msg: ALERT.NOLOGIN))
            }
        } else {
            flagMy = false
            flag = true
            arrHoiDap = arrAll
            page = arrAll.count / numberItem + 1
            loadData()
        }
        collectHoiDap.reloadData()
    }
}

extension HoiDapController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrHoiDap.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellBanner", for: indexPath) as! CellBanner
            cell.image = #imageLiteral(resourceName: "question")
            cell.title =  getTextUI(ui: UI.LBL_LSTHOIDAP)
            cell.isSelected = false
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CellHoiDap
            cell.hoidap = arrHoiDap[indexPath.row - 1]
            cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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
        return 1 //Kich thuoc giua 2 dong
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (flag || flagMy) && posLoaded < indexPath.row {
            posLoaded = indexPath.row
            let dichuyen = CATransform3DTranslate(CATransform3DIdentity, 500, 0, 0)
            cell.layer.transform = dichuyen
            UIView.animate(withDuration: 1 , animations: {
                cell.layer.transform = CATransform3DIdentity
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let scr = HoiDapDetailController()
        scr.hoidap = arrHoiDap[indexPath.row]
        navigationController?.pushViewController(scr, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = 200 + CGFloat(arrHoiDap.count) * (90 + 1) - scrollView.frame.height
        showLog(mess: scrollView.contentOffset.y)
        showLog(mess: x)
        showLog(mess: page)
        if scrollView.contentOffset.y == x && (flag || flagMy)
        {
            loadData()
        }
    }
    
}
