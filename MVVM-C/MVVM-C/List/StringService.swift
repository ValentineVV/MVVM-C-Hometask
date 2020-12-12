//
//  StringService.swift
//  MVVM-C
//
//  Created by Valiantsin Vasiliavitski on 11/23/20.
//

import Foundation

protocol StringServiceProtocol {
    func getStringsList(completionHandler: @escaping ([String]) -> Void)
}

struct StringService: StringServiceProtocol {
    
    let session: URLSession
    
    private func getUrlString() -> String {
        return "https://www.random.org/strings/?num=10&len=8&digits=on&upperalpha=on&loweralpha=on&unique=on&format=plain&rnd=new"
    }
    
    func getStringsList(completionHandler: @escaping ([String]) -> Void) {
        let urlString = getUrlString()
        guard let url = URL(string: urlString) else { return }
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            let list = String(decoding: data, as: UTF8.self).split(separator: "\n").map {
                String($0)
            }
            DispatchQueue.main.async {
                completionHandler(list)
            }
        }
        
        task.resume()
    }
    
}
