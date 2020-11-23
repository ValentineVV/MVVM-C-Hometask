//
//  APIHelper.swift
//  MVVM-C
//
//  Created by Valiantsin Vasiliavitski on 11/22/20.
//

import UIKit

class APIHelper {
    
    private init() {}
    
    static let shared = APIHelper()
    
    func getUrlString() -> String {
        return "https://www.random.org/strings/?num=10&len=8&digits=on&upperalpha=on&loweralpha=on&unique=on&format=plain&rnd=new"
    }
    
    func getUsersList(completion: @escaping ([LoginModel]) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            completion([.init(email: "user", password: "123qwe")])
        }
    }
    
    func getStringsList(fromUrl url: URL, completionHandler: @escaping ([String]) -> Void) {
        let request = URLRequest(url: url)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request) { (data, response, error) in
            let list = String(decoding: data!, as: UTF8.self).split(separator: "\n").map {
                String($0)
            }
            DispatchQueue.main.async {
                completionHandler(list)
            }
        }
        
        task.resume()
    }
    
}
