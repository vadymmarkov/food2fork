//
//  SearchResultsViewController.swift
//  Food2Fork
//
//  Created by Vadym Markov on 07/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {

}

final class SearchResultsViewController: UIViewController {
    weak var delegate: SearchResultsViewControllerDelegate?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.seashell()
    }
}

// MARK: - UISearchResultsUpdating

extension SearchResultsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        //let searchBar = searchController.searchBar
    }
}
