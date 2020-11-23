//
//  LoginViewController.swift
//  MVVM-C
//
//  Created by Valiantsin Vasiliavitski on 11/22/20.
//

import UIKit

class LoginViewController: UIViewController, ViewControllerInterface {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pswTextField: UITextField!
    
    var model: LoginViewModelInterface!
    private var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login screen"
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(removeKeyboard))
        view.addGestureRecognizer(recognizer)
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
        let email = emailTextField.text ?? ""
        let password = pswTextField.text ?? ""
        
        model.requestLoginData(forEmail: email, password: password)
    }
    
}
