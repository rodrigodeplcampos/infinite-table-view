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
        
        let container = self.registerDependancies()
        guard let infiniteScrollViewController = container.resolve(InfiniteScrollView.self) as? InfiniteScrollViewController else {
            window.rootViewController = UIViewController()
            return true
        }

        window.rootViewController = UINavigationController(rootViewController: infiniteScrollViewController)
        return true
    }
    
    func registerDependancies() -> Container {
        let container = Container()
        registerService(container: container)
        registerView(container: container)
        registerInteractor(container: container)
        registerPresenter(container: container)
        return container
    }
    
    func registerService(container: Container) {
        container.register(FlickrImageService.self) { _ in FlickrImageService() }.inObjectScope(.container)
    }
    
    func registerView(container: Container) {
        let view = container.register(InfiniteScrollView.self) { _ in InfiniteScrollViewController()}
        view.initCompleted { resolver, view in
            if let moduleView = view as? InfiniteScrollViewController {
                if let presenter = resolver.resolve(InfiniteScrollPresenter.self) {
                    moduleView.presenter = presenter
                    moduleView.delegateDataSource = InfiniteScrollDelegateDataSource(presenter: presenter)
                }
            }
        }
    }
    
    func registerInteractor(container: Container) {
        container.register(InfiniteScrollInteractor.self) { r in
            InfiniteScrollDefaultInteractor(service: r.resolve(FlickrImageService.self)!)
        }
    }
    
    func registerPresenter(container: Container) {
        container.register(InfiniteScrollPresenter.self) { resolver in
            InfiniteScrollDefaultPresenter(interactor: resolver.resolve(InfiniteScrollInteractor.self)!,
                                           view: resolver.resolve(InfiniteScrollView.self)!)
        }
    }
}

