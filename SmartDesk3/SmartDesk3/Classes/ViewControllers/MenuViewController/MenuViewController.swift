//
//  MenuViewController.swift
//  SmartDesk
//
//  Created by sa on 3/2/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import UIKit
import REFrostedViewController
import SwiftyJSON
import AutoView
import AutoUtil
import AutoCore
import AutoBL
import AutoCommon

class MenuViewController: BaseTableViewController {

    var arrOptions : [Dictionary<String, AnyObject>]! = []
    var delegate : MenuProtocal?
    
    fileprivate var pRepos:ProductRepos?

    
    @IBOutlet weak var btnCopyright: UIButton!

    
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
    
    // MARK:- Obj
    
    func initObj() {
        
        
        let (jsonObj,message) = Util.jsonFromFile(fileName: "pages")
        if jsonObj != nil {
            if let array = jsonObj?.array {
                for item in array {
                    if let menuDict = item["menu"].dictionaryObject {
                        arrOptions.append(menuDict as [String : AnyObject])
                    }
                }
            }

        }else {
            print(message ?? "")
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(didGetSystemVersion), name: .kNOTI_GET_SYSTEM_VERSION, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(receiveSelectMenuNotification), name: .SelectMenuIndexNotification, object: nil)
        
        
        let pDatabaseRepo = ProductDatabaseReposImpl(database: Database.sharedInstance)
        let uDatabaseRepo = UserDatabaseReposImpl(database: Database.sharedInstance)
        let pServiceRepo = ProductServiceReposImpl(apiService: APIService.sharedInstance)
        pRepos = ProductReposImpl(databaseRepos: pDatabaseRepo, userDatabaseRepos: uDatabaseRepo, serviceRepos: pServiceRepo)
    }
    
    // MARK:- UI
    
    func loadUI() {
        btnCopyright.titleLabel?.font = CUSTOM_FONT.fREGULAR.size(size: 15)
    }

    // MARK:- Functions
    
    func receiveSelectMenuNotification(_ notification:Notification) {
        if let value = notification.object as? NSNumber {
            selectMenuIndx(index: value.intValue)
        }
    }
    
    func selectMenuIndx(index:Int) {
        resetExceptOption(index)
        self.frostedViewController.hideMenuViewController()
        self.tblView?.reloadData()
        
        if delegate != nil {
            delegate?.didSelectIdx(index)
        }
    }
    
    func resetExceptOption(_ idx : Int) {
        for (index, var option) in arrOptions.enumerated() {
            if index == idx {
                option["selected"] = "1" as AnyObject?
            } else {
                option["selected"] = "0" as AnyObject?
            }
            arrOptions[index] = option
        }
    }
    func didGetSystemVersion() {
        print("Receive Get System Version Notification")
        self.tblView?.reloadData()
    }
    
    
    // MARK:- IBAction methods
    
    @IBAction func btnCopyrightTouched(_ sender: Any) {
        
    }
    

}
extension MenuViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectMenuIndx(index: indexPath.row)
    }
}
extension MenuViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOptions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "menuCellIdentifier"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! MenuTableViewCell
        if indexPath.row < arrOptions.count {
            let dict = arrOptions[indexPath.row] as! [String : String]
            cell.updateData(dict)
            
            cell.updateNo(number: 0)
            
            if dict["name"] == "Product Setting" {
                if let versionSystem = AutonomousContext.sharedInstance.dictVersion?["version"] as? String {
                    if let productId = AutonomousContext.sharedInstance.activeDevice{
                        if let product = self.pRepos?.getProduct(productId) {
                            if product.version != versionSystem && (product.version?.characters.count)! > 0 {
                                cell.updateNo(number: 1)
                            }
                        }
                    }
                    
                    
                }
            }
            
        }
        
        return cell
    }

}
