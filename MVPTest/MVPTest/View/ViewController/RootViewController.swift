//
//  RootViewController.swift
//  MVPTest
//
//  Created by sa on 2/20/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class RootViewController: UIViewController {

    var arrRetains : [AnyObject] = []
    var isLoaded = false
    var navLogin : UINavigationController?
    var slideMenu: SlideMenuController?
    var presenter:RootViewPresenter?
    
    class var sharedInstance: RootViewController {
        struct Static {
            static let instance = RootViewController()
        }
        return Static.instance
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initObj()
        self.presenter?.runInitial()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: UI
    
    func initObj() {
        self.presenter = RootViewPresenter(view: self)
    }
    
    // MARK: Functions
    
    func removeLogin() {
        
        if navLogin != nil {
            arrRetains.remove(navLogin!)
            navLogin?.view.removeFromSuperview()
            navLogin = nil
        }
    }
    func removeMainPage() {
        
        if slideMenu != nil {
            arrRetains.remove(slideMenu!)
            slideMenu?.view.removeFromSuperview()
            slideMenu = nil
        }
 
    }
    func openLoginPage() {
        /*
        let vcLogin = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginViewController") as? LoginViewController
        navLogin = UINavigationController.init(rootViewController: vcLogin!)
        self.view.addSubview(navLogin!.view)
        arrRetains.append(navLogin!)
 */
 
    }
    func openMainPage() {
        
        let vcMenu = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "menuViewController") as! MenuViewController
        //vcMenu.delegate = TabRootViewController.sharedInstance
        
        SlideMenuOptions.contentViewScale = 1.0
        SlideMenuOptions.leftViewWidth = 210.0
        SlideMenuOptions.rightViewWidth = 210.0
        slideMenu = SlideMenuController(mainViewController: TabRootViewController.sharedInstance, leftMenuViewController: vcMenu)
        
        self.view.addSubview(slideMenu!.view)
        arrRetains.append(slideMenu!)
        /*
        //Open the first tab
        TabRootViewController.sharedInstance.setIndexFocus(0)
        
        AppConfig.sharedInstance.checkVersionRobot()
        AppConfig.sharedInstance.callCheckFirmwareVersion()
 */
        
    }

}
