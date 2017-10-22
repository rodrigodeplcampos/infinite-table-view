//
//  InfiniteScrollPresenter.swift
//  InfiniteScrollView
//
//  Created by Rodrigo De Paula on 21/10/2017.
//  Copyright © 2017 Rodrigo Campos. All rights reserved.
//

import UIKit

protocol InfiniteScrollPresenter: class {
    func displaySearchText(searchText: String)
    func loadContent(searchText: String)
    func loadMore()
}
