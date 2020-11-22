//
//  LoginViewModel.swift
//  MVVM-C
//
//  Created by Valiantsin Vasiliavitski on 11/22/20.
//

import UIKit

class LoginViewModel: LoginViewModelInterface {
    
    weak var coordinator: LoginCoordinatorInterface?
    weak var view: ViewControllerInterface?
    
    init(coordinator: LoginCoordinatorInterface, view: ViewControllerInterface) {
        self.coordinator = coordinator
        self.view = view
    }
    
    func requestLoginData(forEmail email: String, password: String) {
        view?.showLoading()
        APIHelper.shared.getUsersList {[weak self] userList in
            let userExist = userList.contains {
                $0.email == email && $0.password == password
            }
            if userExist {
                self?.coordinator?.didLoginSuccessfully()
            }
            self?.view?.hideLoading()
        }
        
    }
    
}
