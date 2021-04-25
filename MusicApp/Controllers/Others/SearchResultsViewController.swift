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
        let albums = results.filter({
            switch $0{
            case .album: return true
            default : return false
            }
        })
        let tracks = results.filter({
            switch $0{
            case .track: return true
            default : return false
            }
        })
        let playlists = results.filter({
            switch $0{
            case .playlist: return true
            default : return false
            }
        })
        self.sections = [
            SearchSection(title: "Tracks", results: tracks),
            SearchSection(title: "Artists", results: artists),
            SearchSection(title: "PlayLists", results: playlists),
            SearchSection(title: "Albums", results: albums)
            
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let result = sections[indexPath.section].results[indexPath.row]
        
        
        switch result{
        
        case .album(model: let model):
            let vc = AlbumViewController(album: model)
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        case .artist(model: let model):
            break
        case .track(model: let model):
            break
        case .playlist(model: let model):
            let vc = PlaylistViewController(playlist: model)
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
}
