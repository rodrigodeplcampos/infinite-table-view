//
//  FlickrImageService.swift
//  InfiniteScrollView
//
//  Created by Rodrigo De Paula on 21/10/2017.
//  Copyright © 2017 Rodrigo Campos. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

enum PaginationState {
    case initial
    case ready
    case loading
    case end
}

class FlickrImageService: ImageService {

    private let flickrServiceURL = "https://api.flickr.com/services/rest/"
    private var currentPage = 0
    private var lastPage = 0
    private var state: PaginationState = .initial
    private let apiPlistKey = "FlickrAPIKey"
    
    private func parameters(searchText: String, pageNumber: Int) -> [String:String] {
        return ["method":"flickr.photos.search",
                "api_key":apiKey(),
                "format":"json",
                "nojsoncallback":"1",
                "safe_search":"1",
                "page": "\(pageNumber)",
                "per_page": "30",
                "text":searchText]
    }
    
    private func apiKey() -> String {
        guard let infoPlist = Bundle.main.infoDictionary,
              let flickrAPIKey = infoPlist[apiPlistKey] as? String else {
            assertionFailure("FlickrAPIKey must be provided in the Info.plist file")
            return ""
        }
        
        return flickrAPIKey
    }
    
    func resetPagination() {
        state = .initial
    }
    
    func imageList(searchText: String, completion: @escaping ([DownloadableImage]?) -> Void) {
        paginate(searchText: searchText, completion: completion)
    }
    
    func paginate(searchText: String, completion: @escaping ([DownloadableImage]?) -> Void) {
        switch state {
        case .initial:
            lastPage = 0
            currentPage = 0
            fallthrough
        case .ready:
            state = .loading
            currentPage += 1
            requestPage(searchText, completion)
        case .loading:
            return
        case .end:
            completion([DownloadableImage]())
        }
    }
    
    private func requestPage(_ searchText: String, _ completion: @escaping ([DownloadableImage]?) -> Void) {
        Alamofire.request(flickrServiceURL, parameters: parameters(searchText: searchText, pageNumber: currentPage)).responseObject {
            [weak self] (response: DataResponse<FlickrResponse>) in
            
            guard let flickrResponse = response.result.value, let photos = flickrResponse.photos else {
                self?.resetPagination()
                completion(nil)
                return
            }
            
            self?.lastPage = photos.pages ?? 0
            self?.state = self?.currentPage == self?.lastPage ? .end : .ready
            completion(photos.photo)
        }
    }
}
