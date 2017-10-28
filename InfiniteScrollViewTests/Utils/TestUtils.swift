//
//  TestUtils.swift
//  InfiniteScrollViewTests
//
//  Created by Rodrigo De Paula on 27/10/2017.
//  Copyright © 2017 Rodrigo Campos. All rights reserved.
//

import Foundation
@testable import InfiniteScrollView

struct TestUtils {
    static func downloadableImageFromFile(filePath: String) -> [DownloadableImage]? {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath), options: .alwaysMapped)
            let jsonResult: [String: Any] = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String : Any]
            let flickrResponse = FlickrResponse(JSON: jsonResult)
            return flickrResponse?.photos?.photo
        } catch _ {
            print("Response file not found")
            return nil
        }
    }
    
    static func mockImageViewModel() -> ImageListViewModel {
        let firstImageViewModel = ImageViewModel(url: "http://aURL/image1.jpg")
        let secondImageViewModel = ImageViewModel(url: "http://aURL/image2.jpg")
        let thirdImageViewModel = ImageViewModel(url: "http://aURL/image3.jpg")
        
        let imageCellViewModel = ImageCellViewModel(images: [firstImageViewModel, secondImageViewModel, thirdImageViewModel])
        
        return ImageListViewModel(list: [imageCellViewModel])
    }
}
