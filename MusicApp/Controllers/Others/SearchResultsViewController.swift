//
//  SearchResultsViewController.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 1/3/21.
//

import UIKit

struct SearchSection{
    let title : String
    let results : [SingleSearchResult]
}

class SearchResultsViewController: UIViewController {

    private var sections : [SearchSection] = []
    
    private let tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    func update(with results : [SingleSearchResult]){
        let artists = results.filter({
            switch $0{
            case .artist: return true
            default : return false
            }
        })
        self.sections = [
            SearchSection(title: "Artists", results: artists)
        ]
        tableView.reloadData()
        
        tableView.isHidden = results.isEmpty
    }

}

extension SearchResultsViewController : UITableViewDelegate , UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let result = sections[indexPath.section].results[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        switch result{
        
        case .album(model: let model):
            cell.textLabel?.text = model.name
        case .artist(model: let model):
            cell.textLabel?.text = model.name
        case .track(model: let model):
            cell.textLabel?.text = model.name
        case .playlist(model: let model):
            cell.textLabel?.text = model.name
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
}
