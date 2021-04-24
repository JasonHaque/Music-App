//
//  SearchViewController.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 1/3/21.
//

import UIKit

class SearchViewController: UIViewController, UISearchResultsUpdating {
    
    let searchController : UISearchController = {
        let result = UIViewController()
        result.view.backgroundColor = .red
        let vc = UISearchController(searchResultsController: result)
        vc.searchBar.placeholder = "SONGS , ARTISTS , ALBUMS"
        vc.searchBar.searchBarStyle = .minimal
        vc.definesPresentationContext = true
        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    
    //MARK:- search controller
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty else{
            
            return
        }
        
        print(query)
        
        //perform the search
    }
    
    
    

   
}
