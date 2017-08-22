//
//  Desk3ForgotPasswordContract.swift
//  SmartDesk3
//
//  Created by sa on 7/19/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import Foundation
import UIKit
import AutoCommon

@objc public protocol Desk3ForgotPasswordCallBackActionDelegate:CallBackActionDelegate {
    @objc optional func onSignInButtonCallBack(_ controller:AnyObject)
    @objc optional func onSignupButtonCallBack(_ controller:AnyObject)

}
