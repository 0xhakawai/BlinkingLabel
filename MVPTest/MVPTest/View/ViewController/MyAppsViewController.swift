//
//  MyAppsViewController.swift
//  MVPTest
//
//  Created by sa on 2/20/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import UIKit

class MyAppsViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func loadUI() {
        setTitleString("MY APPS", font: fREGULAR(19))
        
        let negativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = SYSTEM_VERSION_LESS_THAN("7.0") ? 0 : -5
        
        self.navigationItem.leftBarButtonItems = NSArray.init(objects: negativeSpacer, super.createBarButtonItem(UIImage.init(named: "left_menu"),
                                                                                                                 highlightState: nil,
                                                                                                                 widthCap: 5,
                                                                                                                 heightCap: 0,
                                                                                                                 buttonWidth: NSNumber.init(value: 29 as Int32),
                                                                                                                 title: "",
                                                                                                                 font: fREGULAR(15),
                                                                                                                 color: UIColor.white,
                                                                                                                 target: self,
                                                                                                                 selector: #selector(toggleLeft))) as? [UIBarButtonItem]
        
        
        self.navigationItem.rightBarButtonItems = NSArray.init(objects: negativeSpacer, super.createBarButtonItem(UIImage.init(named: "fake"),
                                                                                                                  highlightState: nil,
                                                                                                                  widthCap: 5,
                                                                                                                  heightCap: 0,
                                                                                                                  buttonWidth: NSNumber.init(value: 22 as Int32),
                                                                                                                  title: "     ",
                                                                                                                  font: fREGULAR(15),
                                                                                                                  color: UIColor.white,
                                                                                                                  target: nil,
                                                                                                                  selector: #selector(MyAppsViewController.empty))) as? [UIBarButtonItem]
        
    }
    func empty() {
        
    }

}
extension MyAppsViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "myAppCellIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        return cell!

    }
}
