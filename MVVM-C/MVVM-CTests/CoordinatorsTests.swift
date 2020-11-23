//
//  CoordinatorsTests.swift
//  MVVM-CTests
//
//  Created by Valiantsin Vasiliavitski on 11/22/20.
//

import XCTest
@testable import MVVM_C

class CoordinatorsTests: XCTestCase {
    
    func testLoginCoordinatorToStart() {
        let navVC = UINavigationController()
        let coordinator = LoginCoordinator(navigationVC: navVC)
        coordinator.start()

        XCTAssertEqual(navVC.children.count, 1)
        XCTAssertTrue(navVC.children.first is LoginViewController)
    }
    
    func testSuccessfullLogin() {
        let navVC = UINavigationController()
        let coordinator = LoginCoordinator(navigationVC: navVC)
        coordinator.didLoginSuccessfully()
        
        XCTAssertEqual(navVC.children.count, 1)
        XCTAssertTrue(navVC.children.first is ListViewController)
    }
    
    func testListCoordinatorToStart() {
        let navVC = UINavigationController()
        let coordinator = ListCoordinator(navigationVC: navVC)
        coordinator.start()

        XCTAssertEqual(navVC.children.count, 1)
        XCTAssertTrue(navVC.children.first is ListViewController)
    }
}
