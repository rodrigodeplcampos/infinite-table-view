//
//  ImageViewModelBuilder.swift
//  InfiniteScrollViewTests
//
//  Created by Rodrigo De Paula on 27/10/2017.
//  Copyright © 2017 Rodrigo Campos. All rights reserved.
//

import UIKit
import Quick
import Nimble
@testable import InfiniteScrollView

class ImageViewModelBuilderSpec: QuickSpec {
    override func spec() {
        super.spec()
        
        describe("view model builder") {
            var imageModel: [DownloadableImage]?
            
            beforeEach {
                guard let responseFile = Bundle.init(for: ImageViewModelBuilderSpec.self).path(forResource: "flickr_response", ofType: "json") else {
                    expect(1).to(equal(2))
                    return
                }
                
                imageModel = TestUtils.downloadableImageFromFile(filePath: responseFile)
            }
            
            context("loading mock data") {
                it("should be loaded") {
                    expect(imageModel).toNot(beNil())
                    expect(imageModel?.count).to(equal(100))
                }
            }
            
            context("building a new view model") {
                it("should build it correctly", closure: {
                    if let model = imageModel {
                        let viewModel = ImageViewModelBuilder.buildViewModel(images: model,currentViewModel: nil)
                        expect(viewModel).toNot(beNil())
                        expect(viewModel.list.count).to(equal(34))
                        
                        if let firstImageCellModel = viewModel.list.first {
                            expect(firstImageCellModel.images.count).to(equal(3))
                            
                            if let firstImageViewModel = firstImageCellModel.images.first {
                                expect(firstImageViewModel.url).to(equal("https://farm5.static.flickr.com/4455/26172785149_e5551f577e.jpg"))
                            }
                        }
                    }
                })
            }
            
            context("merging an existing view model with a new one") {
                it("should merge them correctly", closure: {
                    if let model = imageModel {
                        let viewModel = ImageViewModelBuilder.buildViewModel(images: model,currentViewModel: TestUtils.mockImageViewModel())
                        expect(viewModel).toNot(beNil())
                        expect(viewModel.list.count).to(equal(35))
                        
                        if let firstImageCellModel = viewModel.list.first {
                            expect(firstImageCellModel.images.count).to(equal(3))
                            
                            if let firstImageViewModel = firstImageCellModel.images.first {
                                expect(firstImageViewModel.url).to(equal("http://aURL/image1.jpg"))
                            }
                        }
                    }
                })
            }
        }
    }
}
