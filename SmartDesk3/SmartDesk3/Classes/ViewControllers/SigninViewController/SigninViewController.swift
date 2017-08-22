//
//  SigninViewController.swift
//  SmartDesk3
//
//  Created by sa on 7/18/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import UIKit
import AutoCommon
import AutoUtil
import AutoCore
import AutoBL
import AutoView

class SigninViewController: LoginViewController{

    @IBOutlet weak fileprivate var lblSignIn: UILabel?
    @IBOutlet weak fileprivate var lblAlreadyAccount: UILabel!
    
    @IBOutlet weak fileprivate var disTitleButton: NSLayoutConstraint!
    
    @IBOutlet weak var disButtonBottomTitle: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    //MARK: - Override
    @IBAction open override func btnSignupTouched(_ sender: AnyObject) {
        super.btnSignupTouched(sender)
    }
    @IBAction open override func btnGoogleTouched(_ sender: AnyObject) {
        super.btnGoogleTouched(sender)
    }
    @IBAction open override func btnFacebookTouched(_ sender: AnyObject) {
        super.btnFacebookTouched(sender)
    }
    @IBAction open override func btnLoginTouched(_ sender: AnyObject) {
        super.btnLoginTouched(sender)
    }
    @IBAction open override func btnForgotPwdTouched(_ sender: AnyObject) {
        super.btnForgotPwdTouched(sender)
    }
    
    //MARK: - Internal function
    fileprivate func loadUI() {
        lblSignIn?.font = CUSTOM_FONT.fREGULAR.size(size: 32)

        txtEmail?.font = CUSTOM_FONT.fREGULAR.size(size: 16)
        txtPassword?.font = CUSTOM_FONT.fREGULAR.size(size: 16)
        
        self.btnGoogle?.setBackgroundImage(nil, for: .normal)
        self.btnGoogle?.backgroundColor = PRODUCT_COLOR.kRedColor
        self.btnGoogle?.titleLabel?.font = CUSTOM_FONT.fREGULAR.size(size: 16)
        self.btnGoogle?.layer.cornerRadius = 5
        
        self.btnLogin?.setBackgroundImage(nil, for: .normal)
        self.btnLogin?.backgroundColor = PRODUCT_COLOR.kLighGrayColor
        self.btnLogin?.titleLabel?.font = CUSTOM_FONT.fREGULAR.size(size: 16)
        self.btnLogin?.layer.cornerRadius = 5

        
        self.btnFacebook?.setBackgroundImage(nil, for: .normal)
        self.btnFacebook?.backgroundColor = PRODUCT_COLOR.kBlueColor
        self.btnFacebook?.titleLabel?.font = CUSTOM_FONT.fREGULAR.size(size: 16)
        self.btnFacebook?.layer.cornerRadius = 5

        self.btnSignup?.setBackgroundImage(nil, for: .normal)
        self.btnSignup?.backgroundColor = UIColor.clear
        self.btnSignup?.setTitleColor(PRODUCT_COLOR.kBlueColor, for: .normal)
        self.btnSignup?.titleLabel?.font = CUSTOM_FONT.fREGULAR.size(size: 16)
        
        self.btnForgotPwd?.setBackgroundImage(nil, for: .normal)
        self.btnForgotPwd?.titleLabel?.font = CUSTOM_FONT.fREGULAR.size(size: 16)
        self.btnForgotPwd?.setTitleColor(PRODUCT_COLOR.kBlueColor, for: .normal)

        
        self.lblAlreadyAccount.font = CUSTOM_FONT.fREGULAR.size(size: 16)
        
        if UIScreen.main.sizeType == .iPhone5 {
            // Make specific layout for small devices.
            
        }else if UIScreen.main.sizeType == .iPhone6 {
            disTitleButton.constant = 42
            disButtonBottomTitle.constant = 58
        }
        
    }

}

