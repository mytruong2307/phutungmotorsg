//
//  Extension.swift
//  PhuTungMotor
//
//  Created by admin on 12/23/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
import UIKit

extension UIView
{
    func addContraintByVSF(VSF:String, views:UIView...) {
        var dic = Dictionary<String,Any>()
        for (index,view) in views.enumerated() {
            view.translatesAutoresizingMaskIntoConstraints = false
            dic["v\(index)"] = view
        }
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: VSF, options: NSLayoutFormatOptions(), metrics: nil, views: dic))
    }
    
    func addContraintByVSF(VSF:String, views:Array<UIView>) {
        var dic = Dictionary<String,Any>()
        for (index,view) in views.enumerated() {
            view.translatesAutoresizingMaskIntoConstraints = false
            dic["v\(index)"] = view
        }
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: VSF, options: NSLayoutFormatOptions(), metrics: nil, views: dic))
    }
    
    func addViewFullScreen(views:UIView...) {
        for view in views {
            self.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addContraintByVSF(VSF: "H:|[v0]|", views: view)
            self.addContraintByVSF(VSF: "V:|[v0]|", views: view)
        }
        
    }
    
    func addSubview(views:UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}

extension UIImageView
{
    func loadImageFromInternet(link:String) {
        let act:UIActivityIndicatorView = {
            let v = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
            v.color = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
            v.translatesAutoresizingMaskIntoConstraints = false
            return v
        }()
        
        self.addSubview(act)
        act.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        act.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        act.startAnimating()
        showLog(mess: link)
        let url = URL(string: link)
        do {
            let data:Data = try Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
                act.stopAnimating()
                act.hidesWhenStopped = true
            }
            
        } catch {
            DispatchQueue.main.async {
                self.image = #imageLiteral(resourceName: "logo")
                act.stopAnimating()
                act.hidesWhenStopped = true
            }
            printConsole(csl: CONSOLE(rawValue: "\(CONSOLE.URLERROR): \(link)")!)
        }
    }
}

extension Dictionary {
    func convertToString() -> String {
        var result = ""
        for (i, value) in self.enumerated() {
            if i == 0 {
                result += "\(value.key)=\(value.value)"
            } else {
                result += "&\(value.key)=\(value.value)"
            }
        }
        return result
    }
}

extension String {
    func getDate(full:Bool = true) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateFromString = dateFormatter.date(from: self)
        let dateFormatter2 = DateFormatter()
        if full {
            dateFormatter2.dateFormat = "dd/MM/YYYY"
            return dateFormatter2.string(from: dateFromString!)
        } else {
            dateFormatter2.dateFormat = "dd/MM"
            return dateFormatter2.string(from: dateFromString!)
        }
    }
    
    
    func getDurationTime() -> String {
        let cal = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let created = dateFormatter.date(from: self)
        
        let diff = cal.dateComponents([.day,.hour,.minute], from: created!, to: Date())
        if diff.day! == 0 {
            if diff.hour! <= 0 {
                if diff.minute == 0 {
                    return getTextUI(ui: UI.NOW)
                } else {
                    return "\(diff.minute!) " + getTextUI(ui: UI.MINUTE)
                }
            } else {
                return "\(diff.hour!) " + getTextUI(ui: UI.HOUR)
            }
        } else {
            if diff.day! > 365 {
                return getDate()
            } else if diff.day! > 14 {
                return getDate(full: false)
            } else {
                return "\(diff.day!) " + getTextUI(ui: UI.DAY)
            }
        }
    }
    
}

extension UIViewController
{
    func popToAdminController() {
        for viewController in (self.navigationController?.viewControllers)! {
            if viewController .isKind(of: AdminController.self) {
                let _ = self.navigationController?.popToViewController(viewController, animated: true)
            }
        }
    }
    
    func showAlert(title:String, mess:String) {
        let alert:UIAlertController = UIAlertController(title: title, message: mess, preferredStyle: .alert)
        let btnOK:UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(btnOK)
        present(alert, animated: true, completion: nil)
    }
    
    func showAlertActionOK(title:String, mess:String, complete:@escaping ()->()) {
        let alert:UIAlertController = UIAlertController(title: title, message: mess, preferredStyle: .alert)
        let btnOK:UIAlertAction = UIAlertAction(title: "OK", style: .default) { (btnOK) in
            complete()
        }
        alert.addAction(btnOK)
        present(alert, animated: true, completion: nil)
    }
    
