//
//  Models.swift
//  AppStore
//
//  Created by David Rodrigues on 09/09/2018.
//  Copyright © 2018 David Rodrigues. All rights reserved.
//

import UIKit

class Featured: Decodable {
    var bannerCategory: AppCategory?
    var categories: [AppCategory]?
}

class App: Decodable {
    var Id: Int?
    var Name: String?
    var Category: String?
    var ImageName: String?
    var Price: Float?
}

class AppCategory: Decodable {
    var name: String?
    var apps: [App]?
    var type: String?
}

extension AppCategory {
    
    static func fetchedFeaturedApps(completionHandler: @escaping (Featured) -> ()) {
        let session = URLSession.shared
        let urlString = "https://api.letsbuildthatapp.com/appstore/featured"
        
        let task = session.dataTask(with: URL(string: urlString)!) { (data, response, error) in
            guard (error == nil) else { return }
            guard let data = data else { return }
            
            var featuredApps = Featured()
            
            do {
                featuredApps = try JSONDecoder().decode(Featured.self, from: data)
            } catch let error {
                print(error)
            }
            
            DispatchQueue.main.async {
                completionHandler(featuredApps)
            }
        }
        task.resume()
    }
    
}
