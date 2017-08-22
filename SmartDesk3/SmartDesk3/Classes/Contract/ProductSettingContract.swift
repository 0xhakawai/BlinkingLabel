//
//  ProductSettingContract.swift
//  AutonomousCommon
//
//  Created by sa on 5/12/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import Foundation
import UIKit
import AutoCommon

@objc public protocol ProductSettingCallBackActionDelegate:CallBackActionDelegate {
    
}
public protocol ProductSettingView: BaseView {
    func onUpdateVolumeCallback()
    func onProductSettingCallback(value: Bool)
    func onUpdateProductCallback()

}

public protocol ProductSettingPresenter: BasePresenter{
    func getProduct(_ productId:String?) -> ProductObj?
    func updateProduct(productId:String, productName:String, productType:String, address:String, addressLon:Double, addressLat:Double, source:String, timezone:String, data:String)
    func getVolume(productId:String)
    func updateVolume(productId:String, value:Int)
    func getIPAddress(productId:String)
}
