//
//  APIHelper.swift
//  MVVM-C
//
//  Created by Valiantsin Vasiliavitski on 11/22/20.
//

import UIKit

protocol UsersServiceProtocol {
//    func getUsersList(completion: @escaping ([LoginModel]) -> ())
    func login(withCredentials creds: LoginModel, completion: @escaping (Result<Bool, LoginError>) -> Void)
}

struct UsersService: UsersServiceProtocol {

    private func getUsersList(completion: @escaping ([LoginModel]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            completion([.init(email: "user", password: "123qwe")])
        }
    }

    func login(withCredentials creds: LoginModel, completion: @escaping (Result<Bool, LoginError>) -> Void) {

        getUsersList { userList in

            guard userList.contains(creds) else {
                completion(.failure(.noSuchUser))
                return
            }

            completion(.success(true))
        }
    }

}
