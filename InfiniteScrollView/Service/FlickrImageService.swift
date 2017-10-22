//
//  FlickrImageService.swift
//  InfiniteScrollView
//
//  Created by Rodrigo De Paula on 21/10/2017.
//  Copyright © 2017 Rodrigo Campos. All rights reserved.
//

import Foundation
import Alamofire

enum PaginationState {
    case initial
    case ready
    case loading
    case end
}

class FlickrImageService: ImageService {

    let flickrServiceURL = "https://api.flickr.com/services/rest/"
    let apiKey = "3e7cc266ae2b0e0d78e279ce8e361736"
    var currentPage = 0
    var lastPage = 0
    var state: PaginationState = .initial
    
    fileprivate func parameters(searchText: String, pageNumber: Int) -> [String:String] {
        return ["method":"flickr.photos.search",
                "api_key":apiKey,
                "format":"json",
                "nojsoncallback":"1",
                "safe_search":"1",
                "page": "\(pageNumber)",
                "per_page": "30",
                "text":searchText]
    }
    
    fileprivate func imageFromFlickrResponse(photoInfo: [String:Any]) -> Image? {
        guard let secret = photoInfo["secret"], let server = photoInfo["server"], let id = photoInfo["id"], let farm = photoInfo["farm"] else {
            return nil
        }
        
        var image = Image(url: "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg")
        image.title = photoInfo["title"] as? String
        
        return image
    }
    
    func resetPagination() {
        state = .initial
    }
    
    func imageList(searchText: String, completion: @escaping ([Image]?) -> Void) {
        paginate(searchText: searchText, completion: completion)
    }
    
    func paginate(searchText: String, completion: @escaping ([Image]?) -> Void) {
        switch state {
        case .initial:
            lastPage = 0
            currentPage = 0
            fallthrough
        case .ready:
            state = .loading
            currentPage += 1
            Alamofire.request(flickrServiceURL, parameters: parameters(searchText: searchText, pageNumber: currentPage)).responseJSON { [weak self] response in
                guard let photos = response.result.value as? [String: Any] else {
                    self?.resetPagination()
                    completion(nil)
                    return
                }
                
                var images = [Image]()
                if let photoInfoDictionary = photos["photos"] as? [String:Any] {
                    if let photoArray = photoInfoDictionary["photo"] as? [[String:Any]] {
                        self?.lastPage = photoInfoDictionary["pages"] as? Int ?? 0
                        for photoInfo in photoArray {
                            if let image = self?.imageFromFlickrResponse(photoInfo: photoInfo) {
                                images.append(image)
                            }
                        }
                        self?.state = self?.currentPage == self?.lastPage ? .end : .ready
                        completion(images)
                    } else {
                        self?.resetPagination()
                        completion(nil)
                    }
                } else {
                    self?.resetPagination()
                    completion(nil)
                }
            }
        case .loading:
            return
        case .end:
            completion([Image]())
        }
    }
}
