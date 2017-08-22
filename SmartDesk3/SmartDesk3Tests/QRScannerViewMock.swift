//
//  QRScannerViewMock.swift
//  SmartDesk3
//
//  Created by sa on 7/24/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import UIKit
import SmartDesk3

class QRScannerViewMock: QRCodeScannerView {

    var message: String = ""
    
    func showIndicator() {
        
    }
    
    func hideIndicator() {
        
    }
    
    func showMessage(_ message:String) {
        self.message = message
    }
    
    func showLoadingMessge(_ message:String){
        
    }
    
    func onAddProductCallback(_ value:Bool){
        
    }
}
