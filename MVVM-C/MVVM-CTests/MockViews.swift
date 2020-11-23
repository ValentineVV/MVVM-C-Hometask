//
//  MockViews.swift
//  MVVM-CTests
//
//  Created by Valiantsin Vasiliavitski on 11/23/20.
//

@testable import MVVM_C

class MockLoginViewController: ViewControllerInterface {
    var didCallShowLoading = false
    var didCallHideLoading = false
    
    func showLoading() {
        didCallShowLoading = true
    }
    
    func hideLoading() {
         didCallHideLoading = true
    }
    
}

class MockListViewController: ListViewControllerInterface {
    var didCallHideLoading = false
    var didCallShowLoading = false
    var list: [String] = []
    
    func hideLoading() {
        didCallHideLoading = true
    }
    
    func showLoading() {
        didCallShowLoading = true
    }
    
    func updateList(with strings: [String]) {
        list = strings
    }
    
}
