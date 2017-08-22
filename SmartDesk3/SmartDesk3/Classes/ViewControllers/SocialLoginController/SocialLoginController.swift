//
//  SocialLoginController.swift
//  SmartDesk3
//
//  Created by sa on 7/14/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import UIKit
import AutoCommon
import AutoUtil
import AutoBL
import AutoView

class SocialLoginController: LoginViewController {
    @IBOutlet weak fileprivate var btnSocialAlreadyAccount: UIButton?
    @IBOutlet weak fileprivate var lblHello: UILabel?
    @IBOutlet weak fileprivate var lblAlreadyAccount: UILabel!
    @IBOutlet weak fileprivate var disTitleButton: NSLayoutConstraint!
    
    
    fileprivate var socialLoginActionDelegate:SocialLoginCallBackActionDelegate? {
        get {
            return self.actionDelegate as? SocialLoginCallBackActionDelegate
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Internal function
    fileprivate func loadUI() {
        lblHello?.font = CUSTOM_FONT.fREGULAR.size(size: 32)
        
        self.btnGoogle?.setBackgroundImage(nil, for: .normal)
        self.btnGoogle?.backgroundColor = PRODUCT_COLOR.kRedColor
        self.btnGoogle?.titleLabel?.font = CUSTOM_FONT.fREGULAR.size(size: 16)
        self.btnGoogle?.layer.cornerRadius = 5
        
        self.btnFacebook?.setBackgroundImage(nil, for: .normal)
        self.btnFacebook?.backgroundColor = PRODUCT_COLOR.kBlueColor
        self.btnFacebook?.titleLabel?.font = CUSTOM_FONT.fREGULAR.size(size: 16)
        self.btnFacebook?.layer.cornerRadius = 5

        
        self.btnSignup?.setBackgroundImage(nil, for: .normal)
        self.btnSignup?.backgroundColor = PRODUCT_COLOR.kLighGrayColor
        self.btnSignup?.titleLabel?.font = CUSTOM_FONT.fREGULAR.size(size: 16)
        self.btnSignup?.layer.cornerRadius = 5

        
        self.btnSocialAlreadyAccount?.titleLabel?.font = CUSTOM_FONT.fREGULAR.size(size: 16)
        self.btnSocialAlreadyAccount?.setTitleColor(PRODUCT_COLOR.kBlueColor, for: .normal)
        
        self.lblAlreadyAccount.font = CUSTOM_FONT.fREGULAR.size(size: 16)
        
        if UIScreen.main.sizeType == .iPhone5 {
            // Make specific layout for small devices.
            disTitleButton.constant = 75
        }else if UIScreen.main.sizeType == .iPhone6 {
            disTitleButton.constant = 135
        }

    }
    
    //MARK:- Override
    
    @IBAction open override func btnSignupTouched(_ sender: AnyObject){
        super.btnSignupTouched(sender)
    }
    
    @IBAction open override func btnGoogleTouched(_ sender: AnyObject){
        super.btnGoogleTouched(sender)
    }
    
    @IBAction open override func btnFacebookTouched(_ sender: AnyObject){
        super.btnFacebookTouched(sender)
    }
    
    @IBAction open func btnAlreadyAccountTouched(_ sender: AnyObject){
        //Open Sign In Page
        self.socialLoginActionDelegate?.onSignInButtonCallBack!(self)
    }

}
