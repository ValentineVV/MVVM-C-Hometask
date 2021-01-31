//
//  MockURLSession.swift
//  MVVM-CTests
//
//  Created by Valiantsin Vasiliavitski on 11/23/20.
//

import Foundation
@testable import MVVM_C

class MockURLSession: URLSession {

    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {

        let url = Bundle(for: self.classForCoder).url(forResource: "strings", withExtension: "txt")!
        guard let data = try? Data(contentsOf: url) else { return MockDataTask(data: Data()) }

        let task = MockDataTask(data: data)
        task.completion = completionHandler
        return task
    }

}

class MockDataTask: URLSessionDataTask {

    var data: Data

    var completion: ((Data?, URLResponse?, Error?) -> Void)!

    init(data: Data) {
        self.data = data
    }

    override func resume() {
        completion(data, nil, nil)
    }

}
