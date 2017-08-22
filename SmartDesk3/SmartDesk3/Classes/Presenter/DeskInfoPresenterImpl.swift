//
//  DeskInfoPresenterImpl.swift
//  SmartDesk3
//
//  Created by sa on 7/29/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import UIKit
import AutoCommon
import AutoCore
import AutoUtil

class DeskInfoPresenterImpl: DeskInfoPresenter {
    
    fileprivate var deskInfoView:DeskInfoView?
    fileprivate var pRepos:ProductRepos?
    
    init(view: DeskInfoView, repos: ProductRepos) {
        self.deskInfoView = view
        self.pRepos = repos
    }
    
    func checkOut() {
        if let deviceId = AutonomousContext.sharedInstance.activeDevice {
            GlobalMainQueue.async {
                self.deskInfoView?.showIndicator()
            }
            
            let token = String(describing: AutonomousContext.sharedInstance.userObj!.token!)
            let authorizationValue = String(format: AUTHORIZATION_FORMAT, token)
            let headers = ["Authorization":authorizationValue, "ACCEPT":"application/json"]
            
            self.pRepos?.checkout(deviceId, headers: headers, onSuccess: { (dict) in
                GlobalMainQueue.async {
                    self.deskInfoView?.hideIndicator()
                    if let _ = dict["action"] as? String {
                        self.deskInfoView?.onCheckoutCallback(true)
                    } else {
                        self.deskInfoView?.onCheckoutCallback(false)
                    }
                }
            }, onError: { (error) in
                GlobalMainQueue.async {
                    self.deskInfoView?.hideIndicator()
                    self.deskInfoView?.onCheckoutCallback(false)
                }
            })
        }

    }

}
