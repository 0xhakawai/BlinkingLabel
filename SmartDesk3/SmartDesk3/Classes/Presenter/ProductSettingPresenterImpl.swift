//
//  ProductSettingPresenterImpl.swift
//  AutonomousBL
//
//  Created by sa on 5/12/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import UIKit
import AutoCommon
import AutoUtil
import AutoCore

public class ProductSettingPresenterImpl: ProductSettingPresenter {
    let vProductSetting: ProductSettingView?
    let pRepos: ProductRepos?

    fileprivate var product:ProductObj?
    
    public init(view: ProductSettingView, repos: ProductRepos) {
        vProductSetting = view
        pRepos = repos
        
    }
    
    public func getProduct(_ productId: String?) -> ProductObj?{
        self.product = pRepos?.getProduct(productId!)
        return self.product
    }
    
    public func updateProduct(productId: String,productName:String, productType: String, address: String, addressLon: Double, addressLat: Double, source: String, timezone: String, data: String) {
        
        if productName.characters.count == 0 {
            vProductSetting?.showMessage(MESSAGE.kNameError)
        } else {
            let params:[String:AnyObject] = ["product_id":productId as AnyObject,
                                             "product_name":productName as AnyObject,
                                             "product_type":productType as AnyObject,
                                             "address":address as  AnyObject,
                                             "address_long":addressLon as AnyObject,
                                             "address_lat":addressLat as AnyObject,
                                             "source":source as AnyObject,
                                             "timezone":timezone as AnyObject,
                                             "data":data as AnyObject,
                                             "is_connected":"1" as AnyObject,
                                             "created_from":"ios" as AnyObject]

            
            GlobalMainQueue.async {
                self.vProductSetting?.showIndicator()
            }
            
            let token = String(describing: AutonomousContext.sharedInstance.userObj!.token!)
            let authorizationValue = String(format: AUTHORIZATION_FORMAT, token)
            let headers = ["Authorization":authorizationValue, "ACCEPT":"application/json"]
            
            self.pRepos?.updateProduct(params, headers: headers, onSuccess: { (object) in
                
                GlobalMainQueue.async {
                    self.vProductSetting?.hideIndicator()
                    self.vProductSetting?.onProductSettingCallback(value: true)
                }
                
            }, onError: {(error) in
                
                GlobalMainQueue.async {
                    self.vProductSetting?.hideIndicator()
                    self.vProductSetting?.showMessage(error.localizedDescription)
                }
            })
        }
    }
    
    public func getIPAddress(productId: String) {
        let device_id = AutonomousContext.sharedInstance.activeDevice
        if device_id != nil {
            let firebase = FirebaseServiceImpl.shareInstance
            let mailProductId = String(format: MAIL_UID_FORMAT, device_id!)
            print(mailProductId)
            
            let userHash = AutonomousContext.sharedInstance.userObj!.user_hash!
            let phoneChannel = String(format: PHONE_CHANNEL_FORMAT, device_id!)
            let deviceChannel = String(format: DEVICE_CHANNEL_FORMAT, device_id!)
            
            firebase.sendAction(username: mailProductId, password: userHash, action: Action(type: "product_control", source: phoneChannel, data: ["action" :FIREBASE_ACTION.kACTION_REQUEST_IP], myProtocal: "firebase", dest: deviceChannel), onCallback: { (dict) in
                if let _ = dict["action"] {
                    if let ip = dict["value"] as? String {
                        self.product?.iPAddress = ip
                        self.pRepos?.updateProduct(self.product)
                        self.vProductSetting?.onUpdateProductCallback()
                        
                    }
                }
                
                
            }, onQos: .normal)
            
        }
    }
    
