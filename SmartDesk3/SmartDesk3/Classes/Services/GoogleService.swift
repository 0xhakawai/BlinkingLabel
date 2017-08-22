//
//  GoogleService.swift
//  SmartDesk
//
//  Created by Trong_iOS on 6/8/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import UIKit
import AutoCommon
import AutoBL
import GoogleSignIn
import FirebaseCore
import AutoUtil

class GoogleService: NSObject, ApplicationService {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //GIDSignIn.sharedInstance().clientID = "939667727721-9c139scbrk0203lveeqljjt3cupc3dvi.apps.googleusercontent.com"
        let clientId = Bundle.main.infoDictionary!["GOOGLE_CLIENT_ID"] as! String
        GIDSignIn.sharedInstance().clientID = clientId
        //GIDSignIn.sharedInstance().clientID = "1086378506131-ace5hkejp556iu2mq3q5j2fs17e2bpqs.apps.googleusercontent.com"

        FIRApp.configure()
        
        return true
    }
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
    
    @available(iOS, introduced: 8.0, deprecated: 9.0)
    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: sourceApplication,
                                                 annotation: annotation)
    }
}
