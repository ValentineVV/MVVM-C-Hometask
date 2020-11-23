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
    var strService: StringService
    
    init(coordinator: ListCoordinatorInterface, view: ListViewControllerInterface, stringService: StringService) {
        listCoordinator = coordinator
        listView = view
        strService = stringService
    }
    
    func requestList() {
        listView?.showLoading()
        let urlString = strService.getUrlString()
        guard let url = URL(string: urlString) else {
            listView?.hideLoading()
            return
        }
        strService.getStringsList(fromUrl: url) { [weak self] list in
            self?.listView?.updateList(with: list)
            self?.listView?.hideLoading()
        }
        
    }
}
