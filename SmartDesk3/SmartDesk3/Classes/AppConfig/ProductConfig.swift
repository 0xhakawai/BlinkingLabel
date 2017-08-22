//
//  ProductConfig.swift
//  SmartDesk
//
//  Created by sa on 3/1/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import UIKit
import AutoUtil
import AutoCommon

//Define color for each project
struct PRODUCT_COLOR {
    static let kRedColor = RGB(243, g: 57, b: 33)
    static let kBlueColor = RGB(53, g: 103, b: 184)
    static let kLighGrayColor = RGB(51, g: 51, b: 51)

}

let APP_PAGES = Bundle.main.path(forResource: "pages", ofType: "json") //define structure main pages in pages.json

let AUTHORIZATION_KEY = "Autonomous"
