//
//  HoiDapAdController.swift
//  PhuTungMotor
//
//  Created by admin on 3/7/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class HoiDapAdController: MenuAdminController {
    
    var arrHoiDap:Array<Array<HoiDap>> = []
    let arrTinhTrang:Array<Int> = [0,1,2,3]
    var arrState:Array<LoaiXe> = []
    let item = 4
    var pos = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector:  #selector(HoiDapAdController.viewMoreHoiDap), name: NSNotification.Name.init("viewMore"), object: nil)
//        setupDataCol()
        col.delegate = self
        col.dataSource = self
        col.register(CellHoiDap.self, forCellWithReuseIdentifier: "CellHoiDap")
        col.register(CellBanner.self, forCellWithReuseIdentifier: "CellBanner")
        col.register(HeaderSanPham.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pos = 0
        setupDataCol()
        col.reloadData()
    }
    
    func viewMoreHoiDap(object:Notification)  {
        let lx = object.object as! LoaiXe
        if lx.hinh == "" {
            let scr = LstHoiDapController()
            scr.loaixe = lx
            navigationController?.pushViewController(scr, animated: true)
        }
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
    
    func loadDataDeQui(i:Int)  {
        sendRequestAdmin(linkAPI: API.FAQ, param: paramAdmin, method: Method.post, extraLink: "1/\(i)/\(item)", completion: { (object) in
            if let data = object?[getResultAPI(link: API.DATA_RETURN)] as? Array<Dictionary<String,Any>> {
                //Append header
                var lx = LoaiXe()
                switch i {
                case 0:
                    lx.id = i
                    lx.ten = getTextUI(ui: UI.CHUATRALOI)
                    break
                case 1:
                    lx.id = i
                    lx.ten = getTextUI(ui: UI.CHUAXACNHAN)
                    break
                case 2:
                    lx.id = i
                    lx.ten = getTextUI(ui: UI.CHUADONG)
                    break
                default:
                    lx.id = i
                    lx.ten = getTextUI(ui: UI.DADONG)
                    break
                }
                self.arrState.append(lx)
                var arrTem:Array<HoiDap> = []
                for dic in data {
                    arrTem.append(HoiDap(dic: dic))
                }
                self.arrHoiDap.append(arrTem)
                self.col.reloadData()
                showLog(mess: self.arrState.count)
                showLog(mess: self.arrHoiDap.count)
            }
            self.pos += 1
            if self.pos < self.arrTinhTrang.count {
                self.loadDataDeQui(i: self.arrTinhTrang[self.pos])
            }
        })
    }
    
    func setupDataCol()  {
        arrHoiDap.removeAll()
        arrState.removeAll()
        var arrTem:Array<HoiDap> = []
        arrTem.append(HoiDap())
        arrHoiDap.append(arrTem)
        paramAdmin["truycap"] = "3"
        loadDataDeQui(i: arrTinhTrang[pos])
    }
    
}

extension HoiDapAdController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return arrHoiDap.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrHoiDap[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellBanner", for: indexPath) as! CellBanner
            cell.image = #imageLiteral(resourceName: "question")
            cell.title =  getTextUI(ui: UI.LBL_LSTHOIDAP)
            cell.isSelected = false
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellHoiDap", for: indexPath) as! CellHoiDap
            cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.hoidap = arrHoiDap[indexPath.section][indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! HeaderSanPham
            if indexPath.section == 0 {
                view.loaixe = LoaiXe()
            } else {
                showLog(mess: indexPath.section)
                showLog(mess: arrState.count)
                view.loaixe = arrState[indexPath.section - 1]
            }
            view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            return view
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if arrHoiDap.count == 0 || section == 0 {
            return CGSize.zero
        } else {
            return CGSize(width: view.frame.width, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width, height: 200)
        } else {
            return CGSize(width: collectionView.frame.width, height: 90)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let hoidap = arrHoiDap[indexPath.section][indexPath.row]
        actionHoiDap(hd: hoidap)
    }
    
}
