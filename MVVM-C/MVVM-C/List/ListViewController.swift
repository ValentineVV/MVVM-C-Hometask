//
//  ListViewControllerInterface.swift
//  MVVM-C
//
//  Created by Valiantsin Vasiliavitski on 11/22/20.
//

import UIKit

protocol ListViewControllerInterface: ViewControllerInterface {
    func updateList(with strings: [String])
}

class ListViewController: UIViewController, ListViewControllerInterface {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var model: ListViewModel!
    private var activityIndicator: UIActivityIndicatorView!
    private var list: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List screen"
        
        model.requestList()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    func updateList(with strings: [String]) {
        list = strings
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

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
}
