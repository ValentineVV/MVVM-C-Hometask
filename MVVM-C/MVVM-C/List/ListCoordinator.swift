//
//  ListCoordinator.swift
//  MVVM-C
//
//  Created by Valiantsin Vasiliavitski on 11/22/20.
//

import UIKit

protocol ListCoordinatorProtocol: Coordinator {

}

class ListCoordinator: ListCoordinatorProtocol {

    private weak var navigationVC: UINavigationController?

    init(navigationVC: UINavigationController = UINavigationController()) {
        self.navigationVC = navigationVC
    }

    func start() {
        guard let listVC = UIStoryboard(name: "ListViewController", bundle: nil).instantiateInitialViewController() as? ListViewController else { return }
        let listVM = ListViewModel(coordinator: self, view: listVC)
        listVC.viewModel = listVM

        navigationVC?.pushViewController(listVC, animated: true)
    }

}
