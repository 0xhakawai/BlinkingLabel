//
//  DeskInfoViewController.swift
//  SmartDesk3
//
//  Created by sa on 7/28/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import UIKit
import AutoUtil
import AutoCommon
import AutoBL
import AutoCore
import AutoView

class DeskInfoViewController: BaseViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnCheckout: UIButton!
    fileprivate var product:ProductObj? = nil
    fileprivate var presenter:DeskInfoPresenter? = nil
    var pRepos: ProductReposImpl? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initObj()
        loadGUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func initObj() {
        let pDatabaseRepos = ProductDatabaseReposImpl.init(database: Database.sharedInstance)
        let uDatabaseRepos = UserDatabaseReposImpl.init(database: Database.sharedInstance)
        let pServiceRepos = ProductServiceReposImpl.init(apiService: APIService.sharedInstance)
        pRepos = ProductReposImpl.init(databaseRepos: pDatabaseRepos, userDatabaseRepos: uDatabaseRepos, serviceRepos: pServiceRepos)
        presenter = DeskInfoPresenterImpl.init(view: self, repos: pRepos!)
    }
    
    fileprivate func loadGUI() {
        self.lblName.font = CUSTOM_FONT.fREGULAR.size(size: 16)
        self.btnCheckout.titleLabel?.font = CUSTOM_FONT.fREGULAR.size(size: 16)
        self.btnCheckout.backgroundColor = PRODUCT_COLOR.kBlueColor
        self.btnCheckout.layer.cornerRadius = 5
        
        

    }
    
    private func loadData() {
        if let _ = AutonomousContext.sharedInstance.activeDevice {
            if (AutonomousContext.sharedInstance.activeDevice?.characters.count)! > 0 {
                product = pRepos?.getProduct(AutonomousContext.sharedInstance.activeDevice!)
                if let _ = product {
                    self.lblName.text = String(format: "SmartDesk #%@",(product?.product_id)! )
                }
            }
        }
    }
    
    fileprivate func openSettingPage(){
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vcSetting = storyBoard.instantiateViewController(withIdentifier: "desk3SettingViewController") as! Desk3SettingViewController
        self.present(vcSetting, animated: true, completion: nil)
    }
    
    fileprivate func backCheckinPage(){
        AutonomousContext.sharedInstance.activeDevice = nil
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    fileprivate func showConfirmDeleteOfflinePopup(_ object:ProductObj)  {
        let message = String (format: "The %@ has lost connection.\n Please checkout at TouchScreen",APP_CONFIG.NAME_KEY, object.product_name)
        let actionSheet = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
//        }
       // actionSheet.addAction(cancelAction)
        
        let takePhotoAction = UIAlertAction(title: "OK", style:.destructive) { (action:UIAlertAction!) in
            self.backCheckinPage()

        }
        
        actionSheet.addAction(takePhotoAction)
        self.present(actionSheet, animated: true, completion:nil)
        
        
    }
    
    @IBAction func btnSettingTouched(_ sender: Any) {
        openSettingPage()
    }

    @IBAction func btnCheckoutTouched(_ sender: Any) {
        presenter?.checkOut()
    }
}

extension DeskInfoViewController:DeskInfoView {
    func onCheckoutCallback(_ value: Bool) {
        if value {
            self.backCheckinPage()
        }else {
            self.showConfirmDeleteOfflinePopup(self.product!)
        }
    }
}
