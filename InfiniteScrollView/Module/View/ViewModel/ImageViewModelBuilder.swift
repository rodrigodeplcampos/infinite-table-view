//
//  ImageViewModelBuilder.swift
//  InfiniteScrollView
//
//  Created by Rodrigo De Paula on 21/10/2017.
//  Copyright © 2017 Rodrigo Campos. All rights reserved.
//

import Foundation

class ImageViewModelBuilder {
    static func buildViewModel(images: [Image], currentViewModel: ImageListViewModel?) -> ImageListViewModel {
        let imageViewModelArray = ImageViewModelBuilder.convertFromEntityToViewModel(images: images)
        
        var counter = 1
        var imageCellViewModelArray = [ImageCellViewModel]()
        var imageCellViewModel = [ImageViewModel]()
        for imageViewModel in imageViewModelArray {
            imageCellViewModel.append(imageViewModel)
            if counter % 3 == 0 {
                imageCellViewModelArray.append(ImageCellViewModel(images: imageCellViewModel))
                counter = 1
                imageCellViewModel = [ImageViewModel]()
            } else {
                counter += 1
            }
        }
        
        if imageCellViewModel.count > 0 {
            imageCellViewModelArray.append(ImageCellViewModel(images: imageCellViewModel))
        }
        
        if let viewModel = currentViewModel {
            var mergedImageCellViewModel = viewModel.list
            mergedImageCellViewModel.append(contentsOf: imageCellViewModelArray)
            return ImageListViewModel(list: mergedImageCellViewModel)
        }
        
        return ImageListViewModel(list: imageCellViewModelArray)
    }
    
    static fileprivate func convertFromEntityToViewModel(images: [Image]) -> [ImageViewModel] {
        return images.map {
            var imageViewModel = ImageViewModel(url: $0.url)
            imageViewModel.title = $0.title
            return imageViewModel
        }
    }
}
