//
//  PlaylistViewController.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 1/3/21.
//

import UIKit

class PlaylistViewController: UIViewController {

    private let playlist : Playlist
    
    init(playlist : Playlist){
        self.playlist = playlist
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = playlist.name
        view.backgroundColor = .systemBackground
        
        APICaller.shared.getPlayListDetails(for: playlist) { result in
            
            DispatchQueue.main.async {
                switch result{
                
                case .success(let model):
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        }
    }
}
