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

class Network {
    
    static let shared = Network()
    let session = URLSession.shared
    
    private init() {}
    
    func fetchedGenericData<T: Codable>(id: Int? = nil,
                                               onComplete: @escaping (T) -> ()) {
        let session = URLSession.shared
        
        var urlString = ""
        
        if let id = id {
            urlString = "https://api.letsbuildthatapp.com/appstore/appdetail?id=\(id)"
        } else {
            urlString = "https://api.letsbuildthatapp.com/appstore/featured"
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            guard (error == nil) else { return }
            guard let data = data else { return }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    onComplete(result)
                }
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
    
}
