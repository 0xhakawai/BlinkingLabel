//
//  TabRootViewController.swift
//  SmartDesk
//
//  Created by sa on 3/2/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import UIKit
import AutoView
import AutoUtil
import AutoCommon
import AutoCore

class TabRootViewController: BaseTabBarViewController {

    static var shareInstance = TabRootViewController()
    
    enum PAGE: Int {
        case CHECKIN = 0
        case DESK_INFO = 1
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initObj()
        setupViews()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- FUNCTIONS
    func setupViews() {
        addControllers()
    }
    
    func initObj() {
        NotificationCenter.default.addObserver(self, selector: #selector(changeProduct), name: .kNOTI_UPDATE_ACTIVE_DEVICE, object: nil)
    }
    
    func addControllers() {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        
        let (jsonObj,message) = Util.jsonFromFile(fileName: "pages")
        if jsonObj != nil {
            if let array = jsonObj?.array {
                for item in array {
                    if let nibDict = item["nib"].dictionary {
                        var viewController:UIViewController?
                        if let identifier = nibDict["indentifier"]?.string {
                            print(identifier)
                            if let isframework = nibDict["is_framework"]?.string {
                                if isframework == "1" {
                                    viewController = AutonomousView.createPage(identifier)
                                    
                                }else {
                                    viewController = storyboard.instantiateViewController(withIdentifier: identifier)
                                }
                            }
                            
                            
                        }
                        if viewController != nil {
                            let navigation = BaseNavigationViewController.init(rootViewController: viewController!)
                            self.addChildViewController(navigation)
                            if let baseViewController = viewController as? BaseViewController {
                                baseViewController.actionDelegate = self
                            }
                        }
                        
                        
                        
                    }
                }
            }
            
        }else {
            print(message ?? "")
        }
    }
    
    
    func setIndexFocus(_ index: Int) {
        self.selectedIndex = index
        didSelectIdx(index)
        NotificationCenter.default.post(name: .SelectMenuIndexNotification, object: NSNumber(value: index))
    }
    
    func resetTabs() {
        self.setViewControllers(nil, animated: true)
        setupViews()
        print("Controller count", self.viewControllers?.count ?? "")
    }
 
    
    // MARK:- Notification methods
    
    func changeProduct() {
        if let _ = AutonomousContext.sharedInstance.activeDevice {
            setIndexFocus(PAGE.DESK_INFO.rawValue)
        } else {
            setIndexFocus(PAGE.CHECKIN.rawValue)
        }
    }
}

extension TabRootViewController: MenuProtocal {
    func didSelectIdx(_ idx: Int) {
        tabBar.isHidden = true
        self.selectedIndex = idx

    }
}
extension TabRootViewController: CallBackActionDelegate {
    func onDoBackCallBack(_ controller: AnyObject) {
        let viewController = controller as? BaseViewController
        if let myNavigation = viewController?.navigationController as? BaseNavigationViewController {
            myNavigation.showMenu()
            
        }
    }

    
}
extension TabRootViewController: MyProductsCallBackActionDelegate {
    func onAddButtonCallBack() {
        self.present(AutonomousView.createScanningPage(), animated: true, completion: nil)

    }

    func onSelectRowCallBack(vc: UIViewController) {
        let vcProductSetting = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "productSettingViewController")
        vc.navigationController?.pushViewController(vcProductSetting, animated: true)

    }
}

extension TabRootViewController: AccountSettingCallBackActionDelegate {
    func onDidLogoutSuccessfullCallBack() {
        //Change to Login page
        RootViewController.shareInstance.run()
        
        //Clear tabbar pages
        TabRootViewController.shareInstance.resetTabs()
        
    }
}


