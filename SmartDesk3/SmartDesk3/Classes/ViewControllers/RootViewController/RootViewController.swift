//
//  RootViewController.swift
//  SmartDesk
//
//  Created by sa on 3/2/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import UIKit
import REFrostedViewController
import AutoCommon
import AutoBL
import AutoCore
import AutoView
import AutoUtil

class RootViewController: UIViewController {

    enum PAGE: Int {
        case CHECKIN = 0
        case DESK_INFO = 1
    }
    
    static var shareInstance = RootViewController()
    
    var isLoaded:Bool = false
    var arrRetains:NSMutableArray = []
    var navLogin : BaseNavigationViewController?
    var slideMenu:REFrostedViewController?
    fileprivate var pProduct:ProductRepos?
    
    // MARK:- View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initObjects()
        self.createUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        self.arrRetains.removeAllObjects()
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        self.arrRetains.removeAllObjects()
    }
    
    //MARK:- Function
    
    func initObjects() {
        self.arrRetains = []
        let pDatabaseRepos = ProductDatabaseReposImpl.init(database: Database.sharedInstance)
        let uDatabaseRepos = UserDatabaseReposImpl.init(database: Database.sharedInstance)
        let pServiceRepos = ProductServiceReposImpl.init(apiService: APIService.sharedInstance)
        pProduct = ProductReposImpl.init(databaseRepos: pDatabaseRepos, userDatabaseRepos: uDatabaseRepos, serviceRepos: pServiceRepos)

    }
    
    func createUI() {
        self.run()
    }
    
    func run(){
        if (!isLoaded) {
            isLoaded = true
            loadTabbar()
        }
        
        if AutonomousContext.sharedInstance.userObj == nil {
            openLoginPage()
            
        } else {
            if AutonomousContext.sharedInstance.activeDevice != nil {
                TabRootViewController.shareInstance.setIndexFocus(PAGE.DESK_INFO.rawValue)
                
            } else {
                TabRootViewController.shareInstance.setIndexFocus(PAGE.CHECKIN.rawValue)
                
            }
        }
    }
    
    //This is the structure which has a left menu and tabbar
    func loadLeftMenuTabbar() {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let menuViewController = storyBoard.instantiateViewController(withIdentifier: "menuViewController") as! MenuViewController
        menuViewController.delegate = TabRootViewController.shareInstance
        
        slideMenu = REFrostedViewController(contentViewController: TabRootViewController.shareInstance, menuViewController: menuViewController)
        slideMenu?.direction = .left
        slideMenu?.liveBlurBackgroundStyle = .light
        slideMenu?.panGestureEnabled = false
        slideMenu?.liveBlur = true
        slideMenu?.delegate = self
        
        self.view.addSubview((slideMenu?.view)!)
        self.arrRetains.add(slideMenu!)
    }
    
    //This is the structure which has only tabbar
    func loadTabbar() {
        let myNavigationController = BaseNavigationViewController(rootViewController: TabRootViewController.shareInstance)
        myNavigationController.isNavigationBarHidden = true
        self.view.addSubview(myNavigationController.view)
        self.arrRetains.add(myNavigationController)
    }
    
    func removeLogin() {
        if navLogin != nil {
            arrRetains.remove(navLogin!)
            navLogin?.view.removeFromSuperview()
            navLogin = nil
        }
    }
    
    private func openLoginPage() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vcSocialLoginController = storyBoard.instantiateViewController(withIdentifier: "socialLoginController") as! SocialLoginController
        vcSocialLoginController.actionDelegate = self
        navLogin = BaseNavigationViewController(rootViewController: vcSocialLoginController)
        self.view.addSubview((navLogin?.view)!)
        arrRetains.add(navLogin!)

    }
    
    func openSignInPage(_ viewController:UIViewController) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vcSigninPage = storyBoard.instantiateViewController(withIdentifier: "signinViewController") as! SigninViewController
        vcSigninPage.actionDelegate = self
        
        
        if let navigation = viewController.navigationController  {
            let navs = navigation.viewControllers
            
            for viewController in navs {
                if viewController.isKind(of: SigninViewController.self) {
                    navigation.popToViewController(viewController, animated: true)
                    return
                }
            }
            navigation.pushViewController(vcSigninPage, animated: true)
        }
    }
    
    func openSignUpPage(_ viewController:UIViewController) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vcSignupPage = storyBoard.instantiateViewController(withIdentifier: "desk3SignupViewController") as! SignupViewController
        vcSignupPage.actionDelegate = self
        
        if let navigation = viewController.navigationController  {
            let navs = navigation.viewControllers
            
            for viewController in navs {
                if viewController.isKind(of: SignupViewController.self) {
                    navigation.popToViewController(viewController, animated: true)
                    return
                }
            }
            navigation.pushViewController(vcSignupPage, animated: true)
        }
    }

    func openForgotPasswordPage(_ viewController:UIViewController) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vcForgotPasswordPage = storyBoard.instantiateViewController(withIdentifier: "desk3ForgotPasswordController") as! ForgotPasswordController
        vcForgotPasswordPage.actionDelegate = self
        if let navigation = viewController.navigationController  {
            let navs = navigation.viewControllers
            
            for viewController in navs {
                if viewController.isKind(of: ForgotPasswordController.self) {
                    navigation.popToViewController(viewController, animated: true)
                    return
                }
            }
            navigation.pushViewController(vcForgotPasswordPage, animated: true)
        }
    }
    
    func checkUserActivedProduct() {
        if let _ = AutonomousContext.sharedInstance.userObj {
            GlobalMainQueue.async {
                Util.startLoadingView(self.view, animated: true)
            }
            
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
                    
                    let nav = TabRootViewController.shareInstance.viewControllers?[0] as! BaseNavigationViewController
                    let vc = nav.viewControllers[PAGE.CHECKIN.rawValue] as! CheckinViewController
                    vc.openQRCodePage()
                    
                } else {
                    AutonomousContext.sharedInstance.activeDevice = tmp
                }
                
                GlobalMainQueue.async {
                    Util.stopLoadingView(self.view, animated: true)
                }
                
                
            }, onError: { (error) in
                GlobalMainQueue.async {
                    Util.stopLoadingView(self.view, animated: true)
                }
                dLog(message: error.localizedDescription)
            })
        }
        
    }

}

