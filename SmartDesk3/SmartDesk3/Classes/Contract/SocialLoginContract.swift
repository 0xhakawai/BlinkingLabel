//
//  SocialLoginContract.swift
//  SmartDesk3
//
//  Created by sa on 7/18/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import Foundation
import UIKit
import AutoCommon

@objc public protocol SocialLoginCallBackActionDelegate:CallBackActionDelegate {
    @objc optional func onSignInButtonCallBack(_ controller:AnyObject)
}
