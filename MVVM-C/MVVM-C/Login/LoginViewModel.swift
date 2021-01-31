//
//  LoginViewModel.swift
//  MVVM-C
//
//  Created by Valiantsin Vasiliavitski on 11/22/20.
//

import UIKit

protocol LoginViewModelProtocol {
    func requestLoginData(forCredentials creds: LoginModel)
}

class LoginViewModel: LoginViewModelProtocol {

    weak var coordinator: LoginCoordinatorProtocol?
    weak var view: LoginViewControllerProtocol?
    var usersService: UsersService

    init(coordinator: LoginCoordinatorProtocol, view: LoginViewControllerProtocol, usersService: UsersService = UsersService()) {
        self.coordinator = coordinator
        self.view = view
        self.usersService = usersService
    }

    func requestLoginData(forCredentials creds: LoginModel) {
        view?.showLoading()
        usersService.login(withCredentials: creds) { [weak self] (result) in
            switch result {

            case .success:
                self?.coordinator?.didLoginSuccessfully()
            case .failure(let error):
                self?.view?.showError(error)
            }
            self?.view?.hideLoading()
        }
    }

}
