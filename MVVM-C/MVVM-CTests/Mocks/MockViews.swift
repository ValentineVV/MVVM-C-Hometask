//
//  MockViews.swift
//  MVVM-CTests
//
//  Created by Valiantsin Vasiliavitski on 11/23/20.
//

@testable import MVVM_C

class MockLoginViewController: LoginViewControllerProtocol {
    var didCallShowLoading = false
    var didCallHideLoading = false

    func showLoading() {
        didCallShowLoading = true
    }

    func hideLoading() {
         didCallHideLoading = true
    }

    func showError(_ error: LoginError) {

    }

}

class MockListViewController: ListViewControllerProtocol {
    var didCallHideLoading = false
    var didCallShowLoading = false
    var didCallUpdateList = false

    func hideLoading() {
        didCallHideLoading = true
    }

    func showLoading() {
        didCallShowLoading = true
    }

    func updateList() {
        didCallUpdateList = true
    }

}
