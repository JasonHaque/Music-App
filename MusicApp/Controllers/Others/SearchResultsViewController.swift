//
//  SearchResultsViewController.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 1/3/21.
//

import UIKit

class SearchResultsViewController: UIViewController {

    private var results : [SingleSearchResult] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    func update(with results : [SingleSearchResult]){
        self.results = results
    }

}
