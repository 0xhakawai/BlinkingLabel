//
//  Desk3SettingViewController.swift
//  SmartDesk3
//
//  Created by sa on 7/28/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import UIKit
import AutoCommon
import AutoView
import AutoUtil
import AutoBL
import AutoCore

class Desk3SettingViewController: UserInfoViewController {
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var distanceLogoutAndButton: NSLayoutConstraint!
    
    @IBOutlet weak var distanceLogoutBotton: NSLayoutConstraint!
    fileprivate var desk3SettingPresenter:Desk3SettingPresenter?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initObj()
        loadUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func initObj() {
        let userDatabaseRepos = UserDatabaseReposImpl.init(database: Database.sharedInstance)
        let userServiceRepos = UserServiceReposImpl.init(apiService: APIService.sharedInstance)
        let userRepos = UserReposImpl.init(databaseRepos: userDatabaseRepos, serviceRepos: userServiceRepos)
        desk3SettingPresenter = Desk3SettingPresenterImpl.init(view: self, repos: userRepos)
        userInfoPresenter = desk3SettingPresenter
    
    }
    
    fileprivate func loadUI(){
       self.txtName?.font = CUSTOM_FONT.fREGULAR.size(size: 16)
        self.txtEmail?.font = CUSTOM_FONT.fREGULAR.size(size: 16)
        self.txtPassword.font = CUSTOM_FONT.fREGULAR.size(size: 16)
        
        self.btnUpdate?.setBackgroundImage(nil, for: .normal)
        self.btnUpdate?.titleLabel?.font = CUSTOM_FONT.fREGULAR.size(size: 16)
        self.btnUpdate?.backgroundColor = PRODUCT_COLOR.kLighGrayColor
        self.btnUpdate?.layer.cornerRadius = 5
        
        self.txtEmail?.placeholder = self.txtEmail?.text
        self.txtEmail?.text = nil
        self.txtPassword.text = nil
        self.txtPassword.placeholder = "********"
        
        if UIScreen.main.sizeType == .iPhone5 {
            // Make specific layout for small devices.
            distanceLogoutAndButton.constant = 30
            distanceLogoutBotton.constant = 20

            
        }else if UIScreen.main.sizeType == .iPhone6 {
            distanceLogoutAndButton.constant = 120
            distanceLogoutBotton.constant = 20
        }

    }
    
    fileprivate func backLoginPage() {
        self.dismiss(animated: false, completion: nil)
        //Change to Login page
        RootViewController.shareInstance.run()
    }
    
     @IBAction public override func btnUpdateTouched(_ sender: AnyObject){
        super.btnUpdateTouched(sender)
    }
    
    
    @IBAction func btnLogoutTouched(_ sender: Any) {
        desk3SettingPresenter?.logout()
    }
    
    @IBAction func btnCloseTouched(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
extension Desk3SettingViewController:Desk3SettingView {
    func onLogoutCallback() {
        self.backLoginPage()
    }

    
}
