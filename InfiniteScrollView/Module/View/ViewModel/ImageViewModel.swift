//
//  ImageViewModel.swift
//  InfiniteScrollView
//
//  Created by Rodrigo De Paula on 21/10/2017.
//  Copyright © 2017 Rodrigo Campos. All rights reserved.
//

import Foundation

struct ImageListViewModel {
    var list:[ImageCellViewModel]
}

struct ImageCellViewModel {
    var images:[ImageViewModel]
}

struct ImageViewModel {
    var title: String?
    let url: String
    
    init(url: String) {
        self.url = url
    }
}
