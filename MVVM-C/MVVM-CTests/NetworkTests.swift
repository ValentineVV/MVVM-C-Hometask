//
//  NetworkTests.swift
//  MVVM-CTests
//
//  Created by Valiantsin Vasiliavitski on 11/22/20.
//

import XCTest
@testable import MVVM_C

class NetworkTests: XCTestCase {
        
    func testGetStringsFromJSON() {
        
        let session = MockURLSession()
        let stringService = StringService(session: session)
        
        let expectation = self.expectation(description: "getStrings")
        
        var listArr: [String] = []
        stringService.getStringsList { (list) in
            listArr = list
            expectation.fulfill()
        }
        
        let url = Bundle(for: self.classForCoder).url(forResource: "strings", withExtension: "txt")!
        guard let str = try?String(contentsOf: url) else {
            XCTFail()
            return
        }
        let strArr = str.split(separator: "\n").compactMap {
            String($0)
        }
        waitForExpectations(timeout: 3, handler: nil)
        
        XCTAssertTrue(strArr == listArr)
        XCTAssertTrue(listArr.count == 5)
        
    }

}
