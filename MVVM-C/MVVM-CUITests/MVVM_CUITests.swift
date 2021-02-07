//
//  MVVM_CUITests.swift
//  MVVM-CUITests
//
//  Created by Valiantsin Vasiliavitski on 11/22/20.
//

import XCTest

class MVVM_CUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testWrongCredsOnLogin() throws {
        let navTitle = app.navigationBars.firstMatch.staticTexts.firstMatch.label
        XCTAssertEqual(navTitle, "Login screen")

        let enterCredsText = app.staticTexts["Enter credentials"].firstMatch.label
        XCTAssertEqual(enterCredsText, "Enter credentials")

        XCTAssertFalse(app.staticTexts["com.edu.MVVM-C.errorLabel"].exists)

        let loginTextField = app.textFields["com.edu.MVVM-C.loginTextField"]
        loginTextField.tap()
        loginTextField.typeText("user")

        let pswTextField = app.textFields["com.edu.MVVM-C.pswTextField"]
        pswTextField.tap()
        pswTextField.typeText("123\n")

        expectToEventually(app.staticTexts["com.edu.MVVM-C.errorLabel"].exists, timeout: 2)

        XCTAssertTrue(app.staticTexts["com.edu.MVVM-C.errorLabel"].exists)

        let errorText = app.staticTexts["com.edu.MVVM-C.errorLabel"].label
        XCTAssertEqual(errorText, "There is no such user")
    }

    func testEmptyLoginOnLogin() throws {
        let navTitle = app.navigationBars.firstMatch.staticTexts.firstMatch.label
        XCTAssertEqual(navTitle, "Login screen")

        let enterCredsText = app.staticTexts["Enter credentials"].firstMatch.label
        XCTAssertEqual(enterCredsText, "Enter credentials")

        XCTAssertFalse(app.staticTexts["com.edu.MVVM-C.errorLabel"].exists)

        let pswTextField = app.textFields["com.edu.MVVM-C.pswTextField"]
        pswTextField.tap()
        pswTextField.typeText("123\n")

        expectToEventually(app.staticTexts["com.edu.MVVM-C.errorLabel"].exists, timeout: 2)

        XCTAssertTrue(app.staticTexts["com.edu.MVVM-C.errorLabel"].exists)

        let errorText = app.staticTexts["com.edu.MVVM-C.errorLabel"].label
        XCTAssertEqual(errorText, "Email field is empty")
    }

    func testEmpryPasswordOnLogin() throws {
        let navTitle = app.navigationBars.firstMatch.staticTexts.firstMatch.label
        XCTAssertEqual(navTitle, "Login screen")

        let enterCredsText = app.staticTexts["Enter credentials"].firstMatch.label
        XCTAssertEqual(enterCredsText, "Enter credentials")

        XCTAssertFalse(app.staticTexts["com.edu.MVVM-C.errorLabel"].exists)

        let loginTextField = app.textFields["com.edu.MVVM-C.loginTextField"]
        loginTextField.tap()
        loginTextField.typeText("user")

        let pswTextField = app.textFields["com.edu.MVVM-C.pswTextField"]
        pswTextField.tap()
        pswTextField.typeText("\n")

        expectToEventually(app.staticTexts["com.edu.MVVM-C.errorLabel"].exists, timeout: 2)

        XCTAssertTrue(app.staticTexts["com.edu.MVVM-C.errorLabel"].exists)

        let errorText = app.staticTexts["com.edu.MVVM-C.errorLabel"].label
        XCTAssertEqual(errorText, "Password field is empty")
    }

    func testSuccessOnLogin() throws {
        let navTitle = app.navigationBars.firstMatch.staticTexts.firstMatch.label
        XCTAssertEqual(navTitle, "Login screen")

        let enterCredsText = app.staticTexts["Enter credentials"].firstMatch.label
        XCTAssertEqual(enterCredsText, "Enter credentials")

        XCTAssertFalse(app.staticTexts["com.edu.MVVM-C.errorLabel"].exists)

        let loginTextField = app.textFields["com.edu.MVVM-C.loginTextField"]
        loginTextField.tap()
        loginTextField.typeText("user")

        let pswTextField = app.textFields["com.edu.MVVM-C.pswTextField"]
        pswTextField.tap()
        pswTextField.typeText("123qwe\n")

        let navTitleAfterLogin = app.navigationBars.firstMatch.staticTexts["List screen"].label
        expectToEventually(navTitleAfterLogin == "List screen", timeout: 2)

        let tableCount = app.tables.firstMatch.cells.count
        XCTAssertTrue(tableCount == 10)
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
