//
//  AppDelegate.swift
//  SmartDesk3
//
//  Created by sa on 7/13/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import UIKit
import AutoCommon

@UIApplicationMain
class AppDelegate: PluggableApplicationDelegate {

    override var services: [ApplicationService] {
        return [
            AppConfigService(),
            GoogleService(),
            LocationService(),
            ApplePushService(),
            BackgroundService()
        ]
    }

    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let value = super.application(application, didFinishLaunchingWithOptions: launchOptions)
        window?.rootViewController = RootViewController.shareInstance
        return value
    }



}