    func showAlertAction(title:String, mess:String, complete:@escaping ()->()) {
        let alert:UIAlertController = UIAlertController(title: title, message: mess, preferredStyle: .alert)
        let btnOK:UIAlertAction = UIAlertAction(title: "OK", style: .default) { (btnOK) in
            complete()
        }
        let btnCancel:UIAlertAction = UIAlertAction(title: "Huỷ", style: .cancel, handler: nil)
        alert.addAction(btnOK)
        alert.addAction(btnCancel)
        present(alert, animated: true, completion: nil)
    }
    
    func showAlert2Action(title:String, mess:String, btnATitle:String, btnBTitle:String, actionA:@escaping ()->(), actionB:@escaping () -> ())  {
        let alert:UIAlertController = UIAlertController(title: title, message: mess, preferredStyle: .alert)
        let btnA:UIAlertAction = UIAlertAction(title: btnATitle, style: .default) { (btnA) in
            actionA()
        }
        let btnB:UIAlertAction = UIAlertAction(title: btnBTitle, style: .default) { (btnB) in
            actionB()
        }
        let btnCancel:UIAlertAction = UIAlertAction(title: "Huỷ", style: .cancel, handler: nil)
        alert.addAction(btnA)
        alert.addAction(btnB)
        alert.addAction(btnCancel)
        present(alert, animated: true, completion: nil)
    }
    
    func downloadImageSanPham(sp:SanPham, completion:@escaping (Array<UIImage>)->()) {
        // hien bieu tuong load khi gui
        let viewTam:UIView = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            return v
        }()
        
        view.addSubview(viewTam)
        view.addViewFullScreen(views: viewTam)
        //Hinh nen
        let img:UIImageView = UIImageView()
        viewTam.addViewFullScreen(views: img)
        img.image = #imageLiteral(resourceName: "bg4")
        
        //Visual Effect
        let blurEffect = UIBlurEffect(style: .light)
        let vis:UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
        viewTam.addViewFullScreen(views: vis)
        
        let act:UIActivityIndicatorView = {
            let v = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
            v.color = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
            v.translatesAutoresizingMaskIntoConstraints = false
            return v
        }()
        viewTam.addSubview(act)
        act.centerXAnchor.constraint(equalTo: viewTam.centerXAnchor).isActive = true
        act.centerYAnchor.constraint(equalTo: viewTam.centerYAnchor).isActive = true
        act.startAnimating()
        
        sendRequestThread(linkAPI: API.IMAGE, param: nil, method: Method.get, extraLink: "\(sp.id)") { (object) in
            if object != nil {
                if let res = object?[getResultAPI(link: API.DATA_RES)] as? String {
                    if res == getResultAPI(link: API.RES_OK) {
                        if let data = object?["data"] as? Array<Dictionary<String,Any>> {
                            var arr:Array<UIImage> = []
                            for i in data {
                                if let hinh = i["ten"] as? String {
                                    let link:String = getLinkImage(link: API.PRODUCT) + "/" + hinh
                                    self.getImageThread(link: link, completion: { (image) in
                                        arr.append(image)
                                        if arr.count == data.count {
                                            DispatchQueue.main.async {
                                                act.stopAnimating()
                                                act.hidesWhenStopped = true
                                                viewTam.removeFromSuperview()
                                                self.view.layoutIfNeeded()
                                                completion(arr)
                                            }
                                        }
                                    })
                                }
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            act.stopAnimating()
                            act.hidesWhenStopped = true
                            viewTam.removeFromSuperview()
                            self.view.layoutIfNeeded()
                        }
                    }
                }
            }
        }
    }
    
