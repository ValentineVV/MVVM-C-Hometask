//
//  LoginViewController.swift
//  MVVM-C
//
//  Created by Valiantsin Vasiliavitski on 11/22/20.
//

import UIKit

enum LoginError: Error {
    case emptyEmail
    case emptyPassword
    case noSuchUser
}

protocol LoginViewControllerProtocol: ViewControllerProtocol {
    func showError(_ error: LoginError)
}

class LoginViewController: UIViewController, LoginViewControllerProtocol {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pswTextField: UITextField!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!

    var model: LoginViewModelProtocol!
    private var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login screen"

        emailTextField.delegate = self
        pswTextField.delegate = self

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(removeKeyboard))
        view.addGestureRecognizer(recognizer)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backButtonTitle = "Log out"
    }

    @objc private func removeKeyboard() {
        view.endEditing(true)
    }

    func showLoading() {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = .gray
        activityIndicator.layer.zPosition = 1
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }

    func hideLoading() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }

    @IBAction private func loginButtonClicked(_ sender: Any) {
        login()
    }

    private func login() {
        let emailText = emailTextField.text
        let passwordText = pswTextField.text

        guard let email = emailText, email != "" else {
            showError(.emptyEmail)
            return
        }

        guard let password = passwordText, password != "" else {
            showError(.emptyPassword)
            return
        }

        model.requestLoginData(forCredentials: LoginModel(email: email, password: password))
    }

    func showError(_ error: LoginError) {
        switch error {

        case .emptyEmail:
            errorLabel.text = "Email field is empty"
        case .emptyPassword:
            errorLabel.text = "Password field is empty"
        case .noSuchUser:
            errorLabel.text = "There is no such user"
        }
        errorView.isHidden = false
    }

}

extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if emailTextField.isFirstResponder {
            pswTextField.becomeFirstResponder()
        } else {
            removeKeyboard()
            login()
        }
        return true
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        errorView.isHidden = true
        return true
    }

}
