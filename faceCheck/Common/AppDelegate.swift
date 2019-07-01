//
//  AppDelegate.swift
//  faceCheck
//
//  Created by Booharin on 29/06/2019.
//  Copyright © 2019 Booharin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: ApplicationCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        coordinator = ApplicationCoordinator()
        coordinator?.start()
        
        return true
    }
}