extension RootViewController:REFrostedViewControllerDelegate {
    func frostedViewController(_ frostedViewController: REFrostedViewController!, didRecognizePanGesture recognizer: UIPanGestureRecognizer!){
    }
    
    func frostedViewController(_ frostedViewController: REFrostedViewController!, willShowMenuViewController menuViewController: UIViewController!){
        
    }
    
    func frostedViewController(_ frostedViewController: REFrostedViewController!, didShowMenuViewController menuViewController: UIViewController!){
        
    }
    
    func frostedViewController(_ frostedViewController: REFrostedViewController!, willHideMenuViewController menuViewController: UIViewController!){
        
    }
    
    func frostedViewController(_ frostedViewController: REFrostedViewController!, didHideMenuViewController menuViewController: UIViewController!){
        
    }
}

extension RootViewController:SignupCallBackActionDelegate {
    func onDidSignupSuccessfullCallBack() {
        removeLogin()
    }
}

extension RootViewController:LoginCallBackActionDelegate, SocialLoginCallBackActionDelegate, Desk3SignupCallBackActionDelegate, Desk3ForgotPasswordCallBackActionDelegate{
    func onSignInButtonCallBack(_ controller:AnyObject){
        if let viewController = controller as? UIViewController {
            openSignInPage(viewController)

        }
        
    }

    func onSignupButtonCallBack(_ controller: AnyObject) {
            
        if let viewController = controller as? UIViewController {
            openSignUpPage(viewController)
            
        }
            
    }
    
    func onForgotPasswordButtonCallBack(_ controller: AnyObject) {
        if let viewController = controller as? UIViewController {
            openForgotPasswordPage(viewController)
        }
    }
    
    func onDidLoginSuccessfullCallBack() {
        /* After login, AutonomousContext.shareInstance.activeDevice = product has is_checkin = 1
         * In SmartDesk3, we use AutonomousContext.shareInstance.activeDevice to indicate which desk is checked in
         * So we has reset AutonomousContext.shareInstance.activeDevice = nil after Login successful
         */
        AutonomousContext.sharedInstance.activeDevice = nil
        self.checkUserActivedProduct()
        removeLogin()
    }

}

