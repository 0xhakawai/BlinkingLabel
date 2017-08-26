//
//  BaseViewController.swift
//  MVPTest
//
//  Created by sa on 2/20/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

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
    
    func createBarButtonItem(_ normalState: UIImage?, highlightState: UIImage?, widthCap: Int, heightCap: Int,  buttonWidth: NSNumber, title: String, font: UIFont?, color: UIColor?, target: AnyObject?, selector: Selector) -> UIBarButtonItem {
        
        let btn : UIButton!
        btn = UIButton.init(type: .custom)
        if title.characters.count == 0 {
            btn.frame = CGRect(x: 0, y: 0, width: CGFloat(buttonWidth), height: (normalState != nil) ? (normalState?.size.height)! : 0.0)
            
        } else {
            let size = getSizeOfString(title, font: font!)
            btn.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            
        }
        
        if normalState != nil {
            btn.setImage(normalState, for: UIControlState())
        }
        
        
        if highlightState != nil {
            btn.setImage(highlightState, for: .highlighted)
        }
        
        btn.addTarget(self, action: selector, for: .touchUpInside)
        
        if title.characters.count > 0 {
            let lbl = UILabel.init(frame: btn.frame)
            lbl.font = font
            lbl.backgroundColor = UIColor.clear
            lbl.textColor = kGRAY_COLOR
            lbl.shadowColor = UIColor.white
            lbl.shadowOffset = CGSize(width: 0, height: 0.5)
            lbl.text = title
            lbl.textAlignment = .center
            lbl.sizeToFit()
            btn.addSubview(lbl)
        }
        
        let barBtnItem = UIBarButtonItem.init(customView: btn)
        return barBtnItem
    }
    
    func setTitleString(_ title : String, font : UIFont) {
        let titleView = self.navigationItem.titleView
        var lblTitle = titleView as? UILabel
        
        if lblTitle == nil || lblTitle!.tag != 1899 {
            lblTitle = UILabel.init(frame: CGRect(x: 0, y: 0, width: 800, height: 48))
            lblTitle!.tag = 1899
            lblTitle!.text = title
            lblTitle!.textColor = kGRAY_COLOR
            lblTitle!.shadowColor = UIColor.clear
            lblTitle!.shadowOffset = CGSize(width: 0, height: 0.5)
            lblTitle!.backgroundColor = UIColor.clear
            lblTitle!.textAlignment = .center
            self.navigationItem.titleView = lblTitle
        }
        lblTitle!.text = title
        lblTitle!.font = font
    }
    func getSizeOfString(_ str: String, font: UIFont) -> CGSize {
        let string = str as NSString!
        return string!.size(attributes: [NSFontAttributeName: font])
    }

}
