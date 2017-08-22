//
//  QRScannerPresenterTests.swift
//  SmartDesk3
//
//  Created by sa on 7/24/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import XCTest
import AutoBL
import AutoCommon
import AutoCore
@testable import SmartDesk3

class QRScannerPresenterTests: XCTestCase {
    
    var pRepos:ProductReposMock? = nil
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let productDatabaseRepos = ProductDatabaseMock.init(database: Database.sharedInstance)
        let uDatabaseRepos = UserDatabaseMock.init(database: Database.sharedInstance)
        let productServiceRepos = ProductServiceMock.init(apiService: APIService.sharedInstance)
        pRepos = ProductReposMock.init(databaseRepos: productDatabaseRepos, userDatabaseRepos: uDatabaseRepos, serviceRepos: productServiceRepos)
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
    
    /* testAddProductId
     *
     */
    func testAddProductId() {
        
        let qrCodeScannerView = QRScannerViewMock.init()
        let presenter = QRCodeScannerPresenterImpl(view: qrCodeScannerView, repos: pRepos!)
        //presenter.addProductId(<#T##productId: String##String#>, productName: <#T##String#>, productType: <#T##String#>, address: <#T##String#>, addressLon: <#T##Double#>, addressLat: <#T##Double#>, data: <#T##String#>)
        
    }
    
}
