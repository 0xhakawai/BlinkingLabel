//
//  Desk3SettingContract.swift
//  SmartDesk3
//
//  Created by sa on 7/30/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import Foundation
import UIKit
import AutoCommon


protocol Desk3SettingView: UserInfoView {
    func onLogoutCallback() 
}

protocol Desk3SettingPresenter: UserInfoPresenter {
    func logout()
}
