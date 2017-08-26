//
//  Const.swift
//  Maya
//
//  Created by Trong_iOS on 7/20/16.
//  Copyright © 2016 Autonomous. All rights reserved.
//
import UIKit

struct CONFIG {
    static let kProductName = "Isabella"
    static let kDefaultVolume = 4
}

struct PAGE {
    static let NETWORK = "network"
    static let GUIDELINE = "guideline"
    static let MYROBOTS = "myrobots"
    static let MYAPPS = "myapps"
    static let ROBOT_SETTING = "robot_setting"
    static let SETTING = "setting"
}

struct PRODUCT_INFO{
    static let ProductName:String! = "PersonalRobot"
    static let ProductType:String! = "PERSONAL_ROBOT"
}

struct COMMON {
    static let BASE_IMG_BTN_BACK_NORMAL = "nav_back"
    static let BASE_IMG_BTN_BACK_ACTIVE = ""
    static let BASE_IMG_BTN_DONE_NOMRAL = ""
    static let BASE_IMG_BTN_DONE_ACTIVE = ""
    static let BASE_IMG_NAV_BAR = ""
    static let kSHADOW_KEY_TAG = 1234
    static let BUTTON_GAP = 10
}

struct MESSAGE {
    static let kCommonError = "There is an error happens. Please try again or contact humain@autonomous.ai for supports"
    static let kLoginError = "Invalid email or password!"
    static let kEmailError = "Invalid email!"
    static let kPasswordError = "Please check your password!"
    static let kNameError = "Please input your name!"
    static let kEmailSent = "Your recover password has been sent!"
    static let kSSIDError = "Please input your SSID name!"
    static let kWPAError = "Please input your WPA/WPA2 name!"
    static let kPhotoDownloaded = "The photo is downloaded"
    static let kCheckingApp = "Please input your username and password!"
    static let kInvalidAddress = "Please check your address!"
}

struct ZMQ {
    static let kHOTSPOT_NAME = "PERSONAL_ROBOT"
    static let kACTION_WIFI_CONFIGURATION = "send_wifi_info"
}

struct NOTIFICATION {
    static let kNOTI_APP_OPEN = "kNOTI_APP_OPEN"
    static let kNOTI_PING_SUCCESS = "kNOTI_PING_SUCCESS"
    static let kNOTI_GET_SYSTEM_VERSION = "KGET_SYSTEM_VERSION"
    static let kNOTI_ADDING_DEVICE = "K_ADDING_DEVICE"
    static let kNOTI_FINISH_SETUP = "K_FINISH_SETUP"
    static let kNOTI_SELECT_MENU = "K_SELECT_MENU"
}

struct ACTION {
    static let kACTION_CHECK_WIFI = "check_wifi"
    static let kACTION_REQUEST_ACTIVITY = "request_activity"
    static let kACTION_REQUEST_IP = "ip_address"
    static let kACTION_FACTORY_RESET = "factory_reset"
    static let kACTION_GET_VOLUME = "get_volume"
    static let kACTION_SET_VOLUME = "set_volume"
    static let kACTION_CHECK_VERSION = "check_version"
    static let kACTION_UPDATE_FIRMWARE_STATUS = "update_firmware_status"
}
struct EVENT {
    static let CLICK_LOGIN = "ClickLogin"
    static let CLICK_FORGOT = "ClickForgot"
    static let CLICK_FORGOT_PWD = "ClickForgotPwd"
    static let CLICK_REGISTER = "ClickRegister"
    static let GENERATE_PRODUCT = "GenegrateProduct"
    static let ADD_PRODUCT = "AddProduct"
    static let CLICK_MY_APPS = "ClickMyApps"
    static let CLICK_MY_ROBOT = "ClickMyRobot"
    static let CLICK_ROBOT_SETTING = "ClickRobotSetting"
    static let CLICK_MY_ACCOUNT = "ClickMyAccount"
    static let CLICK_AUTONOMOUS_WEBSITE = "ClickAutonomousWebsite"
    static let CLICK_LOGOUT = "ClickLogout"
    static let CLICK_FIRMWARE_UPDATE = "ClickFirmwareUpdate "

}


var GlobalMainQueue: DispatchQueue {
    return DispatchQueue.main
}

var GlobalUserInteractiveQueue: DispatchQueue {
    return DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive)
}

var GlobalUserInitiatedQueue: DispatchQueue {
    return DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated)
}

var GlobalUtilityQueue: DispatchQueue {
    return DispatchQueue.global(qos: DispatchQoS.QoSClass.utility)
}

var GlobalBackgroundQueue: DispatchQueue {
    return DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
}

func log(_ message: String,
         function: String = #function,
         file: String = #file,
         line: Int = #line) {
    
    print("Message \"\(message)\" (File: \(file), Function: \(function), Line: \(line))")
}


// MARK:- FONT

func fREGULAR(_ size: Int) -> UIFont {
    return UIFont.init(name: "AvenirNext-Regular", size: CGFloat(size))!
}

func fSEMIBOLD(_ size: Int!) -> UIFont {
    return UIFont.init(name: "AvenirNext-Medium", size: CGFloat(size))!
}

func fBOLD(_ size: Int!) -> UIFont {
    return UIFont.init(name: "AvenirNext-DemiBold", size: CGFloat(size))!
}

func fITALIC(_ size: Int!) -> UIFont {
    return UIFont.init(name: "AvenirNext-Italic", size: CGFloat(size))!
}

// MARK:- COLOR

var kGRAY_COLOR : UIColor {
    return UIColor.init(red: 139/255.0, green: 139/255.0, blue: 139/255.0, alpha: 1.0)
}

var kLIGHT_GRAY_COLOR : UIColor {
    return UIColor.init(red: 188/255.0, green: 188/255.0, blue: 188/255.0, alpha: 1.0)
}

var kBLUE_COLOR : UIColor {
    return UIColor.init(red: 84/255.0, green: 172/255.0, blue: 240/255.0, alpha: 1.0)
}

var kGREEN_COLOR : UIColor {
    return UIColor.init(red: 98/255.0, green: 167/255.0, blue: 28/255.0, alpha: 1.0)
}

var kPINK_COLOR : UIColor {
    return UIColor.init(red: 233/255.0, green: 101/255.0, blue: 127/255.0, alpha: 1.0)
}

func RGB(_ r: Int, g: Int, b: Int) -> UIColor {
    return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
}

// MARK:- VERSION

func SYSTEM_VERSION_EQUAL_TO(_ version : String) -> Bool {
    return UIDevice.current.systemVersion.compare(version) == .orderedSame
}

func SYSTEM_VERSION_GREATER_THAN(_ version : String) -> Bool {
    return UIDevice.current.systemVersion.compare(version) == .orderedDescending
}

func SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(_ version : String) -> Bool {
    return UIDevice.current.systemVersion.compare(version) == .orderedAscending
}

func SYSTEM_VERSION_LESS_THAN(_ version : String) -> Bool {
    return UIDevice.current.systemVersion.compare(version) == .orderedAscending
}

func SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(_ version : String) -> Bool {
    return UIDevice.current.systemVersion.compare(version) == .orderedDescending
}

var PATH_DOCUMENT_FOLDER : String {
    return NSHomeDirectory() + "/Documents"
}

var PATH_CACHE_FOLDER : String {
    return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .allDomainsMask, true).first!
}

//MARK - Extension
extension Notification.Name {
    static let RefreshPageNotification = Notification.Name("RefreshPageNotification")
    
}
