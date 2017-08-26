//
//  RootViewPresenter.swift
//  MVPTest
//
//  Created by sa on 2/20/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import UIKit

class RootViewPresenter: NSObject {

    var view:RootViewController?
    init(view:RootViewController) {
        self.view = view
    }
    func runInitial() {
        /*
     if !AppConfig.sharedInstance.isLogin() {
        showLoginPage()
     }else{
        showMainPage()
     }
 */
        showMainPage()
        
    }
    func showMainPage() {
        self.view?.openMainPage()
    }
    func showLoginPage() {
        self.view?.openLoginPage()
    }
    func removeMainPage() {
        self.view?.removeMainPage()
    }
    func removeLoginPage() {
        self.view?.removeLogin()
    }
}