    func downloadImageNoload(sp:SanPham, completion:@escaping (Array<UIImage>)->()) {
        sendRequestNoLoading(linkAPI: API.IMAGE, param: nil, method: Method.get, extraLink: "\(sp.id)") { (object) in
            if object != nil {
                if let res = object?[getResultAPI(link: API.DATA_RES)] as? String {
                    if res == getResultAPI(link: API.RES_OK) {
                        if let data = object?["data"] as? Array<Dictionary<String,Any>> {
                            var arr:Array<UIImage> = []
                            for i in data {
                                if let hinh = i["ten"] as? String {
                                    let link:String = getLinkImage(link: API.PRODUCT) + "/" + hinh
                                    self.getImageThread(link: link, completion: { (image) in
                                        arr.append(image)
                                        if arr.count == data.count {
                                            DispatchQueue.main.async {
                                                completion(arr)
                                            }
                                        }
                                    })
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func isEmptyTextField(txt:UITextField ...) -> String
    {
        var result = "OK"
        for i in 0...txt.count - 1 {
            let text = txt[i].text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            if text == "" {
                result = getAlertMessage(msg: ALERT.EMPTYTEXTFIELD)
                txt[i].becomeFirstResponder()
                break
            }
        }
        return result
    }
    
    func isValidPassword(candidate:String)->Bool {
        let passRegex = "(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{8,15}"
        return NSPredicate(format: "SELF MATCHES %@", passRegex).evaluate(with: candidate)
    }
    
    func isValidEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    
    
    func loadJson(linkAPI:API, param:Dictionary<String,Any>? = nil, method:Method = .get, extraLink:String? = nil ,completion:@escaping (Any?)->()) {
        let viewTam:UIView = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            return v
        }()
        
        view.addSubview(viewTam)
        view.addViewFullScreen(views: viewTam)
        //Hinh nen
        let img:UIImageView = UIImageView()
        viewTam.addViewFullScreen(views: img)
        img.image = #imageLiteral(resourceName: "bg4")
        
        //Visual Effect
        let blurEffect = UIBlurEffect(style: .light)
        let vis:UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
        viewTam.addViewFullScreen(views: vis)
        
        let act:UIActivityIndicatorView = {
            let v = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
            v.color = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
            v.translatesAutoresizingMaskIntoConstraints = false
            return v
        }()
        viewTam.addSubview(act)
        act.centerXAnchor.constraint(equalTo: viewTam.centerXAnchor).isActive = true
        act.centerYAnchor.constraint(equalTo: viewTam.centerYAnchor).isActive = true
        act.startAnimating()
        
        var link = linkAPI.LINK_SERVICE
        
        if param != nil {
            if method != Method.post {
                if extraLink != nil || extraLink != "" {
                    //Dung cho Laravel Framwork
                    link += "/" + extraLink!
                } else {
                    link = link + "?" + (param?.convertToString())!
                }
            }
        }
        
        let url = URL(string: link)
        var request = URLRequest(url:url!)
        if method == Method.post {
            request.httpMethod = method.toString
            request.httpBody = param?.convertToString().data(using: String.Encoding.utf8)
        }
        let session = URLSession.shared
        session.dataTask(with: request) { (data, res, err) in
            if err == nil {
                do {
                    let object = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                    DispatchQueue.main.async {
                        act.stopAnimating()
                        act.hidesWhenStopped = true
                        viewTam.removeFromSuperview()
                        self.view.layoutIfNeeded()
                        completion(object)
                    }
                } catch{
                    DispatchQueue.main.async {
                        showLog(mess: CONSOLE.JSON)
                        showLog(mess: link)
                        completion(nil)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    showLog(mess: CONSOLE.URLERROR)
                    showLog(mess: link)
                    completion(nil)
                }
                
            }
            }.resume()
        
    }
    
    func getImageFromLink(link:String, completion: @escaping (UIImage)->()) {
        let queue = DispatchQueue(label: "loadhinh")
        queue.async {
            let url = URL(string: link)
            do {
                let data = try Data(contentsOf: url!)
                DispatchQueue.main.async {
                    completion(UIImage(data: data)!)
                }
            } catch {
                showLog(mess: "Loi load hinh: \(link)")
            }
            
        }
    }
    
    func getImageThread(link:String, completion: @escaping (UIImage)->()) {
        let queue = DispatchQueue(label: "loadhinh")
        queue.async {
            let url = URL(string: link)
            do {
                let data = try Data(contentsOf: url!)
                completion(UIImage(data: data)!)
                
            } catch {
                showLog(mess: "Loi load hinh: \(link)")
            }
            
        }
        
    }
    
    func sendRequestToServer(linkAPI:API, param:Dictionary<String,Any>? = nil, method:Method = .get, extraLink:String? = nil ,completion:@escaping (Dictionary<String,Any>?)->()) {
        // hien bieu tuong load khi gui
        let viewTam:UIView = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            return v
        }()
        
        view.addSubview(viewTam)
        view.addViewFullScreen(views: viewTam)
        //Hinh nen
        let img:UIImageView = UIImageView()
        viewTam.addViewFullScreen(views: img)
        img.image = #imageLiteral(resourceName: "bg4")
        
        //Visual Effect
        let blurEffect = UIBlurEffect(style: .light)
        let vis:UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
        viewTam.addViewFullScreen(views: vis)
        
        let act:UIActivityIndicatorView = {
            let v = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
            v.color = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
            v.translatesAutoresizingMaskIntoConstraints = false
            return v
        }()
        viewTam.addSubview(act)
        act.centerXAnchor.constraint(equalTo: viewTam.centerXAnchor).isActive = true
        act.centerYAnchor.constraint(equalTo: viewTam.centerYAnchor).isActive = true
        act.startAnimating()
        
        var link = linkAPI.LINK_SERVICE
        if method == .get {
            if param != nil {
                link = link + "?" + (param?.convertToString())!
            }
        }
        if extraLink != nil {
            link = link + "/" + extraLink! // For Laravel
        }
        showLog(mess: link)
        let url = URL(string: link)
        var request = URLRequest(url:url!)
        if method == .post {
            let boundary = generateBoundaryString()
            let body = NSMutableData()
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            for pr in param!{
                if let image:UIImage = pr.value as? UIImage
                {
                    let data = UIImageJPEGRepresentation(image, 0.5)
                    let fname:String = "\(getTime()).jpg"
                    let mimetype = "image/png"
                    body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
                    body.append("Content-Disposition:form-data; name=\"\(pr.key)\"; FileName=\"\(fname)\"\r\n".data(using: String.Encoding.utf8)!)
                    body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
                    body.append(data!)
                    body.append("\r\n".data(using: String.Encoding.utf8)!)
                }else{
                    //----------upload them param
                    body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
                    body.append("Content-Disposition: form-data; name=\"\(pr.key)\"\r\n\r\n".data(using: String.Encoding.utf8)!)
                    body.append("\(pr.value)\r\n".data(using: String.Encoding.utf8)!)
                }
                //    body.append("&ten=datnguyen".data(using: String.Encoding.utf8)!)
                request.httpMethod = "POST"
                request.httpBody = body as Data
            }
        }
        let session = URLSession.shared
        session.dataTask(with: request) { (data, res, err) in
            if err == nil {
                do {
                    showLog(mess: data!)
                    let data = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                    if let object = data as? Dictionary<String,Any> {
                        DispatchQueue.main.async {
                            act.stopAnimating()
                            act.hidesWhenStopped = true
                            viewTam.removeFromSuperview()
                            self.view.layoutIfNeeded()
                            completion(object)
                        }
                    } else {
                        printConsole(csl: CONSOLE.DICTIONARY)
                        DispatchQueue.main.async {
                            act.stopAnimating()
                            act.hidesWhenStopped = true
                            viewTam.removeFromSuperview()
                            self.view.layoutIfNeeded()
                            showLog(mess: link)
                            completion(nil)
                        }
                    }
                } catch{
                    printConsole(csl: CONSOLE.JSON)
                    DispatchQueue.main.async {
                        act.stopAnimating()
                        act.hidesWhenStopped = true
                        viewTam.removeFromSuperview()
                        self.view.layoutIfNeeded()
                        showLog(mess: link)
                        completion(nil)
                    }
                }
            } else {
                printConsole(csl: CONSOLE.URLERROR)
                showLog(mess: link)
                DispatchQueue.main.async {
                    act.stopAnimating()
                    act.hidesWhenStopped = true
                    viewTam.removeFromSuperview()
                    self.view.layoutIfNeeded()
                    completion(nil)
                }
                
            }
            }.resume()
    }
    
    func sendRequestAdmin(linkAPI:API, param:Dictionary<String,Any>? = paramAdmin, method:Method = .post, extraLink:String? = nil ,completion:@escaping (Dictionary<String,Any>?)->()) {
        
        var link = linkAPI.LINK_ADMIN
        if extraLink != nil {
            link = link + "/" + extraLink! // For Laravel
        }
        showLog(mess: link)
        let url = URL(string: link)
        var request = URLRequest(url:url!)
        if method == .post {
            
            request.httpMethod = method.toString
            let data = param?.convertToString().data(using: String.Encoding.utf8)
            request.httpBody = data
        }
        let session = URLSession.shared
        session.dataTask(with: request) { (data, res, err) in
            if err == nil {
                do {
                    let object = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                    if let data = object as? Dictionary<String,Any> {
                        DispatchQueue.main.async {
                            showLog(mess: data)
                            let res = data[getResultAPI(link: API.DATA_RES)] as! String
                            if res == getResultAPI(link: API.RES_OK) {
                                let nhanvien = data["nv"] as! Dictionary<String,Any>
                                let email = nhanvien["email"] as! String
                                showLog(mess: email)
                                showLog(mess: kh!.email)
                                if email == kh?.email {
                                    paramAdmin["token"] = nhanvien["maxacnhan"] as? String
                                    if paramAdmin["newToken"] == "1" {
                                        paramAdmin["newToken"] = "0"
                                    }
                                    completion(data)
                                } else {
                                    self.showAlertActionOK(title: getAlertMessage(msg: ALERT.ERROR), mess: getAlertMessage(msg: ALERT.DIFERRENTUSER), complete: {
                                        let _ = self.navigationController?.popToRootViewController(animated: true)
                                    })
                                    
                                }
                            } else {
                                self.showAlertActionOK(title: getAlertMessage(msg: ALERT.ERROR), mess: getAlertMessage(msg: ALERT.NOPERMISSION), complete: {
                                    let _ = self.navigationController?.popToRootViewController(animated: true)
                                })
                            }
                        }
                    } else {
                        printConsole(csl: CONSOLE.DICTIONARY)
                        showLog(mess: link)
                        DispatchQueue.main.async {
                            completion(nil)
                        }
                    }
                } catch{
                    showLog(mess: link)
                    printConsole(csl: CONSOLE.JSON)
                    DispatchQueue.main.async {
                        showLog(mess: link)
                        completion(nil)
                    }
                }
            } else {
                printConsole(csl: CONSOLE.URLERROR)
                DispatchQueue.main.async {
                    showLog(mess: link)
                    completion(nil)
                }
                
            }
            }.resume()
    }
    
    func sendRequestAdmin(linkAPI:String, param:Dictionary<String,Any>? = paramAdmin, method:Method = .post, extraLink:String? = nil ,completion:@escaping (Dictionary<String,Any>?)->()) {
        
        var link = linkAPI
        if extraLink != nil {
            link = link + "/" + extraLink! // For Laravel
        }
        showLog(mess: link)
        let url = URL(string: link)
        var request = URLRequest(url:url!)
        if method == .post {
            
            request.httpMethod = method.toString
            let data = param?.convertToString().data(using: String.Encoding.utf8)
            request.httpBody = data
        }
        let session = URLSession.shared
        session.dataTask(with: request) { (data, res, err) in
            if err == nil {
                do {
                    showLog(mess: data!)
                    let object = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                    if let data = object as? Dictionary<String,Any> {
                        DispatchQueue.main.async {
                            let res = data[getResultAPI(link: API.DATA_RES)] as! String
                            if res == getResultAPI(link: API.RES_OK) {
                                let nv = data["nv"] as! Dictionary<String,Any>
                                let email = nv["email"] as! String
                                if email == kh?.email {
                                    paramAdmin["token"] = nv["maxacnhan"] as? String
                                    if paramAdmin["newToken"] == "1" {
                                        paramAdmin["newToken"] = "0"
                                    }
                                    paramAdmin["quyen"] = nv["quyen"] as? String
                                    showLog(mess: paramAdmin)
                                    completion(data)
                                } else {
                                    //Khong co quyen
                                    let err = data[getResultAPI(link: API.DATA_ERR)] as! String
                                    self.showAlertActionOK(title: getAlertMessage(msg: ALERT.ERROR), mess: err, complete: {
                                        let _ = self.navigationController?.popToRootViewController(animated: true)
                                    })
                                    
                                }
                            } else {
                                //Khong co quyen
                                let err = data[getResultAPI(link: API.DATA_ERR)] as! String
                                self.showAlertActionOK(title: getAlertMessage(msg: ALERT.ERROR), mess: err, complete: {
                                    let _ = self.navigationController?.popToRootViewController(animated: true)
                                })
                            }
                        }
                    } else {
                        printConsole(csl: CONSOLE.DICTIONARY)
                        showLog(mess: link)
                        DispatchQueue.main.async {
                            completion(nil)
                        }
                    }
                } catch{
                    showLog(mess: link)
                    printConsole(csl: CONSOLE.JSON)
                    DispatchQueue.main.async {
                        showLog(mess: link)
                        completion(nil)
                    }
                }
            } else {
                printConsole(csl: CONSOLE.URLERROR)
                DispatchQueue.main.async {
                    showLog(mess: link)
                    completion(nil)
                }
                
            }
            }.resume()
    }

    
    func sendRequestThread(linkAPI:API, param:Dictionary<String,Any>? = nil, method:Method = .get, extraLink:String? = nil ,completion:@escaping (Dictionary<String,Any>?)->()) {
        // hien bieu tuong load khi gui
        let viewTam:UIView = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            return v
        }()
        
        view.addSubview(viewTam)
        view.addViewFullScreen(views: viewTam)
        //Hinh nen
        let img:UIImageView = UIImageView()
        viewTam.addViewFullScreen(views: img)
        img.image = #imageLiteral(resourceName: "bg4")
        
        //Visual Effect
        let blurEffect = UIBlurEffect(style: .light)
        let vis:UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
        viewTam.addViewFullScreen(views: vis)
        
        let act:UIActivityIndicatorView = {
            let v = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
            v.color = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
            v.translatesAutoresizingMaskIntoConstraints = false
            return v
        }()
        viewTam.addSubview(act)
        act.centerXAnchor.constraint(equalTo: viewTam.centerXAnchor).isActive = true
        act.centerYAnchor.constraint(equalTo: viewTam.centerYAnchor).isActive = true
        act.startAnimating()
        
        var link = linkAPI.LINK_SERVICE
        if method == .get {
            if param != nil {
                link = link + "?" + (param?.convertToString())!
            }
        }
        if extraLink != nil {
            link = link + "/" + extraLink! // For Laravel
        }
        showLog(mess: link)
        let url = URL(string: link)
        var request = URLRequest(url:url!)
        if method == .post {
            let boundary = generateBoundaryString()
            let body = NSMutableData()
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            for pr in param!{
                if let image:UIImage = pr.value as? UIImage
                {
                    let data = UIImageJPEGRepresentation(image, 0.5)
                    let fname:String = "\(getTime()).jpg"
                    let mimetype = "image/png"
                    body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
                    body.append("Content-Disposition:form-data; name=\"\(pr.key)\"; FileName=\"\(fname)\"\r\n".data(using: String.Encoding.utf8)!)
                    body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
                    body.append(data!)
                    body.append("\r\n".data(using: String.Encoding.utf8)!)
                }else{
                    //----------upload them param
                    body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
                    body.append("Content-Disposition: form-data; name=\"\(pr.key)\"\r\n\r\n".data(using: String.Encoding.utf8)!)
                    body.append("\(pr.value)\r\n".data(using: String.Encoding.utf8)!)
                }
                //    body.append("&ten=datnguyen".data(using: String.Encoding.utf8)!)
                request.httpMethod = "POST"
                request.httpBody = body as Data
            }
        }
        let session = URLSession.shared
        session.dataTask(with: request) { (data, res, err) in
            if err == nil {
                do {
                    showLog(mess: data!)
                    let data = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                    if let object = data as? Dictionary<String,Any> {
                        completion(object)
                        DispatchQueue.main.async {
                            act.stopAnimating()
                            act.hidesWhenStopped = true
                            viewTam.removeFromSuperview()
                            self.view.layoutIfNeeded()
                        }
                    } else {
                        printConsole(csl: CONSOLE.DICTIONARY)
                        completion(nil)
                        DispatchQueue.main.async {
                            act.stopAnimating()
                            act.hidesWhenStopped = true
                            viewTam.removeFromSuperview()
                            self.view.layoutIfNeeded()
                            showLog(mess: link)
                        }
                    }
                } catch{
                    printConsole(csl: CONSOLE.JSON)
                    completion(nil)
                    DispatchQueue.main.async {
                        act.stopAnimating()
                        act.hidesWhenStopped = true
                        viewTam.removeFromSuperview()
                        self.view.layoutIfNeeded()
                        showLog(mess: link)
                    }
                }
            } else {
                printConsole(csl: CONSOLE.URLERROR)
                completion(nil)
                showLog(mess: link)
                DispatchQueue.main.async {
                    act.stopAnimating()
                    act.hidesWhenStopped = true
                    viewTam.removeFromSuperview()
                    self.view.layoutIfNeeded()
                }
            }
        }.resume()
    }

    func actionHoiDap(hd:HoiDap) {
        switch hd.trangthai {
        case 0:
            let scr = TraLoiHoiDapController()
            scr.hoiDap = hd
            navigationController?.pushViewController(scr, animated: true)
            break
        case 1:
            if paramAdmin["quyen"] == "1" || paramAdmin["quyen"] == "10" {
                let scr = XacNhanHDController()
                scr.hoiDap = hd
                self.navigationController?.pushViewController(scr, animated: true)
            } else {
                showAlert2Action(title: getAlertMessage(msg: .NOTICE), mess: getAlertMessage(msg: ALERT.CHONTRANG), btnATitle: getAlertMessage(msg: ALERT.SUACAUTRALOI), btnBTitle: getAlertMessage(msg: ALERT.VIEWHOIDAP), actionA: {
                    let scr = TraLoiHoiDapController()
                    scr.hoiDap = hd
                    self.navigationController?.pushViewController(scr, animated: true)
                }, actionB: { 
                    let scr = HoiDapDetailController()
                    scr.hoidap = hd
                    self.navigationController?.pushViewController(scr, animated: true)
                })
            }
            break
        default:
            if paramAdmin["quyen"] == "10"{
                showAlert2Action(title: getAlertMessage(msg: .NOTICE), mess: getAlertMessage(msg: ALERT.CHONTRANG), btnATitle: getAlertMessage(msg: ALERT.SUACAUTRALOI), btnBTitle: getAlertMessage(msg: ALERT.VIEWHOIDAP), actionA: {
                    let scr = TraLoiHoiDapController()
                    scr.hoiDap = hd
                    self.navigationController?.pushViewController(scr, animated: true)
                }, actionB: {
                    let scr = HoiDapDetailController()
                    scr.hoidap = hd
                    self.navigationController?.pushViewController(scr, animated: true)
                })
            } else {
                let scr = HoiDapDetailController()
                scr.hoidap = hd
                self.navigationController?.pushViewController(scr, animated: true)
            }
            break
        }
    }
}

func sendRequestNoLoading(linkAPI:API, param:Dictionary<String,Any>? = nil, method:Method = .get, extraLink:String? = nil ,completion:@escaping (Dictionary<String,Any>?)->()) {
    
    var link = linkAPI.LINK_SERVICE
    if method == .get {
        if param != nil {
            link = link + "?" + (param?.convertToString())!
        }
    }
    if extraLink != nil {
        link = link + "/" + extraLink! // For Laravel
    }
    showLog(mess: link)
    let url = URL(string: link)
    var request = URLRequest(url:url!)
    if method == .post {
        
        request.httpMethod = method.toString
        let data = param?.convertToString().data(using: String.Encoding.utf8)
        request.httpBody = data
    }
    let session = URLSession.shared
    session.dataTask(with: request) { (data, res, err) in
        if err == nil {
            do {
                showLog(mess: data!)
                let data = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                if let object = data as? Dictionary<String,Any> {
                    DispatchQueue.main.async {
                        completion(object)
                    }
                } else {
                    printConsole(csl: CONSOLE.DICTIONARY)
                    showLog(mess: link)
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            } catch{
                showLog(mess: link)
                printConsole(csl: CONSOLE.JSON)
                DispatchQueue.main.async {
                    showLog(mess: link)
                    completion(nil)
                }
            }
        } else {
            printConsole(csl: CONSOLE.URLERROR)
            DispatchQueue.main.async {
                showLog(mess: link)
                completion(nil)
            }
            
        }
        }.resume()
}



func sendRequestNoLoading(linkurl:String, param:Dictionary<String,Any>? = nil, method:Method = .get, extraLink:String? = nil ,completion:@escaping (Dictionary<String,Any>?)->()) {
    
    var link = linkurl
    if extraLink != nil {
        link = link + "/" + extraLink! // For Laravel
    }
    showLog(mess: link)
    let url = URL(string: link)
    var request = URLRequest(url:url!)
    if method == .post {
        
        request.httpMethod = method.toString
        let data = param?.convertToString().data(using: String.Encoding.utf8)
        request.httpBody = data
    }
    let session = URLSession.shared
    session.dataTask(with: request) { (data, res, err) in
        if err == nil {
            do {
                showLog(mess: data!)
                let data = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                if let object = data as? Dictionary<String,Any> {
                    DispatchQueue.main.async {
                        completion(object)
                    }
                } else {
                    printConsole(csl: CONSOLE.DICTIONARY)
                    showLog(mess: link)
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            } catch{
                showLog(mess: link)
                printConsole(csl: CONSOLE.JSON)
                DispatchQueue.main.async {
                    showLog(mess: link)
                    completion(nil)
                }
            }
        } else {
            printConsole(csl: CONSOLE.URLERROR)
            DispatchQueue.main.async {
                showLog(mess: link)
                completion(nil)
            }
            
        }
        }.resume()
}


func getJson(link:String, completion:@escaping (Any?)->()) {
    showLog(mess: link)
    let url = URL(string: link)
    let request = URLRequest(url:url!)
    let session = URLSession.shared
    session.dataTask(with: request) { (data, res, err) in
        if err == nil {
            do {
                let object = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                DispatchQueue.main.async {
                    completion(object)
                }
            } catch{
                DispatchQueue.main.async {
                    printConsole(csl: CONSOLE.JSON)
                    completion(nil)
                }
            }
        } else {
            DispatchQueue.main.async {
                printConsole(csl: CONSOLE.URLERROR)
                completion(nil)
            }
            
        }
        }.resume()
}



func getSubString(str:String, findStart:String, findEnd:String) -> String? {
    if let range1: Range<String.Index> = str.range(of: findStart) {
        var index = str.distance(from: str.startIndex, to: range1.lowerBound)
        var start = str.index(str.startIndex, offsetBy: index)
        let tam:String = str.substring(from: start)
        if let range: Range<String.Index> = tam.range(of: findEnd) {
            index = tam.distance(from: tam.startIndex, to: range.lowerBound)
            start = str.index(str.startIndex, offsetBy: index + findEnd.characters.count)
            return tam.substring(to: start)
        } else {
            return nil
        }
    } else {
        return nil
    }
}
func getSubString(str:String, findEnd:String) -> String? {
    if let range: Range<String.Index> = str.range(of: findEnd) {
        let index = str.distance(from: str.startIndex, to: range.lowerBound)
        let start = str.index(str.startIndex, offsetBy: index)
        return str.substring(to: start)
    } else {
        return nil
    }
}

func convertDateFromMySQL(strFromMySql:String) -> String? {
    var time:String = ""
    if let str = getSubString(str: strFromMySql, findEnd: " ") {
        var tam = str
        while let tg = getSubString(str: tam, findEnd: "-") {
            if time == "" {
                time = tg
            } else {
                time = tg + "/" + time
            }
            tam = tam.replacingOccurrences(of: "\(tg)-", with: "")
        }
        return tam + "/" + time
    } else {
        return nil
    }
}

func ramdomString(numberCharacter:Int,characters:Array<Character>?) -> String{
    let charactersDefault:Array<Character> = ["q","w","e","r","t","y","u","i","o","p","a","s","d","f","g","h","j","k","l","z","x","c","v","b","n","m","Q","W","E","R","T","Y","U","I","O","P","A","S","D","F","G","H","J","K","L","Z","X","C","V","B","N","M","1","2","3","4","5","6","7","8","9","0","!","@","#","$","%","^","&"]
    var str:String = ""
    for _ in 1...numberCharacter{
        if let characters = characters{
            let rd:Int = Int(arc4random()) % characters.count
            str += "\(characters[rd])"
        }else{
            let rd:Int = Int(arc4random()) % charactersDefault.count
            str += "\(charactersDefault[rd])"
        }
    }
    return str
}

func showLog(mess:Any) {
    print("------------------------------------------------------------------------")
    print(mess)
    print("------------------------------------------------------------------------")
}

func getTextUI(ui:UI) -> String {
    return ui.getText()
}
func getLinkService(link:API) -> String {
    return link.getLinkService()
}

func getLinkAdminSer(link:API) -> String {
    return link.getLinkAdminSer()
}

func getLinkImage(link:API) -> String {
    return link.getLinkImage()
}

func getResultAPI(link:API) -> String {
    return link.getString()
}
func getAlertMessage(msg:ALERT) -> String {
    return msg.getAlertMessage()
}
func printConsole(csl:CONSOLE) {
    csl.printConsole()
}

func generateBoundaryString() -> String
{
    return "Boundary-\(NSUUID().uuidString)"
}

func getTime() -> String{
    let date = Date()
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    let minutes = calendar.component(.minute, from: date)
    let second = calendar.component(.second, from: date)
    let nano = calendar.component(.nanosecond, from: date)
    return "\(hour)-\(minutes)-\(second)-\(nano)"
}
func getDate()->String{
    let date = Date()
    let calendar = Calendar.current
    let day = calendar.component(.day, from: date)
    let month = calendar.component(.month, from: date)
    let year = calendar.component(.year, from: date)
    let hour = calendar.component(.hour, from: date)
    let minutes = calendar.component(.minute, from: date)
    return "\(day)/\(month)/\(year) \(hour):\(minutes)"
}

func showPrice(sp:SanPham)->NSMutableAttributedString{
    let giagoc:Double = sp.giamgia + sp.gia
    let gg = showVNCurrency(gia: giagoc)
    let result:NSMutableAttributedString = NSMutableAttributedString(string: gg)
    result.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, result.length))
    return result
}

func showVNCurrency(gia:Double) -> String {
    var giamoi:IntMax = IntMax (gia)
    var result:String = ""
    while giamoi >= 1000 {
        let du = showNumber (so: giamoi % 1000)
        if result != "" {
            result = "\(du).\(result)"
        } else {
            result = "\(du)"
        }
        
        giamoi = giamoi / 1000
    }
    result = "\(giamoi).\(result)"
    return result
}
func showNumber(so:IntMax)->String {
    var kq:String = ""
    if so < 10 {
        kq =  "00\(so)"
    } else if so < 100 {
        kq = "0\(so)"
    } else {
        kq = "\(so)"
    }
    return kq
    
}

