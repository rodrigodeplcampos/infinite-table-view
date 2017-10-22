//
//  InfiniteScrollDelegateDataSource.swift
//  InfiniteScrollView
//
//  Created by Rodrigo De Paula on 21/10/2017.
//  Copyright © 2017 Rodrigo Campos. All rights reserved.
//

import UIKit

enum TableViewDelegateMode {
    case search
    case result
}

class InfiniteScrollDelegateDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    weak var presenter: InfiniteScrollPresenter?
    var viewModel: ImageListViewModel?
    fileprivate var searchHistory = [String]()
    fileprivate var delegateMode: TableViewDelegateMode = .search
    
    required init(presenter: InfiniteScrollPresenter) {
        self.presenter = presenter
    }
    
    func appendSearchText(searchText: String) {
        searchHistory.append(searchText)
    }
    
    func toggleDelegateMode(mode: TableViewDelegateMode) {
        self.delegateMode = mode
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch delegateMode {
        case .search:
            return searchHistory.count
        case .result:
            if let imageList = self.viewModel?.list {
                return imageList.count
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch delegateMode {
        case .search:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else {
                return UITableViewCell()
            }
            
            cell.textLabel?.text = searchHistory[indexPath.row]
            return cell
        case .result:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier(), for: indexPath) as? ImageTableViewCell else {
                return ImageTableViewCell()
            }
            
            if let imageList = self.viewModel?.list {
                cell.setViewModel(viewModel: imageList[indexPath.row])
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if delegateMode == .search {
            return
        }
        
        if let imageList = self.viewModel?.list {
            if indexPath.row == imageList.count - 1 {
                self.presenter?.loadMore()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch delegateMode {
        case .search:
            return 40.0
        case .result:
            return CGFloat(ImageTableViewCell.cellHeight())
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if delegateMode == .result {
            return
        }
        
        let searchText = searchHistory[indexPath.row]
        self.toggleDelegateMode(mode: .result)
        self.presenter?.displaySearchText(searchText: searchText)
        self.presenter?.loadContent(searchText: searchText)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
