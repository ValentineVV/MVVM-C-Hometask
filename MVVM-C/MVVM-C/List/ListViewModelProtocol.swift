//
//  ListViewModelInterface.swift
//  MVVM-C
//
//  Created by Valiantsin Vasiliavitski on 11/22/20.
//

import Foundation

protocol ListViewModelProtocol {
    var list: [String] { get }
    func requestList()
}
