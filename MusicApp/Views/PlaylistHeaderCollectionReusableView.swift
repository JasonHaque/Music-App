//
//  PlaylistHeaderCollectionReusableView.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 22/4/21.
//

import SDWebImage
import UIKit

final class PlaylistHeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "PlaylistHeaderCollectionReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
