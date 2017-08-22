//
//  QRCodeScannerContract.swift
//  SmartDesk3
//
//  Created by sa on 7/20/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import Foundation
import UIKit
import AutoCommon


@objc public protocol QRCodeScannerCallBackActionDelegate:CallBackActionDelegate {
    @objc optional func onAddProductCallBack(_ controller:AnyObject)
}

public protocol QRCodeScannerView: BaseView {
    func onAddProductCallback(_ value:Bool)

}

public protocol QRCodeScannerPresenter: BasePresenter{
    func addProductId(_ productId:String, productName:String, productType:String, address:String, addressLon:Double, addressLat:Double, data:String)
}

