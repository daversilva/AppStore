//
//  Models.swift
//  AppStore
//
//  Created by David Rodrigues on 09/09/2018.
//  Copyright © 2018 David Rodrigues. All rights reserved.
//

import UIKit

class Featured: Codable {
    var bannerCategory: AppCategory?
    var categories: [AppCategory]?
}

class App: Codable {
    var Id: Int?
    var Name: String?
    var Category: String?
    var ImageName: String?
    var Price: Float?
    
    var Screenshots: [String]?
    var description: String?
    var appInformation: [AppInformation]?
}

class AppCategory: Codable {
    var name: String?
    var apps: [App]?
    var type: String?
}

class AppInformation: Codable {
    var Name: String?
    var Value: String?
}

public enum Result<Value> {
    case success(Value)
    case failure(Error)
}

class Network {
    
    var urlString = ""
    static let shared = Network()
    let session = URLSession.shared
    
    private init() {}
    
    func fetchedGenericData<T: Codable>(id: Int? = nil,
                                        onComplete: @escaping (Result<T>) -> ()) {
        if let id = id {
            urlString = "https://api.letsbuildthatapp.com/appstore/appdetail?id=\(id)"
        } else {
            urlString = "https://api.letsbuildthatapp.com/appstore/featured"
        }
        
        guard let url = URL(string: urlString) else {
            onComplete(.failure(NSError(domain: "URL String Invalid", code: -1, userInfo: nil)))
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            guard (error == nil) else {
                onComplete(.failure(error ?? NSError(domain: "Error - Network", code: -1, userInfo: nil)))
                return
            }
            guard let data = data else {
                onComplete(.failure(error ?? NSError(domain: "Data - Network", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    onComplete(.success(result))
                }
            } catch let error {
                onComplete(.failure(error))
            }
        }
        
        task.resume()
    }
    
}
