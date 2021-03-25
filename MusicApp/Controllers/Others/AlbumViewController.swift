//
//  AlbumViewController.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 25/3/21.
//

import UIKit

class AlbumViewController: UIViewController {
    
    private let album : Album
    
    init(album : Album){
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = album.name
        view.backgroundColor = .systemBackground
    }
    

    

}
