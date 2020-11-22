//
//  LoginViewModelInterface.swift
//  MVVM-C
//
//  Created by Valiantsin Vasiliavitski on 11/22/20.
//

import Foundation

protocol LoginViewModelInterface {
    func requestLoginData(forEmail: String, password: String)
}
