//
//  MenuViewPresenter.swift
//  MVPTest
//
//  Created by sa on 2/20/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import UIKit

class MenuPresenter: NSObject {
    var view:MenuViewController?
    var arrOptions : [Dictionary<String, AnyObject>]! = []
    
    func initObj() {
        let appOption = ["name" : "My Apps", "image" : "my_apps", "selected" : "1"]
        arrOptions.append(appOption as [String : AnyObject])
        
        let robotOption = ["name" : "My Robots", "image" : "my_robots", "selected" : "0"]
        arrOptions.append(robotOption as [String : AnyObject])
        
        let robotSettingOption = ["name" : "Robot Setting", "image" : "settings", "selected" : "0"]
        arrOptions.append(robotSettingOption as [String : AnyObject])
        
        let settingOption = ["name" : "My Account", "image" : "my_account", "selected" : "0"]
        arrOptions.append(settingOption as [String : AnyObject])
        
        
    }
    
    func resetExceptOption(_ idx : Int) {
        for (index, var option) in arrOptions.enumerated() {
            if index == idx {
                option["selected"] = "1" as AnyObject?
            } else {
                option["selected"] = "0" as AnyObject?
            }
            arrOptions[index] = option
        }
    }
}