    public func updateVolume(productId: String, value: Int) {
        let device_id = AutonomousContext.sharedInstance.activeDevice
        if device_id != nil {
            let firebase = FirebaseServiceImpl.shareInstance
            let mailProductId = String(format: MAIL_UID_FORMAT, device_id!)
            print(mailProductId)
            
            let userHash = AutonomousContext.sharedInstance.userObj!.user_hash!
            let phoneChannel = String(format: PHONE_CHANNEL_FORMAT, device_id!)
            let deviceChannel = String(format: DEVICE_CHANNEL_FORMAT, device_id!)
            
            firebase.sendAction(username: mailProductId, password: userHash, action: Action(type: "product_control", source: phoneChannel, data: ["action" :FIREBASE_ACTION.kACTION_SET_VOLUME, "value":String(format:"%d",value)], myProtocal: "firebase", dest: deviceChannel), onCallback: { (dict) in
                if let _ = dict["action"] as? String {
                    AutonomousContext.sharedInstance.data.value = ["volume": String(format:"%i",value)]
                    self.product?.data = Util.stringFromHashable(dictionary: AutonomousContext.sharedInstance.data.value!)
                    self.pRepos?.updateProduct(self.product)
                    
                    self.saveProductData(Util.stringFromHashable(dictionary: AutonomousContext.sharedInstance.data.value!)!)
                }
                
                
            }, onQos: .normal)
        }
    }
    
    public func getVolume(productId: String) {
        let device_id = AutonomousContext.sharedInstance.activeDevice
        if device_id != nil {
            let firebase = FirebaseServiceImpl.shareInstance
            let mailProductId = String(format: MAIL_UID_FORMAT, device_id!)
            print(mailProductId)
            
            let userHash = AutonomousContext.sharedInstance.userObj!.user_hash!
            let phoneChannel = String(format: PHONE_CHANNEL_FORMAT, device_id!)
            let deviceChannel = String(format: DEVICE_CHANNEL_FORMAT, device_id!)
            
            firebase.sendAction(username: mailProductId, password: userHash, action: Action(type: "product_control", source: phoneChannel, data: ["action" :FIREBASE_ACTION.kACTION_GET_VOLUME], myProtocal: "firebase", dest: deviceChannel), onCallback: { (dict) in
                if let _ = dict["action"] as? String {
                    print("Volume dict",dict)
                    if let volumeNumber = dict["value"]{
                        AutonomousContext.sharedInstance.data.value = ["volume": String(describing:volumeNumber)]
                        
                        self.product?.data = Util.stringFromHashable(dictionary: AutonomousContext.sharedInstance.data.value!)
                        self.pRepos?.updateProduct(self.product)
                        
                        self.vProductSetting?.onUpdateVolumeCallback()
                        
                    }
                }
                
                
            }, onQos: .background)
            
        }

    }
    
    func saveProductData(_ data:String) {
        var timezone: String { return (NSTimeZone.local as NSTimeZone).name }
        
        let params:[String:AnyObject] = ["product_id":self.product?.product_id as AnyObject,
                                         "product_name":self.product?.product_name as AnyObject,
                                         "product_type":self.product?.product_type as AnyObject,
                                         "address":self.product?.address as  AnyObject,
                                         "address_long":self.product?.lng as AnyObject,
                                         "address_lat":self.product?.lat as AnyObject,
                                         "source":"iOS" as AnyObject,
                                         "timezone":timezone as AnyObject,
                                         "data":data as AnyObject,
                                         "is_connected":"1" as AnyObject,
                                         "created_from":"ios" as AnyObject]
        
        
        let token = String(describing: AutonomousContext.sharedInstance.userObj!.token!)
        let authorizationValue = String(format: AUTHORIZATION_FORMAT, token)
        let headers = ["Authorization":authorizationValue, "ACCEPT":"application/json"]
        
        self.pRepos?.updateProduct(params, headers: headers, onSuccess: { (object) in
            
            
        }, onError: {(error) in
            /*
            if error.code == 401 {
                self.pRepos?.resetToken(headers, onSuccess: {_ in
                    self.saveProductData(data)
                }, onError: { (errorRefresh) in
                    
                })
            }
 */
        })


    }

}
