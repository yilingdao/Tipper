//
//  KNCommunicationsManagerTest.swift
//  CloudBeacon
//
//  Created by PETRUS VAN DE PUT on 01/11/14.
//  Copyright (c) 2014 Knodeit. All rights reserved.
//

import UIKit
import XCTest

class KNCommunicationsManagerTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testSharedInstance_ThreadSafety() {
        var instance1 : KNCommunicationsManager!
        var instance2 : KNCommunicationsManager!
        
        let expectation1 = expectationWithDescription("Instance 1")
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            instance1 = KNCommunicationsManager.sharedInstance
            expectation1.fulfill()
        }
        let expectation2 = expectationWithDescription("Instance 2")
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            instance2 = KNCommunicationsManager.sharedInstance
            expectation2.fulfill()
        }
        
        waitForExpectationsWithTimeout(5, { error in
            XCTAssertNil(error, "Error")
              XCTAssertTrue(instance1 === instance2)
        })
    }
    
}
