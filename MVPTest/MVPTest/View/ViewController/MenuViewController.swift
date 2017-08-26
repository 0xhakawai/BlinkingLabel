//
//  MenuViewController.swift
//  MVPTest
//
//  Created by sa on 2/20/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import UIKit

protocol MenuProtocal {
    func didSelectIdx(_ idx : Int)
}
class MenuViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

}
extension MenuViewController:UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "menuCellIdentifier"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! MenuTableViewCell
        return cell
    }
}
