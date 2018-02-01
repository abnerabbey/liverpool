//
//  ServiceManager.swift
//  Liverpool
//
//  Created by Abner Abbey on 01/02/18.
//  Copyright © 2018 Abner Abbey. All rights reserved.
//

import Foundation

class ServiceManager {
    
    private let baseUrlString = "https://www.liverpool.com.mx/tienda?s="
    private let restUrlString = "&d3106047a194921c01969dfdec083925=json"
    
    let urlSession: URLSession
    
    init() {
        urlSession = URLSession(configuration: .default)
    }
    
    func requestData(fromSearch search: String, withCompletionHandler handler: @escaping(_: Data?) -> Void) {
        let urlString = "\(baseUrlString)\(search)\(restUrlString)"
        guard let url = URL(string: urlString) else {
            print("error while creating url from string")
            return
        }
        let urlRequest = URLRequest(url: url)
        let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil {
                handler(data)
            } else {
                if let error = error {
                    print("Error while requesting data from search: \(error.localizedDescription)")
                } else {
                    print("Error while requesting data from search")
                }
            }
        }
        task.resume()
    }
    
    func requestProductImage(urlString: String, completion: @escaping(_: Data?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("cannot get an url from the string")
            return
        }
        let urlRequest = URLRequest(url: url)
        let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil {
                completion(data)
            } else {
                if let error = error {
                    print("Error while requesting data from search: \(error.localizedDescription)")
                } else {
                    print("Error while requesting data from search")
                }
            }
        }
        task.resume()
    }
}
