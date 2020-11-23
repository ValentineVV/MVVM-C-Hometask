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
    var usersService: UsersService
    
    init(coordinator: LoginCoordinatorInterface, view: ViewControllerInterface, usersService: UsersService) {
        self.coordinator = coordinator
        self.view = view
        self.usersService = usersService
    }
    
    func requestLoginData(forEmail email: String, password: String) {
        view?.showLoading()
        usersService.getUsersList {[weak self] userList in
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
