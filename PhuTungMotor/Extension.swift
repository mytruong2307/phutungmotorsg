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
        
        let url = URL(string: link)
        do {
            let data:Data = try Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
                act.stopAnimating()
                act.hidesWhenStopped = true
            }
            
        } catch {
            printConsole(csl: CONSOLE.URLERROR)
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
    
    
    func isEmptyTextField(txt:UITextField ...) -> String
    {
        var result = "OK"
        for i in 0...txt.count - 1 {
            if txt[i].text == "" {
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
                        completion(nil)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    showLog(mess: CONSOLE.URLERROR)
                    completion(nil)
                }
                
            }
        }.resume()
        
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
                        completion(nil)
                    }
                }
            } else {
                printConsole(csl: CONSOLE.URLERROR)
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
                let data = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                if let object = data as? Dictionary<String,Any> {
                    DispatchQueue.main.async {
                        completion(object)
                    }
                } else {
                    printConsole(csl: CONSOLE.DICTIONARY)
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            } catch{
                printConsole(csl: CONSOLE.JSON)
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        } else {
            printConsole(csl: CONSOLE.URLERROR)
            DispatchQueue.main.async {
                completion(nil)
            }
            
        }
    }.resume()
}

func getJson(link:String, completion:@escaping (Any?)->()) {
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
