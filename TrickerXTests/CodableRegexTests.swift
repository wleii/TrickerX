//
//  CodableRegexTests.swift
//  TrickerX
//
//  Created by Lei Wang on 2017/12/7.
//  Copyright © 2017年 Lei Wang. All rights reserved.
//

import XCTest

class CodableRegexTests: XCTestCase {

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
        var toggleComments = "// toggle commentes test"
        XCTAssertNotNil(toggleComments.match(regex: .toggleComments))
        toggleComments = "   // toggle commentes test "
        XCTAssertNotNil(toggleComments.match(regex: .toggleComments))
        toggleComments = "test   // toggle commentes test "
        XCTAssertNil(toggleComments.match(regex: .toggleComments))

        
        var customKeys = "private let customKey: String //my_custom_key"
        XCTAssertNotNil(customKeys.match(regex: .customKey))
        XCTAssertEqual(customKeys.match(regex: .customKey)?.match(regex: "\\w+").unwrappedOrEmpty, "my_custom_key")
        
        XCTAssertNotNil(customKeys.match(regex: .codablePropertyLine))
        XCTAssertEqual(customKeys.match(regex: .codablePropertyLine)?.match(regex: .codablePropertyName), "customKey")
        let splitStrings = customKeys.split(separator: "/")
        XCTAssertEqual(splitStrings.first, "private let customKey: String ")
        
        customKeys = "private let customKey: String //"
        XCTAssertNil(customKeys.match(regex: .customKey))

        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
