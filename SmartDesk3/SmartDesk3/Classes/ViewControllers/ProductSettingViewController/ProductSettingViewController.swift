//
//  ProductSettingViewController.swift
//  AutonomousView
//
//  Created by sa on 5/12/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import UIKit
import AutoCommon
import AutoCore
import AutoBL
import AutoUtil
import AutoView

enum UPDATE_DEVICE_FIELDS:String {
    case hoten
    case touchid
    case robotid
    case wifi
    case ip
    case microphone
    case address
    case volume
    case height
    case testing_mode
    case update_firmware
    case current_version
}

class ProductSettingViewController: BaseTableViewController {
    
    fileprivate var productSettingPresenter: ProductSettingPresenter? = nil
    fileprivate var deviceInfo:[[String:String]] = []
    fileprivate var changedInfo: [[String:String]] = []
    fileprivate var systemInfo: [[String:String]] = []
    fileprivate var product:ProductObj?
    
    fileprivate var isMicOn = true
    fileprivate var volumeValue = CONFIG.kDefaultVolume
    fileprivate var address:String = ""
    fileprivate var newName:String?
    
    @IBOutlet weak var lblIP: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initObj()
        loadUI()
        if self.product != nil {
            productSettingPresenter?.getIPAddress(productId: (self.product?.product_id)!)
            productSettingPresenter?.getVolume(productId: (self.product?.product_id)!)
        }

        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        removeNotification()
    }
    
    // MARK:- Obj
    
    func initObj() {
        let pDatabaseRepos = ProductDatabaseReposImpl.init(database: Database.sharedInstance)
        let uDatabaseRepos = UserDatabaseReposImpl.init(database: Database.sharedInstance)
        let pServiceRepos = ProductServiceReposImpl.init(apiService: APIService.sharedInstance)
        let pRepos = ProductReposImpl.init(databaseRepos: pDatabaseRepos, userDatabaseRepos: uDatabaseRepos, serviceRepos: pServiceRepos)
        productSettingPresenter = ProductSettingPresenterImpl.init(view: self, repos: pRepos)
        
        if AutonomousContext.sharedInstance.activeDevice != nil {
            product = productSettingPresenter?.getProduct(AutonomousContext.sharedInstance.activeDevice)
            if let _ = AutonomousContext.sharedInstance.data.value?["volume"] {
                volumeValue = convertVolumeToPhoneValue(value: Int((AutonomousContext.sharedInstance.data.value?["volume"]!)!)!)
            }
        }
        
        createDeviceInfo()
        createChangedInfo()
        createSystemInfo()
        addNotification()
        
        GlobalMainQueue.asyncAfter(deadline: .now() + 0.25) {
            self.tblView?.reloadData()
        }
    }
    
    func createDeviceInfo() {
        if self.product != nil {
            self.deviceInfo = [["image":"icon-hoten", "key":UPDATE_DEVICE_FIELDS.hoten.rawValue,"isEdited":"1", "value":product!["product_name"] as! String],
                               ["image":"touch_id", "key":UPDATE_DEVICE_FIELDS.touchid.rawValue,"isEdited":"0", "value":product!["product_id"] as! String],
                               ["image":"robot_icon", "key":UPDATE_DEVICE_FIELDS.robotid.rawValue,"isEdited":"0", "value":CONFIG.kProductName]]
        }
    }
    
    func createChangedInfo() {
        if self.product != nil {
            if let addressTemp = product!["address"] as? String  {
                address = addressTemp
            }
            self.changedInfo = [["image":"address", "key":UPDATE_DEVICE_FIELDS.address.rawValue,"isEdited":"0", "value":address],
                                ["image":"volume", "key":UPDATE_DEVICE_FIELDS.volume.rawValue,"isEdited":"0", "value": ""],
                                ["image":"", "key":UPDATE_DEVICE_FIELDS.height.rawValue, "isEdited":"0", "value": "Change your standing/sitting height"]]
        }
    }
    
    func createSystemInfo() {
        if self.product != nil {
            self.systemInfo = [["image":"wifi", "key":UPDATE_DEVICE_FIELDS.wifi.rawValue, "isEdited":"0", "value": "Update wifi"],
                               ["image":"", "key":UPDATE_DEVICE_FIELDS.testing_mode.rawValue, "isEdited":"0", "value": "Testing mode"],
                               ["image":"", "key":UPDATE_DEVICE_FIELDS.update_firmware.rawValue, "isEdited":"0", "value": "Update firmware"]]
        }
    }
    
    // MAKR:- UI methods
    
    override func refreshData() {
        if let productId = AutonomousContext.sharedInstance.activeDevice {
            self.product = self.productSettingPresenter?.getProduct(productId)
            self.tblView?.reloadData()
        }
    }
    
    func loadUI()  {
        setTitleString("  PRODUCT SETTING", font: CUSTOM_FONT.fREGULAR.size(size:19))
        pageName = PAGE.PRODUCT_SETTING
        
        
        let negativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = SYSTEM_VERSION_LESS_THAN("7.0") ? 0 : -5
        
        self.navigationItem.leftBarButtonItems = NSArray.init(objects: negativeSpacer, super.createBarButtonItem(UIImage.init(named: "nav_back", in: Bundle(for: NetworkConfigViewController.self), compatibleWith: nil),
                                                                                                                 highlightState: nil,
                                                                                                                 widthCap: 5,
                                                                                                                 heightCap: 0,
                                                                                                                 buttonWidth: NSNumber.init(value: 12 as Int32),
                                                                                                                 title: "",
                                                                                                                 font: CUSTOM_FONT.fREGULAR.size(size:15),
                                                                                                                 color: UIColor.white,
                                                                                                                 target: self,
                                                                                                                 selector: #selector(btnCloseTouched))) as? [UIBarButtonItem]
        
        
        self.navigationItem.rightBarButtonItems = NSArray.init(objects: negativeSpacer, super.createBarButtonItem(UIImage.init(named: "fake"),
                                                                                                                  highlightState: nil,
                                                                                                                  widthCap: 5,
                                                                                                                  heightCap: 0,
                                                                                                                  buttonWidth: NSNumber.init(value: 18 as Int32),
                                                                                                                  title: "Save",
                                                                                                                  font: CUSTOM_FONT.fREGULAR.size(size:15),
                                                                                                                  color: UIColor.white,
                                                                                                                  target: nil,
                                                                                                                  selector: #selector(btnDoneTouched))) as? [UIBarButtonItem]
        
        
        lblIP.font = CUSTOM_FONT.fREGULAR.size(size: 14.0)
    }
    
    // MARK:- Selector methods
    
    func btnCloseTouched() {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    func btnDoneTouched() {
        let productId = self.product?.product_id
        let productName = self.product?.product_name
        print(productName ?? "")
        let productType = self.product?.product_type
        let address = self.product?.address
        let addressLon = self.product?.lng
        let addressLat = self.product?.lat
        let source = "iOS"
        var timezone: String { return (NSTimeZone.local as NSTimeZone).name }
        let data = ""
        productSettingPresenter?.updateProduct(productId: productId!,productName: productName!, productType: productType!, address: address!, addressLon: addressLon!, addressLat: addressLat!, source: source, timezone: timezone, data: data)
    }
    
    // MARK:- Functions
    
    func convertVolumeToPhoneValue(value: Int) -> Int {
        if value > 0 && value <= 70 {
            return 4
        }
        
        if value > 70 && value <= 75 {
            return 5
        }
        
        if value > 75 && value <= 80 {
            return 6
        }
        
        if value > 80 && value <= 85 {
            return 7
        }
        
        if value > 85 && value <= 90 {
            return 8
        }
        
        if value > 90 && value <= 95 {
            return 9
        }
        
        if value > 95 && value <= 100 {
            return 10
        }
        
        return 10
    }
    
    func convertPhoneValueToVolume(value: Int) -> Int {
        switch value {
        case 4:
            return 70
        case 5:
            return 75
        case 6:
            return 80
        case 7:
            return 85
        case 8:
            return 90
        case 9:
            return 95
        case 10:
            return 100
        default:
            break
        }
        
        return 100
    }
    
    func openMap()  {
        if let controller = AutonomousView.createMapPage() as? MapViewController {
            controller.actionDelegate = self
            if self.product?.address != nil {
                controller.loadLocation((self.product?.address)!, lat: (self.product?.lat)!, lon: (self.product?.lng)!)
                
            }
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func openSoftwareUpdatePage() {
        if let controller = AutonomousView.createSoftwareUpdatePage() as? SoftwareUpdateViewController {
            controller.actionDelegate = self
            controller.productId = self.product?.product_id
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
    }
    
    func openStandingSittingHeight() {
        let vcStandingSitting = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "setStandingSittingHeight")
        let nav = UINavigationController.init(rootViewController: vcStandingSitting)
        self.present(nav, animated: true) { 
            
        }
    }
    
    func openUpdateWifiPage() {
        if let controller = AutonomousView.createScanningPage() as? ScanningViewController {
            controller.actionDelegate = self
            controller.isUpdateWifi = true
            self.present(controller, animated: true, completion: nil)
            
        }
    }
    func openTestingModePage() {
        let vcStandingSitting = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "testingModeViewController")
        self.navigationController?.pushViewController(vcStandingSitting, animated: true)
    }
    
    func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(didGetSystemVersion), name:  .kNOTI_GET_SYSTEM_VERSION, object: nil)
    }
    
    func removeNotification() {
        NotificationCenter.default.removeObserver(self, name: .kNOTI_GET_SYSTEM_VERSION, object: nil)
    }
    
    func didGetSystemVersion() {
        self.product = self.productSettingPresenter?.getProduct(AutonomousContext.sharedInstance.activeDevice)
        self.tblView?.reloadData()
    }
    
}
extension ProductSettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as? ProductSettingCell
        if let _ = cell {
            if let key = cell?.item?["key"] as? String {
                switch key {
                case UPDATE_DEVICE_FIELDS.update_firmware.rawValue:
                    openSoftwareUpdatePage()
                    
                case UPDATE_DEVICE_FIELDS.height.rawValue:
                    openStandingSittingHeight()
                    
                case UPDATE_DEVICE_FIELDS.wifi.rawValue:
                    openUpdateWifiPage()
                    
                case UPDATE_DEVICE_FIELDS.testing_mode.rawValue:
                    openTestingModePage()
                    
                default: break
                    
                }
            }
        }
    }
}
extension ProductSettingViewController:UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.product != nil {
            return 3
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return deviceInfo.count
        case 1:
            return changedInfo.count
        case 2:
            return systemInfo.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = String(format: "productSettingTableViewCell", indexPath.section,indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ProductSettingCell
        cell.accessoryType = .none
        
        switch indexPath.section {
        case 0:
            let dict:[String:String] = deviceInfo[indexPath.row]
            cell.updateData(product: dict as [String : AnyObject])
            
        case 1:
            let dict:[String:String] = changedInfo[indexPath.row]
            cell.updateData(product: dict as [String : AnyObject])
            
        case 2:
            let dict:[String:String] = systemInfo[indexPath.row]
            cell.updateData(product: dict as [String : AnyObject])
            
        default:
            break
        }
        
        cell.delegate = self
        
        return cell
        
    }
}
extension ProductSettingViewController:ProductSettingView {
    func onUpdateVolumeCallback() {
        if let _ = AutonomousContext.sharedInstance.data.value?["volume"] {
            volumeValue = convertVolumeToPhoneValue(value: Int((AutonomousContext.sharedInstance.data.value?["volume"]!)!)!)
            
            self.tblView?.reloadData()

        }
    }
    func onUpdateProductCallback() {
        if let productId = AutonomousContext.sharedInstance.activeDevice {
            self.product = self.productSettingPresenter?.getProduct(productId)
            
            self.lblIP.text = "IP: " + (self.product?.iPAddress)!
            self.tblView?.reloadData()

        }
    }
    
    func onProductSettingCallback(value: Bool) {
        
    }
    
}
extension ProductSettingViewController:ProductSettingCellDelegate {
    func configure(cell:ProductSettingCell, object:[String:AnyObject]){
        if let key = object["key"] as? String {
            cell.txtInfo.isHidden = false
            cell.btnAction.setImage(nil, for: .normal)

            switch key {
            case UPDATE_DEVICE_FIELDS.microphone.rawValue:
                cell.btnSwitch.isHidden = false
                
            case UPDATE_DEVICE_FIELDS.address.rawValue:
                cell.btnAction.isHidden = false
                let image = UIImage.init(named: "map", in: Bundle(for: BaseViewController.self), compatibleWith: nil)
                cell.btnAction.setImage(image, for: .normal)
                cell.txtInfo.text = self.product?.address
                
            case UPDATE_DEVICE_FIELDS.volume.rawValue:
                cell.txtInfo.isHidden = true
                cell.slider.isHidden = false
                cell.lblSliderValue.isHidden = false
                cell.slider.value = Float(volumeValue)
                cell.lblSliderValue.text = String(describing:Int(cell.slider.value))
                
            case UPDATE_DEVICE_FIELDS.height.rawValue:
                cell.accessoryType = .disclosureIndicator
                
            case UPDATE_DEVICE_FIELDS.robotid.rawValue, UPDATE_DEVICE_FIELDS.touchid.rawValue:
                cell.txtInfo.textColor = kLIGHT_GRAY_COLOR
                
            case UPDATE_DEVICE_FIELDS.update_firmware.rawValue:
                cell.accessoryType = .disclosureIndicator
                cell.lbSmallText.isHidden = false
                
                if let versionSystem = AutonomousContext.sharedInstance.dictVersion?["version"] as? String {
                    if self.product?.version != versionSystem && (self.product?.version?.characters.count)! > 0{
                        cell.lblNofi.isHidden = false
                    }
                    cell.lblNofi.text = String(describing: AutonomousContext.sharedInstance.dictVersion!["version"]!)
                    if (self.product?.version?.characters.count)! > 0 {
                        cell.lbSmallText.text = String(format: "(%@)", self.product!.version!)
                        
                    } else {
                        cell.lbSmallText.text = ""
                    }
                    
                } else {
                    cell.lblNofi.isHidden = true
                }
                
                
            case UPDATE_DEVICE_FIELDS.testing_mode.rawValue, UPDATE_DEVICE_FIELDS.wifi.rawValue:
                cell.accessoryType = .disclosureIndicator
                
            default:
                break
            }
        }
    }
    
    func didChangeValue(newValue text: String, object: [String : AnyObject]) {
        print("Change text",text)
        if let key = object["key"] as? String {
            if (key == UPDATE_DEVICE_FIELDS.hoten.rawValue){
                self.product!.product_name = text
            }
        }
        
    }
    
    func switchButtonValueChanged(object:[String:AnyObject], value:Bool){
        if let key = object["key"] as? String {
            if key == UPDATE_DEVICE_FIELDS.microphone.rawValue {
                self.isMicOn = value
            }
        }
        
    }
    func btnActionTouched(object:[String:AnyObject]){
        if let key = object["key"] as? String {
            if key == UPDATE_DEVICE_FIELDS.address.rawValue {
                openMap()
            }
        }
    }
    func sliderChangeValue(object:[String:AnyObject], newValue:Float){
        if let key = object["key"] as? String {
            if key == UPDATE_DEVICE_FIELDS.volume.rawValue {
                self.volumeValue = Int(newValue)
            }
        }
    }
    
    func sliderRelease(object:[String:AnyObject]){
        let productId = self.product?.product_id
        productSettingPresenter?.updateVolume(productId: productId!, value: convertPhoneValueToVolume(value: self.volumeValue))
        
    }
}
extension ProductSettingViewController:MapCallBackActionDelegate {
    public func onSelectAddressCallback(_ dict: NSMutableDictionary) {
        if let dictData = dict["coordinate"] as? [String:AnyObject] {
            self.product?.lat = dictData["lat"] as! Double
            self.product?.lng = dictData["lon"] as! Double
            
            if let address = dict["address"] as? String {
                self.product?.address = address
            }
            self.tblView?.reloadData()
        }
    }
}
extension ProductSettingViewController:SoftwareUpdateCallBackActionDelegate {
    public func onDidUpdateFirmware() {
        print("onDidUpdateFirmware")
        self.navigationController?.popToViewController(self, animated: true)
        self.product = self.productSettingPresenter?.getProduct(AutonomousContext.sharedInstance.activeDevice)
        self.tblView?.reloadData()
        
    }
}
