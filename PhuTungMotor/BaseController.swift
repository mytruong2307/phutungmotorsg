//
//  BaseController.swift
//  PhuTungMotorSG
//
//  Created by admin on 12/16/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

var kh:KhachHang?
var gioHang:Array<GioHang> = []
var thanhtoan:Int = -1
var paramAdmin = Dictionary<String,String>()

class BaseController: UIViewController, UISearchBarDelegate {
    
    var arrMenu:Array<Array<String>> = []
    var arrIcon:Array<Array<UIImage>> = []
    let arrHeader:Array<String> = ["Tài khoản","Phụ tùng MotorSG"]
    let user:UserDefaults = UserDefaults()
    var isOpenMenu:Bool = false
    
    var center:NSLayoutConstraint!
    
    
    let uvMenu:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblCart:UILabel = {
        let v = UILabel()
        v.layer.cornerRadius = 11
        v.clipsToBounds = true
        v.textAlignment = .center
        v.textColor = Constants.MY_TEXT_COLOR
        v.backgroundColor = Constants.MY_BG_COLOR
        v.font = UIFont.boldSystemFont(ofSize: 15)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let imgCart:UIImageView = {
        let v = UIImageView()
        v.image = #imageLiteral(resourceName: "shopping")
        v.contentMode = .scaleToFill
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let uvMain:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let uvBackBase:UIView = {
        let v = UIView()
        v.backgroundColor = Constants.MY_BG_COLOR
        v.layer.cornerRadius = 10
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let uvFormBase:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let tbl:UITableView = {
        let tbl = UITableView(frame: CGRect.zero, style: UITableViewStyle.grouped)
        tbl.register(CellMenu.self, forCellReuseIdentifier: "CellMenu")
        tbl.translatesAutoresizingMaskIntoConstraints = false
        tbl.backgroundColor = UIColor.clear
        tbl.estimatedRowHeight = 100
        tbl.rowHeight = UITableViewAutomaticDimension
        return tbl
    }()
    
    let searchBar:UISearchBar = {
        let v = UISearchBar()
        v.showsCancelButton = true
        return v
    }()
    
    let uvCart:UIView = {
        let v = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
        return v
    }()
    
    let bn:UIImageView = {
        let v = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 40))
        v.image = #imageLiteral(resourceName: "banner")
        v.contentMode = .scaleToFill
        return v
    }()
    
    var cartBtn:UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupDataMenu()
        setupMenu()
        setupMainScreen()
        setupGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let totalAmount = gioHang.reduce(0) {$0 + $1.soluong}
        lblCart.text = String (totalAmount)
        if kh != nil {
            showLog(mess: kh!.quyen)
        }
        setupDataMenu()
        tbl.reloadData()
        UIView.animate(withDuration: 0.5) {
            self.navigationController?.navigationBar.layer.transform = CATransform3DIdentity
            self.uvMain.layer.transform = CATransform3DIdentity
        }
        showLog(mess: paramAdmin)
    }
    func setupNavigationBar() {
        self.navigationItem.titleView = bn
        //Gio hang
        uvCart.addViewFullScreen(views: imgCart)
        let viewTam = UIView()
        viewTam.backgroundColor = UIColor.clear
        uvCart.addViewFullScreen(views: viewTam)
        viewTam.addSubview(lblCart)
        lblCart.widthAnchor.constraint(equalToConstant: 22).isActive = true
        lblCart.heightAnchor.constraint(equalTo: lblCart.widthAnchor, multiplier: 1).isActive = true
        lblCart.centerXAnchor.constraint(equalTo: viewTam.centerXAnchor, constant: 8).isActive = true
        lblCart.centerYAnchor.constraint(equalTo: viewTam.centerYAnchor, constant: -8).isActive = true
        cartBtn = UIBarButtonItem(customView: uvCart)
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BaseController.shoppingCart))
        uvCart.addGestureRecognizer(tap)
        addHomeIcon()
        addMenuIcon()
    }
    
    func addMenuIcon()  {
        self.navigationItem.rightBarButtonItem = cartBtn
    }
    
    func addHomeIcon()  {
        let leftButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Menu Filled-50"), style: .plain, target: self, action: #selector(BaseController.openMenu))
        self.navigationItem.leftBarButtonItem = leftButton
        
        let searchBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "search"), style: .plain, target: self, action: #selector(BaseController.search))
        self.navigationItem.rightBarButtonItems = [searchBtn, cartBtn]
    }
    
    func shoppingCart() {
        if self is ShoppingController {
            showLog(mess: "No change")
        } else {
            if gioHang.count == 0 {
                showAlert(title: getAlertMessage(msg: ALERT.NOTICE), mess: getAlertMessage(msg: ALERT.EMPTYCART))
            } else {
                let scr = ShoppingController()
                navigationController?.pushViewController(scr, animated: true)
            }
        }
        
    }
    func search() {
        setTitleSearchBar()
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        navigationItem.leftBarButtonItems = []
        navigationItem.rightBarButtonItems = []
    }
    
    func setTitleSearchBar()  {
        searchBar.placeholder = getTextUI(ui: UI.SERBAR)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        navigationItem.titleView = bn
        setupNavigationBar()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let scr = SearchController()
        scr.keyword = searchBar.text!
        navigationController?.pushViewController(scr, animated: true)
    }
    
    func setupDataMenu() {
        if user.object(forKey: "email") != nil && kh == nil{
            let dic = user.object(forKey: "email") as! Dictionary<String,Any>
            kh = KhachHang(khachhang: dic)
        }
        if (kh == nil) {
            arrMenu = [["Đăng ký","Đăng nhập"],["Trang chủ","Tin tức","Hỏi đáp"]]
            arrIcon = [[#imageLiteral(resourceName: "key"),#imageLiteral(resourceName: "login")],[#imageLiteral(resourceName: "Home"),#imageLiteral(resourceName: "new"),#imageLiteral(resourceName: "faq")]]
        } else {
            if kh?.quyen.count == 0 {
                arrMenu = [["Đăng xuất","Đổi mật khẩu","Cập nhật thông tin"],["Trang chủ","Tin tức","Hỏi đáp","Đơn hàng"]]
                arrIcon = [[#imageLiteral(resourceName: "Logout"),#imageLiteral(resourceName: "key"),#imageLiteral(resourceName: "Contacts")],[#imageLiteral(resourceName: "Home"),#imageLiteral(resourceName: "new"),#imageLiteral(resourceName: "faq"),#imageLiteral(resourceName: "List")]]
            } else {
                arrMenu = [["Đăng xuất","Đổi mật khẩu","Cập nhật thông tin"],["Trang chủ","Tin tức","Hỏi đáp","Đơn hàng","Quản Trị"]]
                arrIcon = [[#imageLiteral(resourceName: "Logout"),#imageLiteral(resourceName: "key"),#imageLiteral(resourceName: "Contacts")],[#imageLiteral(resourceName: "Home"),#imageLiteral(resourceName: "new"),#imageLiteral(resourceName: "faq"),#imageLiteral(resourceName: "List"), #imageLiteral(resourceName: "admin")]]
            }
        }
    }
    
    func setupMenu() {
        view.addViewFullScreen(views: uvMenu)
        
        let imgBg = UIImageView()
        imgBg.image = #imageLiteral(resourceName: "background")
        uvMenu.addViewFullScreen(views: imgBg)
        
        let blurEffect = UIBlurEffect(style: .light)
        let visual = UIVisualEffectView(effect: blurEffect)
        uvMenu.addViewFullScreen(views: visual)
        
        let uvNav:UIView = UIView()
        uvMenu.addSubview(uvNav)
        uvMenu.addSubview(tbl)
        uvMenu.addContraintByVSF(VSF: "H:|[v0]|", views: uvNav)
        uvMenu.addContraintByVSF(VSF: "H:|[v0]|", views: tbl)
        uvMenu.addContraintByVSF(VSF: "V:|[v0(64)][v1]|", views: uvNav, tbl)
        
        tbl.delegate = self
        tbl.dataSource = self
    }
    
    func setupMainScreen() {
        //Gan view
        view.addSubview(uvMain)
        view.addContraintByVSF(VSF: "H:|[v0]|", views: uvMain)
        view.addContraintByVSF(VSF: "V:|-64-[v0]|", views: uvMain)
        setupBackground()
        addForm()
        
    }
    
    //Huy backgound mac dinh thi override lai ham nay o lop con
    func setupBackground() {
        //Hinh nen
        let img:UIImageView = UIImageView()
        uvMain.addViewFullScreen(views: img)
        img.image = #imageLiteral(resourceName: "bg4")
        
        //Visual Effect
        let blurEffect = UIBlurEffect(style: .light)
        let vis:UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
        uvMain.addViewFullScreen(views: vis)
    }
    
    //Huy Form mac dinh thi override lai ham nay o lop con
    func addForm() {
        //Add 2 view de chen form vao
        uvMain.addSubview(uvBackBase)
        uvMain.addSubview(uvFormBase)
        
        uvFormBase.centerXAnchor.constraint(equalTo: uvMain.centerXAnchor).isActive = true
        center = uvFormBase.centerYAnchor.constraint(equalTo: uvMain.centerYAnchor)
        center.isActive = true
        uvFormBase.widthAnchor.constraint(equalTo: uvMain.widthAnchor, multiplier: 0.85).isActive = true
        
        uvBackBase.leftAnchor.constraint(equalTo: uvFormBase.leftAnchor).isActive = true
        uvBackBase.topAnchor.constraint(equalTo: uvFormBase.topAnchor).isActive = true
        uvBackBase.widthAnchor.constraint(equalTo: uvFormBase.widthAnchor).isActive = true
        uvBackBase.heightAnchor.constraint(equalTo: uvFormBase.heightAnchor).isActive = true
    }
    
    func setupGesture() {
        let openMenu:UIScreenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer()
        openMenu.edges = .left
        let closeMenu:UISwipeGestureRecognizer = UISwipeGestureRecognizer()
        closeMenu.direction = .left
        uvMain.addGestureRecognizer(openMenu)
        uvMain.addGestureRecognizer(closeMenu)
        openMenu.addTarget(self, action: #selector(BaseController.openMenuByGesture(_:)))
        closeMenu.addTarget(self, action: #selector(BaseController.openMenuByGesture(_:)))
    }
    
    func openMenuByGesture(_ sender:AnyObject) {
        if sender.state == .ended {
            openMenu()
        }
    }
    
    func openMenu() {
        UIView.animate(withDuration: 1) {
            if !self.isOpenMenu {
                let dichuyen = CATransform3DTranslate(CATransform3DIdentity, UIScreen.main.bounds.width * 0.75, 0, 0)
                UIView.animate(withDuration: 0, animations: {
                    self.navigationController?.navigationBar.layer.transform = dichuyen
                    self.uvMain.layer.transform = dichuyen
                })
            } else {
                self.navigationController?.navigationBar.layer.transform = CATransform3DIdentity
                self.uvMain.layer.transform = CATransform3DIdentity
            }
            self.isOpenMenu = !self.isOpenMenu
        }
    }
}

extension BaseController:UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrMenu.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenu[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellMenu", for: indexPath) as! CellMenu
        cell.hinh = arrIcon[indexPath.section][indexPath.row]
        cell.ten = arrMenu[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let uv:UIView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.frame.height))
        uv.backgroundColor = Constants.MY_BG_COLOR
        let lbl:UILabel = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = Constants.MY_TEXT_COLOR
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.text = arrHeader[section]
        uv.addSubview(lbl)
        uv.addContraintByVSF(VSF: "H:|-10-[v0]", views: lbl)
        uv.addContraintByVSF(VSF: "V:|-13-[v0]", views: lbl)
        return uv
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5, animations: {
            self.openMenu()
        }) { (true) in
            switch indexPath.section {
            case 0:
                if kh == nil {
                    if indexPath.row == 0 {
                        let scr = RegisterController()
                        self.navigationController?.pushViewController(scr, animated: true)
                    } else if indexPath.row == 1 {
                        let scr = LoginController()
                        self.navigationController?.pushViewController(scr, animated: true)
                    }
                } else {
                    if indexPath.row == 0 {
                        kh = nil
                        if self.user.object(forKey: "email") != nil {
                            self.user.removeObject(forKey: "email")
                            self.user.synchronize()
                        }
                        if self is TrangChuController {
                            self.setupDataMenu()
                            tableView.reloadData()
                        } else {
                            let _ = self.navigationController?.popToRootViewController(animated: true)
                        }
                    } else if indexPath.row == 1 {
                        self.navigationController?.pushViewController(ChangePassController(), animated: true)
                    } else if indexPath.row == 2 {
                        self.navigationController?.pushViewController(UpdateInfoController(), animated: true)
                    }
                }
                break
            default:
                switch indexPath.row {
                case 0:
                    let _ = self.navigationController?.popToRootViewController(animated: true)
                    break
                case 1:
                    self.navigationController?.pushViewController(TinTucController(), animated: true)
                    break
                case 2:
                    self.navigationController?.pushViewController(HoiDapController(), animated: true)
                    break
                case 3:
                    self.navigationController?.pushViewController(DonHangController(), animated: true)
                    break
                default:
                    //Lay token truoc khi chuyen

                    sendRequestNoLoading(linkAPI: API.TOKEN, param: nil, method: .get, extraLink: "\(kh!.email)", completion: { (object) in
                        paramAdmin["token"] = object?["data"] as? String
                        paramAdmin["newToken"] = "0"
                        paramAdmin["truycap"] = "2"
                        showLog(mess: paramAdmin)
                        self.navigationController?.pushViewController(AdminController(), animated: true)
                    })
//                    self.navigationController?.pushViewController(AdminController(), animated: true)
                    break
                }
                break
            }
            
        }
        
    }
    
}



