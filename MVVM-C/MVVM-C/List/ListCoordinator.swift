//
//  ListCoordinator.swift
//  MVVM-C
//
//  Created by Valiantsin Vasiliavitski on 11/22/20.
//

import UIKit

protocol ListCoordinatorInterface: Coordinator {
    
}

class ListCoordinator: ListCoordinatorInterface {
    
    private weak var navigationVC: UINavigationController?
    
    init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func start() {
        let listVC = UIStoryboard(name: "ListViewController", bundle: nil).instantiateInitialViewController() as! ListViewController
        let listVM = ListViewModel(coordinator: self, view: listVC)
        listVC.model = listVM
        
        navigationVC?.pushViewController(listVC, animated: true)
    }
    
}
