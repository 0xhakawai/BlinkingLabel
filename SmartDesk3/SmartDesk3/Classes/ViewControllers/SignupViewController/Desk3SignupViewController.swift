//
//  SignupViewController.swift
//  SmartDesk3
//
//  Created by sa on 7/17/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import UIKit
import AutoView
import AutoUtil
import AutoCommon
import AutoCore
import AutoBL

class Desk3SignupViewController: SignupViewController {

    @IBOutlet weak fileprivate var lblSignup: UILabel?
    @IBOutlet weak fileprivate var btnSocialAlreadyAccount: UIButton?
    @IBOutlet weak fileprivate var btnLoginFacebook: UIButton?
    @IBOutlet weak fileprivate var btnLoginGoogle: UIButton?
    @IBOutlet weak fileprivate var lblAlreadyAccount: UILabel!
    
    @IBOutlet weak fileprivate var disAccountSignIn: NSLayoutConstraint!
    @IBOutlet weak fileprivate var disButtonBottomTitle: NSLayoutConstraint!
    
    fileprivate var desk3SignupPresenter:Desk3SignupPresenter?
    
    fileprivate var desk3SignupActionDelegate:Desk3SignupCallBackActionDelegate? {
        get {
            return self.actionDelegate as? Desk3SignupCallBackActionDelegate
        }
    }

    override func viewDidLoad() {
        //super.viewDidLoad()

        // Do any additional setup after loading the view.
        initObj()
        loadUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Override
    @IBAction open override func btnSignupTouched(_ sender: AnyObject){
        super.btnSignupTouched(sender)
    }

    @IBAction open override func btnAlreadyAccountTouched(_ sender: AnyObject){
        //Open Sign In Page
        self.desk3SignupActionDelegate?.onSignInButtonCallBack!(self)
    }
    
    //MARK: - Internal function
    fileprivate func loadUI() {
        lblSignup?.font = CUSTOM_FONT.fREGULAR.size(size: 32)
        
        txtName?.font = CUSTOM_FONT.fREGULAR.size(size: 16)
        txtEmail?.font = CUSTOM_FONT.fREGULAR.size(size: 16)
        txtPassword?.font = CUSTOM_FONT.fREGULAR.size(size: 16)

        self.btnLoginGoogle?.backgroundColor = PRODUCT_COLOR.kRedColor
        self.btnLoginGoogle?.titleLabel?.font = CUSTOM_FONT.fREGULAR.size(size: 16)
        self.btnLoginGoogle?.layer.cornerRadius = 5

        
        self.btnLoginFacebook?.backgroundColor = PRODUCT_COLOR.kBlueColor
        self.btnLoginFacebook?.titleLabel?.font = CUSTOM_FONT.fREGULAR.size(size: 16)
        self.btnLoginFacebook?.layer.cornerRadius = 5

        
        self.btnSignup?.setBackgroundImage(nil, for: .normal)
        self.btnSignup?.backgroundColor = PRODUCT_COLOR.kLighGrayColor
        self.btnSignup?.titleLabel?.font = CUSTOM_FONT.fREGULAR.size(size: 16)
        self.btnSignup?.layer.cornerRadius = 5

        
        self.btnSocialAlreadyAccount?.titleLabel?.font = CUSTOM_FONT.fREGULAR.size(size: 16)
        self.btnSocialAlreadyAccount?.setTitleColor(PRODUCT_COLOR.kBlueColor, for: .normal)
        
        self.lblAlreadyAccount.font = CUSTOM_FONT.fREGULAR.size(size: 16)
        
        if UIScreen.main.sizeType == .iPhone5 {
            // Make specific layout for small devices.
            
        }else if UIScreen.main.sizeType == .iPhone6 {
            disAccountSignIn.constant = 60
            disButtonBottomTitle.constant = 23
        }

    }
    
    fileprivate func initObj() {
        let userDatabaseRepos = UserDatabaseReposImpl.init(database: Database.sharedInstance)
        let userServiceRepos = UserServiceReposImpl.init(apiService: APIService.sharedInstance)
        let userRepos = UserReposImpl.init(databaseRepos: userDatabaseRepos, serviceRepos: userServiceRepos)
        desk3SignupPresenter = Desk3SignupPresenterImpl.init(view: self, repos: userRepos)
        signupPresenter = desk3SignupPresenter
    }
    


    @IBAction open func btnFacebookTouched(_ sender: AnyObject){
        self.desk3SignupPresenter?.loginFacebook()
    }
    @IBAction open func btnGoogleTouched(_ sender: AnyObject){
        self.desk3SignupPresenter?.loginGoogle()
    }

}
extension Desk3SignupViewController:Desk3SignupView {
    func googleSignInDismiss(viewController: UIViewController) {
        viewController.dismiss(animated: true, completion: nil)

    }

    func googleSignInPresent(viewController: UIViewController) {
        self.view.window?.rootViewController?.present(viewController, animated: true, completion: nil)
    }

    
}
