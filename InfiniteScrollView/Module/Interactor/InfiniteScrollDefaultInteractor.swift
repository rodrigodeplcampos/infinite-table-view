//
//  InfiniteScrollDefaultInteractor.swift
//  InfiniteScrollView
//
//  Created by Rodrigo De Paula on 21/10/2017.
//  Copyright © 2017 Rodrigo Campos. All rights reserved.
//

import Foundation

class InfiniteScrollDefaultInteractor: InfiniteScrollInteractor {
    
    let imageService: ImageService
    
    init(service: ImageService) {
        self.imageService = service
    }
    
    func imageList(searchText: String,
                    newSearch: Bool,
                   completion: @escaping (_ result: [Image]?) -> Void) {
        if newSearch == true {
            self.imageService.resetPagination()
        }
        
        self.imageService.paginate(searchText: searchText) { response in
            completion(response)
        }
    }
}
