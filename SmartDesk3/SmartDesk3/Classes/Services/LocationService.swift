//
//  LocationServices.swift
//  SmartDesk
//
//  Created by Trong_iOS on 6/6/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import AutoCommon
import AutoCore
import AutoUtil

class LocationService: NSObject, ApplicationService {
    
    fileprivate var locationManager = CLLocationManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if let _ = launchOptions?[.location] {
            startStandardUpdates()
        }
        
        return true
    }
    
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        locationManager.stopMonitoringSignificantLocationChanges()
        startStandardUpdates()
    }
    
    func startStandardUpdates() {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = 5.0
        self.locationManager.headingFilter = 1
        self.locationManager.allowsBackgroundLocationUpdates = true
        
        let code = CLLocationManager.authorizationStatus()
        if code == .notDetermined {
            if (Bundle.main.object(forInfoDictionaryKey: "NSLocationAlwaysUsageDescription") != nil) {
                self.locationManager.requestAlwaysAuthorization()
                
            } else if (Bundle.main.object(forInfoDictionaryKey: "NSLocationWhenInUseUsageDescription") != nil){
                self.locationManager.requestWhenInUseAuthorization()
                
            } else{
                print("Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription")
            }
        }
        self.locationManager.startMonitoringSignificantLocationChanges()
    }
    
}

extension LocationService: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        AutonomousContext.sharedInstance.lat = (locations.last?.coordinate.latitude)!
        AutonomousContext.sharedInstance.lon = (locations.last?.coordinate.longitude)!
        Util.reverseAddress(lat: (locations.last?.coordinate.latitude)!, lon: (locations.last?.coordinate.longitude)!) { (address) -> (Void) in
            AutonomousContext.sharedInstance.address = address
            
            UserDefaults.standard.set(address, forKey: "CURRENT_LOCATION")
            UserDefaults.standard.synchronize()
        }
    }
    
}
