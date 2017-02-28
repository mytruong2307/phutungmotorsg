//
//  Constants.swift
//  PhuTungMotor
//
//  Created by admin on 12/23/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
import UIKit


let ip = "192.168.1.101"
let domain = "http://phutungmotorsg.pe.hu"
//let domain = "http://\(ip)/phutungmoto"
class Constants {
    static let MY_TEXT_COLOR:UIColor = UIColor(colorLiteralRed: 0.83, green: 0.82, blue: 0.81, alpha: 1)
    static let MY_BG_COLOR:UIColor = UIColor(colorLiteralRed: 0.49, green: 0, blue: 0.01, alpha: 1)
}

enum API:String {
    case LOGIN = "login"
    case ADDRESS = "idTinhQuan"
    case PROVINCE = "tinh"
    case BIKETYPE = "loaixe"
    case REGISTER = "khachhang"
    case PRODUCT = "sanpham"
    case FORGOTPASS = "quenmatkhau"
    case CHANGEPASS = "changePass"
    case NEWS = "tintuc"
    case FAQ = "hoidap"
    case HOME = "trangchu"
    case IMAGE = "hinh"
    case SHOPPING = "dathang"
    case DONHANG = "donhang"
    case DONHANGSANPHAM = "donhangsanpham"
    case UPDATEVIEW = "updateluotxem"
    case SEARCH = "timkiemsanpham"
    case SODONHANG = "sodonhang"
    case SOHOIDAP = "sohoidap"
    case DOANHTHU = "doanhthu"
    case THONGTIN = "thongtin"
    case SUATHONGTIN = "suathongtin"
    
    case DATA_RES = "result"
    case DATA_ERR = "err"
    case DATA_RETURN = "data"
    case RES_OK = "OK"
    case RES_NOK = "NOK"
    
    func getLinkService() ->String {
        return "\(domain)/service/" + self.rawValue
    }
    
    func getLinkAdminSer() -> String {
        return "\(domain)/service/admin/" + self.rawValue
    }
    func getLinkImage() -> String {
        return "\(domain)/images/" + self.rawValue
    }
    func getString() -> String {
        return self.rawValue
    }
    
    var LINK_SERVICE:String {
        return "\(domain)/service/" + self.rawValue
    }
    var LINK_ADMIN:String {
        return "\(domain)/service/admin/" + self.rawValue
    }

}

enum ALERT:String {
    case ERROR = "LỖI !!!"
    case NOTICE = "Thông báo"
    case CHANGEPASSOK = "Đổi mật khẩu thành công"
    case PASSNOTMATCH = "Mật khẩu không khớp"
    case NEWPASSNOTMATCH = "Mật khẩu mới không khớp"
    case INVALIDNEWPASS = "Mật khẩu mới không hợp lệ, mật khẩu phải có ít nhất 1 ký tự viết hoa, 1 ký tự đặc biệt !@#$&*, 1 số, 1 ký tự thường và dài từ 8 đến 15 ký tự."
    case INVALIDPASS = "Mật khẩu không hợp lệ, mật khẩu phải có ít nhất 1 ký tự viết hoa, 1 ký tự đặc biệt !@#$&*, 1 số, 1 ký tự thường và dài từ 8 đến 15 ký tự."
    case INVALIDEMAIL = "Email không hợp lệ"
    case UPDATEOK = "Cập nhật thành công"
    case NOTEXISTEMAIL = "Email không tồn tại"
    case CHECKEMAIL = "Check mail lấy mật khẩu để thay đổi mật khẩu"
    case CHOOSEPROVINCE = "Chọn Tỉnh trước khi chọn quận"
    case CHOOSEDISTRICT = "Chọn Tỉnh và Quận trước khi chọn phường"
    case USEDEMAIL = "Email đã có người dùng"
    case REGISTEROK = "Đăng ký thành công, check mail và kích hoạt tài khoản"
    case EMPTYTEXTFIELD = "Chưa điền đủ thông tin"
    case ERRORSERVER = "Server qúa tải"
    case SHOPPING = "Đặt hàng"
    case BUYPRODUCT = "Bạn có chắc đặt hàng sản phẩm này"
    case EMPTYCART = "Bạn chưa chọn sản phầm nào"
    case ADDMOREPRODUCT = "Sản phẩm này đã có trong giỏ hàng !!! Bạn muốn mua thêm 1 sản phẩm này nữa"
    case DELETESHOPPING = "Bạn có muốn bỏ sản phẩm này khỏi giỏ hành?"
    case UPDATESL = "Bạn có chắc cập nhất số lượng mới của sản phẩm này?"
    case LOGINREGISTER = "Vui lòng đăng nhập để mua hàng !!!"
    case LOGIN = "Đăng nhập"
    case REGISTER = "Đăng ký"
    case THANHTOAN = "Chọn hình thức thanh toán"
    case TIENMAT = "Nhận hàng trả tiền"
    case CHUYENKHOAN = "Chuyển khoản"
    case CHUATHANHTOAN = "Bạn chưa chọn hình thức thanh toán !!!"
    case SHOPPINGOK = "Đặt hàng thành công, bạn cần vào mail để xác nhận đơn hàng"
    case KHACHHANG = "Khách hàng"
    case ADMIN = "Quản trị"
    case CHONTRANG = "Bạn chọn vào trang nào?"
    case NOPERMISSION = "Bạn không có quyền vào mục này"
    case DIFERRENTUSER = "User không hợp lệ"
    
