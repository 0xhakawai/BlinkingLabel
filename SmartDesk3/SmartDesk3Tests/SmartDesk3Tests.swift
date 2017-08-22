//
//  SmartDesk3Tests.swift
//  SmartDesk3Tests
//
//  Created by sa on 7/13/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import XCTest
import UIKit
import AutoUtil
@testable import SmartDesk3

class SmartDesk3Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    /* Read file wrong path
     * Expect: return error message
     */
    func testReadJsonWrongPath() {
        
        let jsonFile = "wrongpath"
        let (_,message) = Util.jsonFromFile(fileName: jsonFile)
        if message == nil {
            XCTFail("It should return error message")
            
        }
    }
    
    /* Read file pages_wrong format json
     * Expect: return error message
     */
    func testReadJsonFileWrongFormat() {
        
        let jsonFile = "page_wrong"
        let (_,message) = Util.jsonFromFile(fileName: jsonFile)
        if message == nil {
            XCTFail("It should return error message")
            
        }
        
    }
    /* Read file pages json
     * Expect: read menu list, nib list
     */
    func testReadPageJsonRightFormat() {
        
        let jsonFile = "pages"
        let (jsonObj,message) = Util.jsonFromFile(fileName: jsonFile)
        if jsonObj != nil {
            if let array = jsonObj?.array {
                for item in array {
                    if let menuDict = item["menu"].dictionary {
                        if menuDict["name"]?.string == nil{
                            XCTFail("Menu Dict should have name key")
                            
                        }
                        
                        if menuDict["image"]?.string == nil {
                            XCTFail("Menu Dict should have image key")
                            
                        }
                        if let selectedValue = menuDict["selected"]?.string {
                            if selectedValue != "0" && selectedValue != "1" {
                                XCTFail("Selected Key should be 1 or 0")
                                
                            }
                        }else {
                            XCTFail("Menu Dict should have selected key")
                            
                        }
                        
                        
                    }else {
                        XCTFail("Page file should have Menu Dict")
                    }
                    if let nibDict = item["nib"].dictionary {
                        if nibDict["indentifier"]?.string == nil {
                            XCTFail("Nib Dict should have identifier key")
                        }
                        
                    }else {
                        XCTFail("Page file should have Nib Dict")
                    }
                }
            }else {
                XCTFail("Page file should return array format")
            }
            
        }else {
            XCTFail(message!)
        }
        
    }

    
}
