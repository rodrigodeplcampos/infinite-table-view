//
//  InfiniteScrollViewModuleBuilder.swift
//  InfiniteScrollView
//
//  Created by Rodrigo De Paula on 24/10/2017.
//  Copyright © 2017 Rodrigo Campos. All rights reserved.
//

import UIKit

public protocol InfiniteScrollViewModuleBuilder {
    func buildModule() -> InfiniteScrollView
    func buildModule(service: ImageService) -> InfiniteScrollView
}
