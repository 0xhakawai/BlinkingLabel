//
//  CheckinViewController.swift
//  SmartDesk3
//
//  Created by sa on 7/28/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import UIKit
import AutoUtil
import AutoCore

class CheckinViewController: UIViewController {

    @IBOutlet weak var btnCheckin: UIButton!
    var shouldOpenQRCode = false
    
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true

    }
    
    fileprivate func initObj() {
        
    }
    
    fileprivate func loadUI() {
        self.btnCheckin?.backgroundColor = PRODUCT_COLOR.kBlueColor
        self.btnCheckin?.titleLabel?.font = CUSTOM_FONT.fREGULAR.size(size: 32)
        self.btnCheckin.layer.cornerRadius = self.btnCheckin.frame.size.width/2.0

    }
    
    func openQRCodePage() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vcScanner = storyBoard.instantiateViewController(withIdentifier: "qrCodeScannerController") as! QRCodeScannerController
        vcScanner.actionDelegate = self
        self.present(vcScanner, animated: true, completion: nil)
    }
    
    fileprivate func openSettingPage(){
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vcScanner = storyBoard.instantiateViewController(withIdentifier: "desk3SettingViewController") as! Desk3SettingViewController
        self.present(vcScanner, animated: true, completion: nil)
    }
    
    // MARK:- IBAction methods
    
    @IBAction func btnCheckinTouched(_ sender: Any) {
        //Open QRCode Page
        openQRCodePage()
    }
    
    @IBAction func btnSettingTouched(_ sender: Any) {
        //Open Setting Page
        openSettingPage()
    }
}

extension CheckinViewController:QRCodeScannerCallBackActionDelegate {
    func onAddProductCallBack(_ controller: AnyObject) {
        if let _ = controller as? UIViewController {
            RootViewController.shareInstance.run()
        }
    }
}
