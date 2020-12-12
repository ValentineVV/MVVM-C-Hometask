//
//  LoginCoordinator.swift
//  MVVM-C
//
//  Created by Valiantsin Vasiliavitski on 11/22/20.
//

import UIKit

protocol LoginCoordinatorProtocol: Coordinator {
    func didLoginSuccessfully()
}

class LoginCoordinator: LoginCoordinatorProtocol {
    
    private weak var navigationVC: UINavigationController?

    func start() {
        guard let loginVC = UIStoryboard(name: "LoginViewController", bundle: nil).instantiateInitialViewController() as? LoginViewController else { return }
        let loginVM = LoginViewModel(coordinator: self, view: loginVC, usersService: UsersService())
        loginVC.model = loginVM
        
        navigationVC?.pushViewController(loginVC, animated: true)
    }
    
    init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func didLoginSuccessfully() {
        guard let navVC = navigationVC else { return }
        let listCoordinator = ListCoordinator(navigationVC: navVC)
        listCoordinator.start()
    }
    
}
