//
//  ImageViewModel.swift
//  InfiniteScrollView
//
//  Created by Rodrigo De Paula on 21/10/2017.
//  Copyright © 2017 Rodrigo Campos. All rights reserved.
//

import Foundation

public struct ImageListViewModel {
    public var list:[ImageCellViewModel]
}

public struct ImageCellViewModel {
    public var images:[ImageViewModel]
}

public struct ImageViewModel {
    internal let url: String
    
    init(url: String) {
        self.url = url
    }
}
