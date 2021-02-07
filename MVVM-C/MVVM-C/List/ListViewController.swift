//
//  ListViewControllerInterface.swift
//  MVVM-C
//
//  Created by Valiantsin Vasiliavitski on 11/22/20.
//

import UIKit

protocol ListViewControllerProtocol: ViewControllerProtocol {
    func updateList()
}

class ListViewController: UIViewController, ListViewControllerProtocol {

    @IBOutlet weak var tableView: UITableView!

    var viewModel: ListViewModel!
    private var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List screen"

        viewModel.requestList()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "listViewCell")
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }

    func updateList() {
        tableView.reloadData()
    }

    func showLoading() {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = tableView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = .gray
        activityIndicator.layer.zPosition = 1
        tableView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }

    func hideLoading() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
}

extension ListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "listViewCell", for: indexPath)
        cell.textLabel?.text = viewModel.list[indexPath.row]
        cell.selectionStyle = .none

        return cell
    }
}
