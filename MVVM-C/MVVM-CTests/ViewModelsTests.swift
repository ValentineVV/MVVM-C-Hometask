//
//  ViewModelsTests.swift
//  MVVM-CTests
//
//  Created by Valiantsin Vasiliavitski on 11/23/20.
//

import XCTest
@testable import MVVM_C

class ViewModelsTests: XCTestCase {

    func wait() { RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.01)) }

    func testGetUsersSuccess() {

        let mockView = MockLoginViewController()
        let mockCoordinator = MockLoginCoordinator()

        let loginVM = LoginViewModel(coordinator: mockCoordinator, view: mockView, usersService: UsersService())

        loginVM.requestLoginData(forCredentials: LoginModel(email: "user", password: "123qwe"))

        expectToEventually(
            mockView.didCallHideLoading == true
                && mockView.didCallShowLoading == true
                && mockCoordinator.didCallLoginSuccessfully == true,
            timeout: 3
        )
    }

    func testGetUsersFail() {
        let mockView = MockLoginViewController()
        let mockCoordinator = MockLoginCoordinator()

        let loginVM = LoginViewModel(coordinator: mockCoordinator, view: mockView, usersService: UsersService())

        loginVM.requestLoginData(forCredentials: LoginModel(email: "user", password: "123"))

        expectToEventually(
            mockView.didCallHideLoading == true
                && mockView.didCallShowLoading == true
                && mockCoordinator.didCallLoginSuccessfully == false,
            timeout: 3
        )

    }

    func testRequestList() {
        let mockView = MockListViewController()
        let listVM = ListViewModel(coordinator: ListCoordinator(), view: mockView, stringService: StringService(session: URLSession(configuration: .default)))

        listVM.requestList()

        expectToEventually(
            mockView.didCallHideLoading == true
                && mockView.didCallShowLoading == true
                && mockView.didCallUpdateList,
            timeout: 3
        )
    }

}

extension XCTest {

    func expectToEventually(
        _ isFulfilled: @autoclosure () -> Bool,
        timeout: TimeInterval,
        message: String = "",
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        func wait() { RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.01)) }

        let timeout = Date(timeIntervalSinceNow: timeout)
        func isTimeout() -> Bool { Date() >= timeout }

        repeat {
            if isFulfilled() { return }
            wait()
        } while !isTimeout()

        XCTFail(message, file: file, line: line)
    }
}
