//
//  QRCodeViewController.swift
//  SmartDesk3
//
//  Created by sa on 7/20/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import UIKit
import AVFoundation
import AutoView
import AutoUtil
import AutoCommon
import AutoCore
import AutoBL

class QRCodeScannerController: BaseViewController {

    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var btnClose: UIButton!
    
    fileprivate var captureSession:AVCaptureSession?
    fileprivate var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    
    fileprivate var qrCodeFrameView:UIView?
    fileprivate var frameRectGreen:CGRect?
    
    fileprivate var presenter:QRCodeScannerPresenter? = nil
    
    fileprivate var qrCodeScannerActionDelegate:QRCodeScannerCallBackActionDelegate? {
        get {
            return self.actionDelegate as? QRCodeScannerCallBackActionDelegate
        }
    }

    let supportedCodeTypes = [AVMetadataObjectTypeUPCECode,
                              AVMetadataObjectTypeCode39Code,
                              AVMetadataObjectTypeCode39Mod43Code,
                              AVMetadataObjectTypeCode93Code,
                              AVMetadataObjectTypeCode128Code,
                              AVMetadataObjectTypeEAN8Code,
                              AVMetadataObjectTypeEAN13Code,
                              AVMetadataObjectTypeAztecCode,
                              AVMetadataObjectTypePDF417Code,
                              AVMetadataObjectTypeQRCode]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initObj()
        loadUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - internal functions

    fileprivate func initObj() {
        let productDatabaseRepos = ProductDatabaseReposImpl.init(database: Database.sharedInstance)
        let uDatabaseRepos = UserDatabaseReposImpl.init(database: Database.sharedInstance)
        let productServiceRepos = ProductServiceReposImpl.init(apiService: APIService.sharedInstance)
        let pRepos = ProductReposImpl.init(databaseRepos: productDatabaseRepos, userDatabaseRepos: uDatabaseRepos, serviceRepos: productServiceRepos)
        presenter = QRCodeScannerPresenterImpl.init(view: self, repos: pRepos)

    }
    
    fileprivate func loadUI() {
        
        self.lblTitle.font = CUSTOM_FONT.fREGULAR.size(size: 32)
        self.lblTitle.text = "Scan the QR code on\n SmartDesk"
        
        self.createScanView()
        
        self.createQRCodeRectangle()
    }
    
    fileprivate func createScanView() {
        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video as the media type parameter.
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Initialize the captureSession object.
            captureSession = AVCaptureSession()
            
            // Set the input device on the capture session.
            captureSession?.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            self.view.layer.addSublayer(videoPreviewLayer!)
            
            // Start video capture.
            captureSession?.startRunning()
            
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }

    }
    
    fileprivate func createQRCodeRectangle() {
        let width = self.view.frame.size.width - 20*2

        let x = (self.view.frame.size.width - CGFloat(width))/2.0
        let y = self.lblTitle.frame.origin.y + self.lblTitle.frame.size.height + 30
        frameRectGreen = CGRect(x:x, y:y, width:CGFloat(width), height:CGFloat(width))
        
        // Move the message label and top bar to the front
        view.bringSubview(toFront: lblTitle)
        view.bringSubview(toFront: btnClose)
        
        // Initialize QR Code Frame to highlight the QR code
        qrCodeFrameView = UIView()
        
        
        if let qrCodeFrameView = qrCodeFrameView {
            
            qrCodeFrameView.layer.borderColor = PRODUCT_COLOR.kBlueColor.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            qrCodeFrameView.layer.cornerRadius = 10
            qrCodeFrameView.frame = frameRectGreen!
            view.addSubview(qrCodeFrameView)
            view.bringSubview(toFront: qrCodeFrameView)
        }
    }

    fileprivate func getProductIdFromCode(_ code:String) -> String?{
        let arrStr = code.components(separatedBy: "_")
        if arrStr.count > 1 {
            let format = arrStr[0]
            if format == AUTHORIZATION_KEY {
                let productId = arrStr[1]
                return productId
            }
        }
        return nil
    }
    
    
    fileprivate func callGetProductId(_ code:String) {
        captureSession?.stopRunning()
        if let productId = getProductIdFromCode(code) {
            self.presenter?.addProductId(productId, productName: APP_CONFIG.NAME, productType: APP_CONFIG.TYPE, address: Util.validateStr(AutonomousContext.sharedInstance.address), addressLon: AutonomousContext.sharedInstance.lon, addressLat: AutonomousContext.sharedInstance.lat, data: Util.stringFromHashable(dictionary: AutonomousContext.sharedInstance.data.value!)!)
        }else {
            showAlertMessage()
        }
    }
    
    fileprivate func showAlertMessage(){
        let alert = UIAlertController(title: "", message: "The QRCode is invalid.\n Please try a QRCode from SmartDesk", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.captureSession?.startRunning()

        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func synced(_ lock: Any, closure: () -> ()) {
        objc_sync_enter(lock)
        closure()
        objc_sync_exit(lock)
    }
    
    // MARK:- IBAction method
    
    @IBAction func btnCloseTouched(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
extension QRCodeScannerController:AVCaptureMetadataOutputObjectsDelegate {
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            //qrCodeFrameView?.frame = CGRect.zero
            //messageLabel.text = "No QR/barcode is detected".

            qrCodeFrameView?.frame = frameRectGreen!
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if supportedCodeTypes.contains(metadataObj.type) {
            if metadataObj.stringValue != nil {
                //call add Product Id
                self.callGetProductId(metadataObj.stringValue)
            }
        }
    }

}
extension QRCodeScannerController:QRCodeScannerView {
    func onAddProductCallback(_ value: Bool) {

        if value == false {
            self.captureSession?.startRunning()
        } else {
            self.dismiss(animated: false, completion: nil)
            qrCodeScannerActionDelegate?.onAddProductCallBack!(self)
        }
    }

    
}
