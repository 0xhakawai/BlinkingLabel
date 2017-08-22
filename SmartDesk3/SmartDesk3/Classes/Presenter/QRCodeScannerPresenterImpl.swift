//
//  QRCodeScannerPresenter.swift
//  SmartDesk3
//
//  Created by sa on 7/20/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import UIKit
import AutoCommon
import AutoCore
import AutoUtil
import AutoBL

public class QRCodeScannerPresenterImpl: QRCodeScannerPresenter {
    
    let vQRCode: QRCodeScannerView?
    let pRepos: ProductRepos?
    
    init(view: QRCodeScannerView, repos: ProductRepos) {
        vQRCode = view
        pRepos = repos
    }
    
    
    public func addProductId(_ productId: String, productName: String, productType: String, address: String, addressLon: Double, addressLat: Double, data: String) {
        var timezone: String { return (NSTimeZone.local as NSTimeZone).name }
        
        let params:[String:AnyObject] = ["product_id":productId as AnyObject,
                                         "product_name":productName as AnyObject,
                                         "product_type":productType as AnyObject,
                                         "address":address as  AnyObject,
                                         "address_long":addressLon as AnyObject,
                                         "address_lat":addressLat as AnyObject,
                                         "source":"iOS" as AnyObject,
                                         "timezone":timezone as AnyObject,
                                         "data":data as AnyObject,
                                         "is_connected":"1" as AnyObject,
                                         "created_from":"ios" as AnyObject]
        
        let token = String(describing: AutonomousContext.sharedInstance.userObj!.token!)
        let authorizationValue = String(format: AUTHORIZATION_FORMAT, token)
        let headers = ["Authorization":authorizationValue, "ACCEPT":"application/json"]
        
        GlobalMainQueue.async {
            self.vQRCode?.showIndicator()
        }

        self.pRepos?.updateProduct(params, headers: headers, onSuccess: { (object) in
            if let product = object as? ProductObj {
                AutonomousContext.sharedInstance.activeDevice = product.product_id
            }
            GlobalMainQueue.async {
                self.vQRCode?.hideIndicator()
                self.vQRCode?.onAddProductCallback(true)
            }
            
        }, onError: {(error) in
            
            GlobalMainQueue.async {
                self.vQRCode?.hideIndicator()
                self.vQRCode?.showMessage(error.localizedDescription)
                self.vQRCode?.onAddProductCallback(false)
                
            }
            
        })

        
    }
    
    //MARK: - Internal functions
}
