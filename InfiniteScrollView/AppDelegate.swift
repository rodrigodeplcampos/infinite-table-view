//
//  AppDelegate.swift
//  InfiniteScrollView
//
//  Created by Rodrigo De Paula on 21/10/2017.
//  Copyright © 2017 Rodrigo Campos. All rights reserved.
//

import UIKit
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window
        
        let moduleBuilder = InfiniteScrollViewDefaultModuleBuilder(parentContainer: Container())
        
        guard let infiniteScrollViewController = moduleBuilder.buildModule() as? UIViewController else {
            window.rootViewController = UIViewController()
            return true
        }

        window.rootViewController = UINavigationController(rootViewController: infiniteScrollViewController)
        return true
    }
}

