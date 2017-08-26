//
//  AppConfig.swift
//  Maya
//
//  Created by Trong_iOS on 7/13/16.
//  Copyright © 2016 Autonomous. All rights reserved.
//

import Foundation
import SwiftyJSON
import FirebaseAuth
class AppConfig {
    
    var userObj : UserObj? {
        get {/*
            if let user = Database.sharedInstance.selectUser(){
                return user
            }*/
            return nil
        }
    }
    /*
    var activeRobot:[String:AnyObject]?{
        get {
            return (UserDefaults.standard.value(forKey: "DEVICE_INFO")) as? [String:AnyObject]
        }
        set (newValue) {
            UserDefaults.standard.set(newValue, forKey: "DEVICE_INFO")
            UserDefaults.standard.synchronize()
        }
    }
    var activeDevice:String? {
        get {
            return (UserDefaults.standard.value(forKey: "DEVICE_ID")) as? String
            
        }
        set(newValue) {
            do {
                print("Sign out firebase")
                try FIRAuth.auth()?.signOut()
            }
            catch {
                print(error)
            }
            
            UserDefaults.standard.set(newValue, forKey: "DEVICE_ID")
            UserDefaults.standard.synchronize()
            self.checkVersionRobot()
        }
    }
    var lon:Double?
    var lat:Double?
    var address:String?
    var dictVersion:[String:AnyObject]?
    var productIdSetup:String? {
        get {
            return (UserDefaults.standard.value(forKey:"DEVICE_ID_SETUP")) as? String
        }
        set(newValue){
            UserDefaults.standard.set(newValue, forKey: "DEVICE_ID_SETUP")
            UserDefaults.standard.synchronize()
        }
    }

    */
    class var sharedInstance: AppConfig {
        struct Static {
            static let instance = AppConfig()
        }
        return Static.instance
    }
    
    init() {
        
    }
    
    func loadDefaults() {
        
    }
    
    func isLogin() -> Bool {
        if userObj == nil {
            return false
        }
        return true
    }
    /*
    func isRobotConnected() -> Bool {
        return false
    }
    func checkVersionRobot() {
        if AppConfig.sharedInstance.activeDevice != nil {
            print("Get Action version robot")
            FirebaseService.shareManager.controlDevice(AppConfig.sharedInstance.activeDevice!, action: ACTION.kACTION_CHECK_VERSION, value: "", success: { (dict) in
                
                let dict = dict as! [String:AnyObject]
                print("Dict version",dict)
                if let version = dict["value"] as? String {
                    print("Version Robot",version)
                    if let product = ProductObj.createObject(productId: AppConfig.sharedInstance.activeDevice!) {
                        product.version = version
                        Database.sharedInstance.updateProduct(product: product)
                        if AppConfig.sharedInstance.dictVersion != nil {
                            NotificationCenter.default.post(name: Notification.Name(rawValue: NOTIFICATION.kNOTI_GET_SYSTEM_VERSION), object: nil)
                        }
                    }
                    //AppConfig.sharedInstance.version = version
                    

                    
                }
                
                }, waitingResponse: true)
        }
    }
    //MARK: - Connection
    func callCheckFirmwareVersion() {
        print("Call Check firmware version")
        if (AppConfig.sharedInstance.userObj != nil) {
            let params:[String:AnyObject] = ["platform":PRODUCT_INFO.ProductType as AnyObject]
            
            let token = String(describing: (AppConfig.sharedInstance.userObj!.token)!)
            let authorizationValue = String(format: AUTHORIZATION_FORMAT, token)
            let headers = ["Authorization":authorizationValue, "ACCEPT":"application/json"]
            
            APIService.sharedInstance.getVersion(params, headers: headers, completionHandle: { (object) in
                let response = object
                if response as! NSObject == NSNull() {
                    print("Return object null")
                } else {
                    
                    let json = JSON(response)
                    if let status = json["status"].number {
                        if status == 1 {
                            if let dict = json["data"].dictionaryObject {
                                AppConfig.sharedInstance.dictVersion = dict as [String : AnyObject]?
                                if AppConfig.sharedInstance.activeDevice != nil {
                                    if let product = Database.sharedInstance.selectProduct(productId: AppConfig.sharedInstance.activeDevice!) {
                                        if AppConfig.sharedInstance.dictVersion != nil && product.version != nil {
                                            NotificationCenter.default.post(name: Notification.Name(rawValue: NOTIFICATION.kNOTI_GET_SYSTEM_VERSION), object: nil)
                                        }
                                    }
                                }
                                
                                
                                
                            }
                        }else {
                            var message:String?
                            if let errorMessage = json["message"].string{
                                message = errorMessage
                            }else{
                                message = json["message"].error?.description
                            }
                            GlobalMainQueue.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(0.25 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
                                Util.showInfoMsg(message, in: RootViewController.sharedInstance.view)
                                
                            })
                            
                            
                        }
                    }else {
                        print(json["status"].error as Any)
                    }
                }
            })
            
        }
    }
 */

}

