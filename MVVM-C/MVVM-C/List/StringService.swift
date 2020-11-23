//
//  StringService.swift
//  MVVM-C
//
//  Created by Valiantsin Vasiliavitski on 11/23/20.
//

import Foundation

protocol StringServiceInterface {
    func getUrlString() -> String
    func getStringsList(fromUrl url: URL, completionHandler: @escaping ([String]) -> Void)
}

struct StringService: StringServiceInterface {
    
    let session: URLSession
    
    func getUrlString() -> String {
        return "https://www.random.org/strings/?num=10&len=8&digits=on&upperalpha=on&loweralpha=on&unique=on&format=plain&rnd=new"
    }
    
    func getStringsList(fromUrl url: URL, completionHandler: @escaping ([String]) -> Void) {
        let task = session.dataTask(with: url) { (data, response, error) in
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
