//
//  LoginCoordinator.swift
//  MVVM-C
//
//  Created by Valiantsin Vasiliavitski on 11/22/20.
//

import UIKit

protocol LoginCoordinatorInterface: Coordinator {
    func didLoginSuccessfully()
}

class LoginCoordinator: LoginCoordinatorInterface {
    
    private weak var navigationVC: UINavigationController?

    func start() {
        let loginVC = UIStoryboard(name: "LoginViewController", bundle: nil).instantiateInitialViewController() as! LoginViewController
        let loginVM = LoginViewModel(coordinator: self, view: loginVC)
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
