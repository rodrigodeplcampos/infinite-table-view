//
//  FlickrImageModel.swift
//  InfiniteScrollView
//
//  Created by Rodrigo De Paula on 26/10/2017.
//  Copyright © 2017 Rodrigo Campos. All rights reserved.
//

import ObjectMapper

class FlickrResponse: Mappable {
    
    var photos: FlickrPhotos?
    var stat: String?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        photos <- map["photos"]
        stat <- map["stat"]
    }
}

class FlickrPhotos: Mappable {
    
    var page: Int?
    var pages: Int?
    var perPage: Int?
    var total: Int?
    var photo: [FlickrImage]?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        page <- map["page"]
        pages <- map["pages"]
        perPage <- map["perpage"]
        total <- map["total"]
        photo <- map["photo"]
    }
}

class FlickrImage: Mappable, DownloadableImage {
    
    var imageId: String?
    var owner: String?
    var secret: String?
    var server: String?
    var farm: Int?
    var title: String?
    var isPublic: Bool?
    var isFriend: Bool?
    var isFamily: Bool?
    
    required init?(map: Map){}
    
    func imageUrl() -> String? {
        guard let secret = secret, let server = server, let imageId = imageId, let farm = farm else {
            return nil
        }
        
        return "https://farm\(farm).static.flickr.com/\(server)/\(imageId)_\(secret).jpg"
    }
    
    func mapping(map: Map) {
        imageId <- map["id"]
        owner <- map["owner"]
        secret <- map["secret"]
        server <- map["server"]
        farm <- map["farm"]
        title <- map["title"]
        isPublic <- map["ispublic"]
        isFriend <- map["isfriend"]
        isFamily <- map["isfamily"]
    }
}
