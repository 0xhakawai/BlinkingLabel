//
//  BaseNavigationViewController.swift
//  SmartDesk
//
//  Created by sa on 3/1/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import UIKit

open class BaseNavigationViewController: UINavigationController {

    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- FUNCTIONS
    
    func showMenu() {
        self.view.endEditing(true)
        self.frostedViewController.view.endEditing(true)
        self.frostedViewController.presentMenuViewController()
    }
    func transparentNavigationBar()  {
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.view.backgroundColor = UIColor.clear
    }
    
}
