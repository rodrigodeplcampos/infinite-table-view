//
//  InfiniteScrollViewController.swift
//  InfiniteScrollView
//
//  Created by Rodrigo De Paula on 21/10/2017.
//  Copyright © 2017 Rodrigo Campos. All rights reserved.
//

import UIKit

class InfiniteScrollViewController: UIViewController, InfiniteScrollView {

    @IBOutlet weak var tableView: UITableView!
    private let searchController = UISearchController(searchResultsController: nil)
    
    var delegateDataSource: InfiniteScrollDelegateDataSource?
    var presenter: InfiniteScrollPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        self.title = "Infinite Scroll View"
        
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Type in your term and press 'Search'"
        searchController.searchBar.sizeToFit()
        
        self.tableView.register(ImageTableViewCell.nib(), forCellReuseIdentifier: ImageTableViewCell.identifier())
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        self.tableView.separatorStyle = .none
        self.tableView.tableHeaderView = searchController.searchBar
        self.tableView.delegate = self.delegateDataSource
        self.tableView.dataSource = self.delegateDataSource
        
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = CGFloat(ImageTableViewCell.cellHeight())
    }
    
    func displaySearchText(searchText: String) {
        self.searchController.searchBar.text = searchText
        self.searchController.searchBar.resignFirstResponder()
    }
    
    func displayImages(images: ImageListViewModel) {
        self.delegateDataSource?.viewModel = images
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    fileprivate func toggleDelegateMode(mode: TableViewDelegateMode) {
        self.delegateDataSource?.toggleDelegateMode(mode: mode)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension InfiniteScrollViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.toggleDelegateMode(mode: .search)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.toggleDelegateMode(mode: .result)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.toggleDelegateMode(mode: .result)
        if let searchText = searchBar.text {
            if searchText.count >= 3 {
                self.delegateDataSource?.appendSearchText(searchText: searchText)
                self.presenter?.loadContent(searchText: searchText)
            } else {
                self.presenter?.loadContent(searchText: "")
            }
        }
    }
}

// * This is the extension to be used if you want to perform the search as the user types
//extension InfiniteScrollViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        if let searchText = searchController.searchBar.text {
//            if searchText.count >= 3 {
//                self.presenter?.loadContent(searchText: searchText)
//            } else {
//                self.presenter?.loadContent(searchText: "")
//            }
//        }
//    }
//}

