//
//  Desk3SettingPresenterImpl.swift
//  SmartDesk3
//
//  Created by sa on 7/30/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import UIKit
import AutoBL
import AutoCommon
import AutoCore
import GoogleSignIn

class Desk3SettingPresenterImpl: UserInfoPresenterImpl {

    fileprivate var desk3SettingView:Desk3SettingView?
    
    override init(view: UserInfoView, repos: UserRepos) {
        super.init(view: view, repos: repos)
        self.desk3SettingView = view as? Desk3SettingView
    }
    
    //MARK: - Internal functions
    func clearData() {
        Database.sharedInstance.clearDatabase()
        AutonomousContext.sharedInstance.clear()
        GIDSignIn.sharedInstance().signOut()
    }
}
extension Desk3SettingPresenterImpl:Desk3SettingPresenter {
    func logout() {
        self.clearData()
        self.desk3SettingView?.onLogoutCallback()
    }
}
