//
//  AppDelegate.swift
//  AppStore
//
//  Created by David Rodrigues on 09/09/2018.
//  Copyright © 2018 David Rodrigues. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let layout = UICollectionViewFlowLayout()
        let featuredAppsController = FeaturedAppsController(collectionViewLayout: layout)
        window?.rootViewController = UINavigationController(rootViewController: featuredAppsController)
        
        return true
    }

}
