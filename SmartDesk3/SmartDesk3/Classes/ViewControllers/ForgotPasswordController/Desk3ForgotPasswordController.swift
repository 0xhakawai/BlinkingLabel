//
//  Desk3ForgotPasswordController.swift
//  SmartDesk3
//
//  Created by sa on 7/19/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import UIKit
import AutoView
import AutoUtil
import AutoCommon
import AutoCore
import AutoBL

class Desk3ForgotPasswordController: ForgotPasswordController{

    @IBOutlet weak fileprivate var lblAlreadyAccount: UILabel!
    @IBOutlet weak fileprivate var lblNotHaveAccount: UILabel!
    @IBOutlet weak fileprivate var btnSignup: UIButton!
    @IBOutlet weak fileprivate var btnSignin: UIButton!
        
    @IBOutlet weak var distantTitleEmail: NSLayoutConstraint!
    
    fileprivate var desk3ForgotPasswordActionDelegate:Desk3ForgotPasswordCallBackActionDelegate? {
        get {
            return self.actionDelegate as? Desk3ForgotPasswordCallBackActionDelegate
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

    //MARK: - Override

    @IBAction open override func btnSendTouched(_ sender: Any) {
        super.btnSendTouched(sender)
    }
    
    //MARK: - Internal function

    @IBAction func btnSignupTouched(_ sender: Any) {
        self.desk3ForgotPasswordActionDelegate?.onSignupButtonCallBack!(self)
    }
    
    @IBAction func btnSigninTouched(_ sender: Any) {
        self.desk3ForgotPasswordActionDelegate?.onSignInButtonCallBack!(self)
    }
    
    fileprivate func loadUI() {
        lblForgotTitle?.font = CUSTOM_FONT.fREGULAR.size(size: 32)
        
        txtEmail?.font = CUSTOM_FONT.fREGULAR.size(size: 16)
        self.btnSend?.setBackgroundImage(nil, for: .normal)
        self.btnSend?.backgroundColor = PRODUCT_COLOR.kLighGrayColor
        self.btnSend?.titleLabel?.font = CUSTOM_FONT.fREGULAR.size(size: 16)
        self.btnSend?.layer.cornerRadius = 5
        
        self.lblAlreadyAccount.font = CUSTOM_FONT.fREGULAR.size(size: 16)
        self.lblNotHaveAccount.font = CUSTOM_FONT.fREGULAR.size(size: 16)
        
        self.btnSignup?.setBackgroundImage(nil, for: .normal)
        self.btnSignup?.backgroundColor = UIColor.clear
        self.btnSignup?.setTitleColor(PRODUCT_COLOR.kBlueColor, for: .normal)
        self.btnSignup?.titleLabel?.font = CUSTOM_FONT.fREGULAR.size(size: 16)
        
        self.btnSignin?.setBackgroundImage(nil, for: .normal)
        self.btnSignin?.backgroundColor = UIColor.clear
        self.btnSignin?.setTitleColor(PRODUCT_COLOR.kBlueColor, for: .normal)
        self.btnSignin?.titleLabel?.font = CUSTOM_FONT.fREGULAR.size(size: 16)
        
        if UIScreen.main.sizeType == .iPhone5 {
            // Make specific layout for small devices.
            distantTitleEmail.constant = 118
            descHeightConstraint?.constant = 124
        }else if UIScreen.main.sizeType == .iPhone6 {
            distantTitleEmail.constant = 168
            descHeightConstraint?.constant = 154
        }

    
    }

}
