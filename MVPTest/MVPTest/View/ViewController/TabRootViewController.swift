//
//  TabRootViewController.swift
//  MVPTest
//
//  Created by sa on 2/20/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import UIKit

struct TAB {
    static let TAB_NO = 3
    static let APPS_IDX = 0
}

class TabRootViewController: BaseTabBarViewController {

    var tabButtons : [UIButton] = []
    
    class var sharedInstance: TabRootViewController {
        struct Static {
            static let instance = TabRootViewController()
        }
        return Static.instance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if (self.tabBar.viewWithTag(1001) == nil) {
            //let myBar = UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.applicationFrame.width, height: 49))
            let myBar = UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 49))
            myBar.backgroundColor = UIColor.clear
            myBar.tag = 1001
            let count : CGFloat = CGFloat(TAB.TAB_NO)
            //let perWidth = UIScreen.main.applicationFrame.width/count
            let perWidth = UIScreen.main.bounds.width/count
            
            for index in 0...TAB.TAB_NO {
                let bt = UIButton.init(frame: CGRect(x: CGFloat(index)*perWidth, y: 0, width: perWidth, height: 49))
                bt.tag = index
                
                switch index {
                default:
                    break
                }
                
                bt.addTarget(self, action: #selector(onTabbarItemTap(_:)), for: .touchUpInside)
                myBar.addSubview(bt)
                tabButtons.append(bt)
            }
            
            self.tabBar.addSubview(myBar)
        }
        // setIndexFocus(0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onTabbarItemTap(_ sender: UIButton!) {
        let idx = sender.tag
        for bt in tabButtons {
            bt.isSelected = false
        }
        sender.isSelected = true
        self.selectedIndex = idx
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func createUI() {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        
        let vcMyApps = storyboard.instantiateViewController(withIdentifier: "myAppsViewController")
        vcMyApps.tabBarItem = UITabBarItem.init(title: "", image: nil, tag: 1)
        let navMyApps = MyNavigationViewController.init(rootViewController: vcMyApps)
        self.addChildViewController(navMyApps)
        
        /*
        let vcMyRobots = storyboard.instantiateViewController(withIdentifier: "myRobotsViewController")
        vcMyRobots.tabBarItem = UITabBarItem.init(title: "", image: nil, tag: 2)
        let navMyRobots = MyNavigationViewController.init(rootViewController: vcMyRobots)
        self.addChildViewController(navMyRobots)
        
        let vcRobotSetting = storyboard.instantiateViewController(withIdentifier: "updateDeviceViewController")
        vcRobotSetting.tabBarItem = UITabBarItem.init(title: "", image: nil, tag: 3)
        let navRobotSetting = MyNavigationViewController.init(rootViewController: vcRobotSetting)
        self.addChildViewController(navRobotSetting)
        
        let vcSetting = storyboard.instantiateViewController(withIdentifier: "settingViewController")
        vcSetting.tabBarItem = UITabBarItem.init(title: "", image: nil, tag: 4)
        let navSetting = MyNavigationViewController.init(rootViewController: vcSetting)
        self.addChildViewController(navSetting)
 */
        
        //        let vcDemo = storyboard.instantiateViewController(withIdentifier: "voiceDemoController")
        //        vcSetting.tabBarItem = UITabBarItem.init(title: "", image: nil, tag: 5)
        //        let navDemo = MyNavigationViewController.init(rootViewController: vcDemo)
        //        self.addChildViewController(navDemo)
    }
    
    // MARK:- MenuProtocal methods
    
    

}
extension TabRootViewController:MenuProtocal {
    func didSelectIdx(_ idx: Int) {
        self.selectedIndex = idx
        //Refresh Page to load data when tap on Menu
        switch self.selectedIndex {
        case 0:
            NotificationCenter.default.post(name: .RefreshPageNotification, object: PAGE.MYAPPS)
            UtilSwift.trackEvent(name: EVENT.CLICK_MY_APPS, value: "", status: true)
        case 1:
            NotificationCenter.default.post(name: .RefreshPageNotification, object: PAGE.MYROBOTS)
            UtilSwift.trackEvent(name: EVENT.CLICK_MY_ROBOT, value: "", status: true)
            
        case 2:
            NotificationCenter.default.post(name: .RefreshPageNotification, object: PAGE.ROBOT_SETTING)
            UtilSwift.trackEvent(name: EVENT.CLICK_ROBOT_SETTING, value: "", status: true)
            
        case 3:
            NotificationCenter.default.post(name: .RefreshPageNotification, object: PAGE.SETTING)
            UtilSwift.trackEvent(name: EVENT.CLICK_MY_ACCOUNT, value: "", status: true)
            
        default:
            break
        }
    }
}
