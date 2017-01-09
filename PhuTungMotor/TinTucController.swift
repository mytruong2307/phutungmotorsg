//
//  TinTucController.swift
//  PhuTungMotor
//
//  Created by admin on 1/2/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class TinTucController: BaseController {
    
    var arrTinTuc:Array<TinTuc> = []
    let collectTinTuc:UICollectionView = {
        let v = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        v.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendRequestToServer(linkAPI: API.NEWS, param: nil, method: Method.get, extraLink: nil) { (data) in
            if data?[getResultAPI(link: API.DATA_RES)] as! String == getResultAPI(link: API.RES_OK) {
                if let tintuc = data?[getResultAPI(link: API.DATA_RETURN)] as? Array<Dictionary<String,Any>> {
                    for dic in tintuc {
                        self.arrTinTuc.append(TinTuc(dic: dic))
                    }
                    self.collectTinTuc.reloadData()
                }
            }
        }
        setupCollectionView()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func setupBackground() {
        //Huy background
    }

    override func addHomeIcon() {
        //Huy home menu
    }
    
    override func addForm() {
        //Huy form
    }
    
    func setupCollectionView() {
        uvMain.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        uvMain.addSubview(collectTinTuc)
        uvMain.addContraintByVSF(VSF: "H:|-5-[v0]-5-|", views: collectTinTuc)
        uvMain.addContraintByVSF(VSF: "V:|-5-[v0]-5-|", views: collectTinTuc)
        collectTinTuc.delegate = self
        collectTinTuc.dataSource = self
        collectTinTuc.register(CellTinTuc.self, forCellWithReuseIdentifier: "Cell")
    }
}

extension TinTucController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrTinTuc.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CellTinTuc
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.tintuc = arrTinTuc[indexPath.row]
        cell.linkHinh = getLinkImage(link: API.NEWS)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/2 - 8, height: 300)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 7 //Kich thuoc giua 2 dong
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        let thunho = CATransform3DScale(CATransform3DIdentity, 0.1, 0.1, 1)
        cell.layer.transform = thunho
        UIView.animate(withDuration: 1 , animations: {
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let scr = TinTucDetailController()
        scr.tintuc = arrTinTuc[indexPath.row]
        scr.linkHinh = getLinkImage(link: API.NEWS)
        navigationController?.pushViewController(scr, animated: true)
    }
}
