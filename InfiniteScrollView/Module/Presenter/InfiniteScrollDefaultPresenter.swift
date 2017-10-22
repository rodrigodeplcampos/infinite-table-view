//
//  InfiniteScrollDefaultPresenter.swift
//  InfiniteScrollView
//
//  Created by Rodrigo De Paula on 21/10/2017.
//  Copyright © 2017 Rodrigo Campos. All rights reserved.
//

import Foundation

class InfiniteScrollDefaultPresenter: InfiniteScrollPresenter {
    let interactor: InfiniteScrollInteractor
    weak var view: InfiniteScrollView?
    var searchText: String
    var viewModel: ImageListViewModel?
    
    required init(interactor: InfiniteScrollInteractor, view: InfiniteScrollView) {
        self.interactor = interactor
        self.view = view
        self.searchText = ""
    }
    
    func displaySearchText(searchText: String) {
        self.view?.displaySearchText(searchText: searchText)
    }
    
    func loadContent(searchText: String) {
        self.viewModel = nil
        
        if searchText.isEmpty {
            self.view?.displayImages(images: ImageListViewModel(list: []))
            return
        }
        
        self.searchText = searchText
        load(newSearch: true)
    }
    
    func loadMore() {
        load(newSearch: false)
    }
    
    fileprivate func load(newSearch: Bool) {
        self.interactor.imageList(searchText: searchText, newSearch: newSearch) { [weak self] response in
            if let images = response {
                let newViewModel = ImageViewModelBuilder.buildViewModel(images: images, currentViewModel: self?.viewModel)
                self?.viewModel = newViewModel
                self?.view?.displayImages(images: newViewModel)
            }
        }
    }
}
