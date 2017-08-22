//
//  AppConfigService.swift
//  SmartDesk
//
//  Created by Trong_iOS on 6/8/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import AutoCommon
import UIKit
import AutoCore
import AutoUtil
import Fabric
import Crashlytics


class AppConfigService: NSObject, ApplicationService {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        Fabric.with([Crashlytics.self])

        APP_CONFIG.HOTSPOT = PRODUCT_TYPE.DESK3.rawValue
        APP_CONFIG.NAME = "SmartDesk"
        APP_CONFIG.TYPE = PRODUCT_TYPE.DESK3.rawValue
        APP_CONFIG.NAME_KEY = PRODUCT_NAME_KEY.DESK3.rawValue
        
        
        
        
        //Config app font
        APP_FONT.fRegular = "HelveticaNeue"
        APP_FONT.fSemiBold = "HelveticaNeue-Medium"
        APP_FONT.fBold = "HelveticaNeue-Bold"
        APP_FONT.fItalic = "HelveticaNeue-Italic"
        
        //Config API for SMART_DEKSK_3
        API_AUTONOMOUS.kAddProduct = "v3/product"
        API_AUTONOMOUS.kAllProducts = "v3/product"
        
        AutonomousContext.sharedInstance.userObj = Database.sharedInstance.selectUser()
        
        if let address = UserDefaults.standard.object(forKey: "CURRENT_LOCATION") {
            AutonomousContext.sharedInstance.address = address as? String
        }
        
        return true
    }
    
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        GlobalMainQueue.asyncAfter(deadline: .now() + 0.5) { 
            NotificationCenter.default.post(name: .kNOTI_APP_OPEN, object: nil)
        }
    }
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        if url.absoluteString.contains("fb") {

            return FacebookServices.sharedInstance.application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation] as? String ?? "")
        }
        return true
    }
    
    @available(iOS, introduced: 8.0, deprecated: 9.0)
    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if url.absoluteString.contains("fb") {
            return FacebookServices.sharedInstance.application(application,open:url, sourceApplication:sourceApplication, annotation:annotation)
        }
        return true
    }
}
