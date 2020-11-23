//
//  ListViewModel.swift
//  MVVM-C
//
//  Created by Valiantsin Vasiliavitski on 11/22/20.
//

import Foundation

class ListViewModel: ListViewModelInterface {
    weak var listCoordinator: ListCoordinatorInterface?
    weak var listView: ListViewControllerInterface?
    
    init(coordinator: ListCoordinatorInterface, view: ListViewControllerInterface) {
        listCoordinator = coordinator
        listView = view
    }
    
    func requestList() {
        listView?.showLoading()
        let urlString = APIHelper.shared.getUrlString()
        guard let url = URL(string: urlString) else {
            listView?.hideLoading()
            return
        }
        APIHelper.shared.getStringsList(fromUrl: url) { [weak self] list in
            self?.listView?.updateList(with: list)
            self?.listView?.hideLoading()
        }
        
    }
}
