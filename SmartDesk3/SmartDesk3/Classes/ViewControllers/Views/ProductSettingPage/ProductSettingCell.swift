//
//  ProductSettingCell.swift
//  AutonomousView
//
//  Created by sa on 5/12/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import UIKit
import AutoUtil
import AutoCommon
import AutoView

@objc protocol ProductSettingCellDelegate {
    func configure(cell:ProductSettingCell, object:[String:AnyObject])
    func didChangeValue(newValue text:String, object:[String:AnyObject])
    @objc optional func switchButtonValueChanged(object:[String:AnyObject], value:Bool)
    @objc optional func btnActionTouched(object:[String:AnyObject])
    @objc optional func sliderChangeValue(object:[String:AnyObject], newValue:Float)
    @objc optional func sliderRelease(object:[String:AnyObject])
}

class ProductSettingCell: UITableViewCell {

    @IBOutlet weak var txtInfo: MyTextField!
    @IBOutlet weak var btnSwitch: UISwitch!
    @IBOutlet weak var btnAction: UIButton!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var lblSliderValue: UILabel!
    
    @IBOutlet weak var lbSmallText: UILabel!
    @IBOutlet weak var lblNofi: UILabel!
    
    var item:[String:AnyObject]?
    var delegate:ProductSettingCellDelegate?

    
    func updateData(product object:[String:AnyObject]?) {
        btnSwitch.isHidden = true
        btnAction.isHidden = true
        txtInfo.isHidden = true
        slider.isHidden = true
        lblSliderValue.isHidden = true
        lbSmallText.isHidden = true
        lblNofi.isHidden = true
        
        self.item = object
        
        imageView?.image = UIImage.init(named: (object?["image"])! as! String, in: Bundle(for: NetworkConfigViewController.self), compatibleWith: nil)
        
        txtInfo.font = CUSTOM_FONT.fREGULAR.size(size: 15)
        txtInfo.delegate = self
        txtInfo.text = object?["value"] as! String?
        
        txtInfo.textColor = kGRAY_COLOR
        txtInfo.isUserInteractionEnabled = (object?["isEdited"]?.boolValue)!
        
        txtInfo.returnKeyType = .done
        txtInfo.clearButtonMode = .whileEditing
        txtInfo.addTarget(self, action: #selector(self.textFieldDidChange(textfield:)), for:UIControlEvents.editingChanged)
        
        slider.maximumValue = 10.0
        slider.minimumValue = 4.0
        
        lblSliderValue.font = CUSTOM_FONT.fREGULAR.size(size: 15)
        lblSliderValue.textColor = kGRAY_COLOR
        
        lbSmallText.font = CUSTOM_FONT.fREGULAR.size(size: 11)
        lbSmallText.textColor = kGRAY_COLOR
       
        delegate?.configure(cell: self, object: object!)
    }
    
    // MARK:- IBAction methods
    
    @IBAction func btnSwitchChangeValue(_ sender: AnyObject) {
        delegate?.switchButtonValueChanged!(object: self.item!, value: btnSwitch.isOn)
    }
    
    @IBAction func btnActionClick(_ sender: AnyObject) {
        delegate?.btnActionTouched!(object: self.item!)
    }
    
    @IBAction func sliderValueChanged(_ sender: AnyObject) {
        lblSliderValue.text = String(describing:Int(slider.value))
        delegate?.sliderChangeValue!(object: self.item!, newValue: slider.value)
    }
    
    @IBAction func sliderRelease(_ sender: AnyObject) {
        delegate?.sliderRelease!(object: self.item!)
    }

}
extension ProductSettingCell:UITextFieldDelegate {
    func textFieldDidChange(textfield:UITextField) {
        self.delegate?.didChangeValue(newValue: textfield.text!, object: self.item!)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
