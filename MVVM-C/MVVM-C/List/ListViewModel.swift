//
//  ListViewModel.swift
//  MVVM-C
//
//  Created by Valiantsin Vasiliavitski on 11/22/20.
//

import Foundation

class ListViewModel: ListViewModelProtocol {
    var list: [String] = []

    weak var listCoordinator: ListCoordinatorProtocol?
    weak var listView: ListViewControllerProtocol?
    var strService: StringService

    init(coordinator: ListCoordinatorProtocol, view: ListViewControllerProtocol, stringService: StringService = StringService(session: URLSession(configuration: .default))) {
        listCoordinator = coordinator
        listView = view
        strService = stringService
    }

    func requestList() {
        listView?.showLoading()
        strService.getStringsList { [weak self] list in
            self?.list = list
            self?.listView?.updateList()
            self?.listView?.hideLoading()
        }

    }
}
