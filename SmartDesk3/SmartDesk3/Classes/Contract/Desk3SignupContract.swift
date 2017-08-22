//
//  Desk3SignupContract.swift
//  SmartDesk3
//
//  Created by sa on 7/18/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import Foundation
import UIKit
import AutoCommon

@objc public protocol Desk3SignupCallBackActionDelegate:CallBackActionDelegate {
    @objc optional func onSignInButtonCallBack(_ controller:AnyObject)
}
protocol Desk3SignupView: SignupView {
    func googleSignInPresent(viewController: UIViewController)
    func googleSignInDismiss(viewController: UIViewController)
}

protocol Desk3SignupPresenter: SignupPresenter {
    func loginGoogle()
    func loginFacebook() 
}
