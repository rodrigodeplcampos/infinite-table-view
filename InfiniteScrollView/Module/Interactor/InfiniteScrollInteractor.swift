//
//  InfiniteScrollInteractor.swift
//  InfiniteScrollView
//
//  Created by Rodrigo De Paula on 21/10/2017.
//  Copyright © 2017 Rodrigo Campos. All rights reserved.
//

import Foundation

protocol InfiniteScrollInteractor {
    func imageList(searchText: String,
                   newSearch: Bool,
                   completion: @escaping (_ result: [Image]?) -> Void)
}
