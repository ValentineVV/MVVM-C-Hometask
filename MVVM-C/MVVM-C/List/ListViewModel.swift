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
        guard let url = URL(string: "https://www.random.org/strings/?num=10&len=8&digits=on&upperalpha=on&loweralpha=on&unique=on&format=plain&rnd=new") else {
            listView?.hideLoading()
            return
        }
        APIHelper.shared.getStringsList(fromUrl: url) { [weak self] list in
            self?.listView?.updateList(with: list)
            self?.listView?.hideLoading()
        }
        
    }
}
