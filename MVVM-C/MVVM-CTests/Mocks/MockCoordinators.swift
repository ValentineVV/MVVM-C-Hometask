//
//  MockCoordinators.swift
//  MVVM-CTests
//
//  Created by Valiantsin Vasiliavitski on 11/23/20.
//

@testable import MVVM_C

class MockLoginCoordinator: LoginCoordinatorProtocol {
    var didCallLoginSuccessfully = false
    func start() {
        
    }
    
    func didLoginSuccessfully() {
        didCallLoginSuccessfully = true
        
    }
    
}
