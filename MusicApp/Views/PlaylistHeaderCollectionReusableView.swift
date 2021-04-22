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
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight : .semibold)
        return label
    }()
    
    private let descriptionLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight : .regular)
        return label
    }()
    
    private let ownerLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight : .light)
        return label
    }()
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    
    //MARK:- init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(ownerLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(with viewModel : PlayListHeaderViewModel){
        nameLabel.text = viewModel.playListName
        ownerLabel.text = viewModel.ownerName
        descriptionLabel.text = viewModel.description
        
        imageView.sd_setImage(with: viewModel.artWorkURL, completed: nil)
    }
}
