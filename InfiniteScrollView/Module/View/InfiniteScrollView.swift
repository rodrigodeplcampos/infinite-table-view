//
//  InfiniteScrollView.swift
//  InfiniteScrollView
//
//  Created by Rodrigo De Paula on 21/10/2017.
//  Copyright © 2017 Rodrigo Campos. All rights reserved.
//

import UIKit

public protocol InfiniteScrollView: class {
    func displayImages(images: ImageListViewModel)
    func displaySearchText(searchText: String)
}
