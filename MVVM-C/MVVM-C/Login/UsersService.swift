//
//  APIHelper.swift
//  MVVM-C
//
//  Created by Valiantsin Vasiliavitski on 11/22/20.
//

import UIKit

protocol UsersServiceInterface {
    func getUsersList(completion: @escaping ([LoginModel]) -> ())
}

struct UsersService: UsersServiceInterface {
    
    func getUsersList(completion: @escaping ([LoginModel]) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            completion([.init(email: "user", password: "123qwe")])
        }
    }
    
}
