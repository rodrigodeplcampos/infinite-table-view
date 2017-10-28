//
//  InfiniteScrollViewDefaultModuleBuilder.swift
//  InfiniteScrollView
//
//  Created by Rodrigo De Paula on 24/10/2017.
//  Copyright © 2017 Rodrigo Campos. All rights reserved.
//

import Foundation
import Swinject

public class InfiniteScrollViewDefaultModuleBuilder: NSObject, InfiniteScrollViewModuleBuilder {
    
    private let container: Container
    
    public init(parentContainer: Container) {
        container = Container(parent: parentContainer)
        super.init()
    }
    
    //MARK: Protocol implementation
    public func buildModule() -> InfiniteScrollView {
        registerService(container: container)
        return buildModule(service: container.resolve(ImageService.self)!)
    }
    
    public func buildModule(service: ImageService) -> InfiniteScrollView {
        registerView(container: container)
        registerInteractor(container: container, service: service)
        registerPresenter(container: container)
        return container.resolve(InfiniteScrollView.self)!
    }
    
    //MARK: Dependancies registration
    private func registerView(container: Container) {
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
    
    private func registerInteractor(container: Container, service: ImageService) {
        container.register(InfiniteScrollInteractor.self) { r in
            InfiniteScrollDefaultInteractor(service: service)
        }
    }
    
    private func registerPresenter(container: Container) {
        container.register(InfiniteScrollPresenter.self) { resolver in
            InfiniteScrollDefaultPresenter(interactor: resolver.resolve(InfiniteScrollInteractor.self)!,
                                           view: resolver.resolve(InfiniteScrollView.self)!)
        }
    }
    
    private func registerService(container: Container) {
        container.register(ImageService.self) { _ in FlickrImageService() }.inObjectScope(.container)
    }
}
