//
//  NetworkTests.swift
//  MVVM-CTests
//
//  Created by Valiantsin Vasiliavitski on 11/22/20.
//

import XCTest
@testable import MVVM_C

class NetworkTests: XCTestCase {

    func testURL() {
        let string = StringService(session: URLSession(configuration: .default)).getUrlString()
        guard let url = URL(string: string) else {
            XCTFail()
            return
        }
        let canOpen = UIApplication.shared.canOpenURL(url)
        XCTAssertTrue(canOpen)
        
        let regEx = "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
            let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        
        let canEvaluate = predicate.evaluate(with: string)
        XCTAssertTrue(canEvaluate)
        
    }
    
    func testGetUsers() {
        let expectation = self.expectation(description: "get users")
        var usersList: [LoginModel]?
        UsersService().getUsersList { (users) in
            usersList = users
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        
        XCTAssertTrue(usersList?.count ?? 0 > 0)
        XCTAssertEqual(usersList?.count, 1, "wrong number of users")
        XCTAssertEqual(usersList?.first?.email, "user", "wrong email")
        XCTAssertEqual(usersList?.first?.password, "123qwe", "wrong password")
    }
    
    func testGetStringsList() {
        let expectation = self.expectation(description: "get users")
        var stringsList: [String]?
        let stringService = StringService(session: URLSession(configuration: .default))
        let stringUrl = stringService.getUrlString()
        guard let url = URL(string: stringUrl) else {
            XCTFail()
            return
        }
        stringService.getStringsList(fromUrl: url) { (strings) in
            stringsList = strings
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        
        XCTAssertTrue(stringsList?.count ?? 0 > 0)
        XCTAssertEqual(stringsList?.count, 10, "wrong ammount of strings")
    }
    
    func testGetStringsFromJSON() {
        
        let session = MockURLSession()
        let stringService = StringService(session: session)
        guard let url = URL(string: stringService.getUrlString()) else {
            XCTFail()
            return
        }
        
        let expectation = self.expectation(description: "getStrings")
        
        var listArr: [String] = []
        stringService.getStringsList(fromUrl: url) { (list) in
            listArr = list
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        
        XCTAssertTrue(listArr.count == 5)
        
    }

}
