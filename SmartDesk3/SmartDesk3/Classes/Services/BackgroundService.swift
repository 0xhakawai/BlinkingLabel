//
//  BackgroundService.swift
//  SmartDesk
//
//  Created by Trong_iOS on 7/2/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import AutoCommon
import AutoBL
import AutoCore
import AutoUtil
import UIKit

class BackgroundService: NSObject, ApplicationService {
    
    fileprivate var pProduct:ProductRepos?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        initObj()
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        checkUserActivedProduct()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    // MARK:- Internal functions
    
    func initObj() {
        let pDatabaseRepos = ProductDatabaseReposImpl.init(database: Database.sharedInstance)
        let uDatabaseRepos = UserDatabaseReposImpl.init(database: Database.sharedInstance)
        let pServiceRepos = ProductServiceReposImpl.init(apiService: APIService.sharedInstance)
        pProduct = ProductReposImpl.init(databaseRepos: pDatabaseRepos, userDatabaseRepos: uDatabaseRepos, serviceRepos: pServiceRepos)
        
    }

    func checkUserActivedProduct() {
        if let _ = AutonomousContext.sharedInstance.userObj {
            let token = String(describing: AutonomousContext.sharedInstance.userObj!.token!)
            print("Token:",token)
            let authorizationValue = String(format: AUTHORIZATION_FORMAT, token)
            let headers = ["Authorization":authorizationValue, "ACCEPT":"application/json"]
            
            pProduct?.getProductList([:], headers: headers, onSuccess: { (object) in
                let arrProduct: [ProductObj]
                arrProduct = object as! [ProductObj]
                var tmp = ""
                for product in arrProduct {
                    if product.is_checkin == 1 {
                        tmp = product.product_id
                        break
                    }
                }
                
                if tmp.characters.count == 0 {
                    AutonomousContext.sharedInstance.activeDevice = nil
                   
                } else {
                    AutonomousContext.sharedInstance.activeDevice = tmp
                }

                
            }, onError: { (error) in
                dLog(message: error.localizedDescription)
            })
        }
        
    }

}
