//
//  UtilSwift.swift
//  Maya
//
//  Created by sa on 11/11/16.
//  Copyright © 2016 Autonomous. All rights reserved.
//

import UIKit
import MBProgressHUD
import Firebase
struct LOADING_VIEW_TAG {
    static let INDICATOR = 100
    static let DOWNLOAD = 101
    static let UPLOAD = 102
}

class UtilSwift: NSObject {
    static func startUploadingView(_ view:UIView){
        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.tag = LOADING_VIEW_TAG.UPLOAD
        loadingNotification.label.text = "Uploading..."
    }
    static func updateUploadingView(_ view:UIView, progress:Float){
        
        if let loadingView = view.viewWithTag(LOADING_VIEW_TAG.UPLOAD) as? MBProgressHUD{
            loadingView.mode = MBProgressHUDMode.determinateHorizontalBar
            loadingView.progress = progress
        }
    }
    static func stopUploadingView(_ view:UIView){
        
        if let loadingView = view.viewWithTag(LOADING_VIEW_TAG.UPLOAD) as? MBProgressHUD{
            loadingView.mode = MBProgressHUDMode.customView
            let imageView = UIImageView(image: UIImage(named: "icon_checkmark"))
            loadingView.customView = imageView
            loadingView.label.text = "Completed"
            let delayTime = DispatchTime.now() + Double(Int64(1.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delayTime) {
                loadingView.hide(animated: true)
                
            }
        }
    }
    static func startLoadingMessageView(message:String, view:UIView, animated:Bool){
        var loadingNotification:MBProgressHUD?
        if let loadingNotificationTemp = view.viewWithTag(LOADING_VIEW_TAG.INDICATOR) as? MBProgressHUD{
            loadingNotification = loadingNotificationTemp
            loadingNotification?.show(animated: true)
            
        }else {
            loadingNotification = MBProgressHUD.showAdded(to: view, animated: animated)
            loadingNotification?.mode = MBProgressHUDMode.indeterminate
            loadingNotification?.tag = LOADING_VIEW_TAG.INDICATOR
            loadingNotification?.label.font = fREGULAR(14)
            loadingNotification?.label.numberOfLines = 0
            loadingNotification?.show(animated: true)
        }
        
        
        loadingNotification?.label.text = message
        
    }
    static func stopLoadingMessageView(_ view:UIView, animated:Bool){
        DispatchQueue.main.async {
            if let loadingView = view.viewWithTag(LOADING_VIEW_TAG.INDICATOR) as? MBProgressHUD{
                loadingView.hide(animated: true)
            }
        }
        
    }
    
    static func convertStringToDictionary(_ text: String) -> [String:AnyObject]? {
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Can't convert string to dictionary")
            }
        }
        return nil
    }
    
    static func trackEvent(name:String,value:String, status:Bool){
        var statusString = "Success"
        if status == false {
            statusString = "Fail"
        }
        FIRAnalytics.logEvent(withName: name, parameters: [
            "value": value as NSObject,
            "status": statusString as NSObject,
            ])
    }
}

extension UIImage{
    func fixOrientation() -> UIImage
    {
        
        if self.imageOrientation == UIImageOrientation.up {
            return self
        }
        
        var transform = CGAffineTransform.identity
        
        switch self.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: CGFloat(M_PI));
            
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0);
            transform = transform.rotated(by: CGFloat(M_PI_2));
            
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: self.size.height);
            transform = transform.rotated(by: CGFloat(-M_PI_2));
            
        case .up, .upMirrored:
            break
        }
        
        
        switch self.imageOrientation {
            
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: self.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1);
            
        default:
            break;
        }
        
        
        
        // Now we draw the underlying CGImage into a new context, applying the transform
        // calculated above.
        let ctx = CGContext(
            data: nil,
            width: Int(self.size.width),
            height: Int(self.size.height),
            bitsPerComponent: (self.cgImage?.bitsPerComponent)!,
            bytesPerRow: 0,
            space: (self.cgImage?.colorSpace!)!,
            bitmapInfo: UInt32((self.cgImage?.bitmapInfo.rawValue)!)
        )
        
        ctx?.concatenate(transform);
        
        switch self.imageOrientation {
            
        case .left, .leftMirrored, .right, .rightMirrored:
            // Grr...
            ctx?.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: self.size.height,height: self.size.width));
            
        default:
            ctx?.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: self.size.width,height: self.size.height));
            break;
        }
        
        // And now we just create a new UIImage from the drawing context
        let cgimg = ctx?.makeImage()
        
        let img = UIImage(cgImage: cgimg!)
        
        return img;
        
    }
}
