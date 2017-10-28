//
//  ImageService.swift
//  InfiniteScrollView
//
//  Created by Rodrigo De Paula on 21/10/2017.
//  Copyright © 2017 Rodrigo Campos. All rights reserved.
//

import Foundation

public protocol ImageService {
    func imageList(searchText: String,
                   completion: @escaping (_ result: [DownloadableImage]?) -> Void)
    
    func paginate(searchText: String,
                  completion: @escaping (_ result: [DownloadableImage]?) -> Void)
    
    func resetPagination()
}
