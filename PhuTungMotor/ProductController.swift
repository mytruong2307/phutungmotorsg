//
//  ProductController.swift
//  PhuTungMotor
//
//  Created by admin on 2/10/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

class ProductController: BaseController {
    
    let colSanPham:UICollectionView = {
        let scrDirection = UICollectionViewFlowLayout()
        scrDirection.scrollDirection = .vertical
        let v = UICollectionView(frame: CGRect.zero, collectionViewLayout: scrDirection)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return v
    }()
    
    let colLoaiXe:UICollectionView = {
        let scrDirection = UICollectionViewFlowLayout()
        scrDirection.scrollDirection = .horizontal
        let v = UICollectionView(frame: CGRect.zero, collectionViewLayout: scrDirection)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.register(CellLoaiXe.self, forCellWithReuseIdentifier: "CellLoaiXe")
        v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return v
    }()
    
    let uvLoaiXe:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector:  #selector(ProductController.viewMoreProduct), name: NSNotification.Name.init("viewMore"), object: nil)
        setupColLoaiXe()
        colLoaiXe.delegate = self
        colLoaiXe.dataSource = self
        setupColSanPham()
        setupDataSanPham()
    }
    
    func viewMoreProduct(object:Notification)  {
        let lx = object.object as! LoaiXe
        if let t = arrLoaiXe.index(where: { $0.id == lx.id }) {
            showProduct(loaixe: lx, pos: t)
        } else {
            showProduct(loaixe: lx, pos: 0)
        }
    }
    
    func setupColSanPham() {
        uvMain.addSubview(colSanPham)
        colSanPham.leftAnchor.constraint(equalTo: uvMain.leftAnchor, constant: 5).isActive = true
        colSanPham.topAnchor.constraint(equalTo: uvMain.topAnchor, constant: 0).isActive = true
        colSanPham.bottomAnchor.constraint(equalTo: uvLoaiXe.topAnchor, constant: 0).isActive = true
        colSanPham.rightAnchor.constraint(equalTo: uvMain.rightAnchor, constant: -5).isActive = true
    }
    
    func setupColLoaiXe() {
        uvMain.addSubview(uvLoaiXe)
        uvLoaiXe.bottomAnchor.constraint(equalTo: uvMain.bottomAnchor, constant: 0).isActive = true
        uvLoaiXe.heightAnchor.constraint(equalToConstant: 30).isActive = true
        uvLoaiXe.rightAnchor.constraint(equalTo: uvMain.rightAnchor, constant: -5).isActive = true
        uvLoaiXe.leftAnchor.constraint(equalTo: uvMain.leftAnchor, constant: 5).isActive = true
        uvLoaiXe.addViewFullScreen(views: colLoaiXe)
    }
    
    func setupDataLoaiXe() {
        if arrLoaiXe.count == 0 {
            sendRequestNoLoading(linkAPI: API.BIKETYPE) { (object) in
                if object?[getResultAPI(link: API.DATA_RES)] as! String == getResultAPI(link: API.RES_OK) {
                    if let data = object?[getResultAPI(link: API.DATA_RETURN)] as? Array<Dictionary<String,Any>> {
                        for i in data {
                            arrLoaiXe.append(LoaiXe(loaixe: i))
                        }
                        self.colLoaiXe.reloadData()
                        self.setupDataSanPham()
                    }
                }
            }
        }
    }
    
    func setupDataSanPham()  {
        
    }
    override func addMenuIcon() {
        //Huy Icon menu
    }
    
    override func setupBackground() {
        //Huy setup background cho nen
    }
    
    override func addForm() {
        //Huy form
    }
    
    
    
}

extension ProductController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrLoaiXe.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellLoaiXe", for: indexPath) as! CellLoaiXe
        cell.loaixe = arrLoaiXe[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 30)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showProduct(loaixe: arrLoaiXe[indexPath.row], pos: indexPath.row)
        showLog(mess: "didSelectItemAt ProductController")
    }
    
    func showProduct(loaixe:LoaiXe, pos:Int)  {
        let lx:LoaiXeController = LoaiXeController()
        lx.loaixe = loaixe
        lx.pos = pos
        navigationController?.pushViewController(lx, animated: true)
    }
}