    func getAlertMessage() -> String{
        return self.rawValue
    }
    
}

enum UI:String {
    case LBL_EMAIL = "Email"
    case LBL_PASS = "Mật khẩu"
    case LBL_OLDPASS = "Mật khẩu cũ"
    case LBL_NEWPASS = "Mật khẩu mới"
    case LBL_REMEMBER = "Ghi nhớ đăng nhập"
    case LBL_ACCOUNT = "TÀI KHOẢN"
    case LBL_REPASS = "Nhập lại mật khẩu"
    case LBL_RENEWPASS = "Nhập lại mật khẩu mới"
    case LBL_PERSONALINFO = "THÔNG TIN CÁ NHÂN"
    case LBL_NAME = "Họ và Tên"
    case LBL_BIKETYPE = "Xe đang dùng"
    case LBL_GENDER = "Giới tính"
    case LBL_CONTACT = "THÔNG TIN LIÊN HỆ"
    case LBL_PROVINCE = "Tỉnh/Thành phố"
    case LBL_DISTRICT = "Quận/Huyện"
    case LBL_WARD = "Phường/Xã"
    case LBL_ADDRESS = "Số nhà"
    case LBL_DIACHI = "Địa chỉ:"
    case LBL_PHONE = "Điện thoại"
    case LBL_MALE = "Nam"
    case LBL_FEMALE = "Nữ"
    case LBL_TRADEMARK = "DANH SÁCH CÁC LOẠI XE"
    case LBL_PRODUCTNAME = "Tên: "
    case LBL_PRODUCTCODE = "Mã: "
    case LBL_BIKEKIND = "Loại xe: "
    case LBL_PRODUCTPRICE = "Giá: "
    case LBL_PRODUCTBASEPRICE = "Giá cũ: "
    case LBL_PRODUCTTRADEMARK = "Hãng xe: "
    case LBL_SUM = "TỔNG"
    case LBL_SHOPPINGCART = "GIỎ HÀNG"
    case LBL_DONHANGNO = "ĐƠN HÀNG SỐ: "
    case LBL_CREATEDAT = "Ngày đặt:"
    case LBL_CACHTHANHTOAN = "Cách thanh toán:"
    case LBL_THANHTOAN = "Tình trạng:"
    case LBL_TONGTIEN = "Tổng tiền:"
    case LBL_TRANGTHAI = "Trạng thái:"
    case LBL_TIENMAT = "Tiền mặt"
    case LBL_CHUYENKHOAN = "Chuyển khoản"
    case LBL_CHUATT = "Chưa thanh toán"
    case LBL_DATT = "Đã thanh toán"
    case LBL_DAXN = "Đã xác nhận"
    case LBL_CHUAXN = "Chưa xác nhận"
    case LBL_VANCHUYEN = "Đang vận chuyển"
    case LBL_HUY = "Huỷ"
    case LBL_HOANTHANH = "Thành công"
    case LBL_LISTORDER = "DANH SÁCH ĐƠN HÀNG"
    case LBL_NHAN = "x"
    case LBL_BANG = "="
    case LBL_KEYWORD = "Kết quả tìm"
    case LBL_PRODUCT = "sản phẩm"
    case LBL_PERMISSION = "DANH SÁCH QUYỀN"
    case LBL_WEB = "Web:"

    
    case TTL_FORGOTPASS = "QUÊN MẬT KHẨU"
    case TTL_UPDATEINFO = "CẬP NHẬT THÔNG TIN"
    
    case FRM_LOGIN = "ĐĂNG NHẬP"
    case FRM_REGISTER = "ĐĂNG KÝ"
    case FRM_CHANGEPASS = "ĐỔI MẬT KHẨU"
    
    case BTN_FORGOTPASS = "RESET MẬT KHẨU"
    case BTN_UPDATE = "CẬP NHẬT"
    case BTN_SHOWMORE = "Xem thêm..."
    case BTN_CART = "THÊM VÀO GIỎ HÀNG"
    case BTN_SHOPPING = "ĐẶT HÀNG"
    case BTN_UPDATENO = "SỬA"
    case BTN_THANHTOAN = "CHỌN HÌNH THỨC THANH TOÁN"
    case BTN_DETAIL = "Xem chi tiết..."
    
    case DAY = "ngày trước"
    case HOUR = "giờ trước"
    case MINUTE = "phút trước"
    case NOW = "Vừa xong"
    
    case SERBAR = "Tìm theo tên sản phẩm"
    
    func getText() -> String {
        return self.rawValue
    }
}

enum CONSOLE:String {
    case ERROR = "Độ dài 2 mãng không bằng nhau"
    case URLERROR = "Lỗi URL"
    case JSON = "Lỗi parse JSON"
    case DICTIONARY = "Lỗi parse DICTIONARY"
    func printConsole() {
        print("------------------------------------------------------------------------")
        print(self.rawValue)
        print("------------------------------------------------------------------------")
    }
}

enum Method:String {
    case get = "GET"
    case post = "POST"
    var toString:String{
        return self.rawValue
    }
}

