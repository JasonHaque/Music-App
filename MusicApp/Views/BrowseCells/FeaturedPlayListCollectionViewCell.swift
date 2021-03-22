//
//  FeaturedPlayListCollectionViewCell.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 21/3/21.
//

import UIKit

class FeaturedPlayListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FeaturedPlayListCollectionViewCell"
    
    private let playlistCoverImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private let playlistNameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20,weight : .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let creatorNameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18,weight : .light)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .red
        contentView.addSubview(playlistCoverImageView)
        contentView.addSubview(playlistNameLabel)
        contentView.clipsToBounds = true
        contentView.addSubview(creatorNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        playlistNameLabel.text = nil
        creatorNameLabel.text = nil
        playlistCoverImageView.image = nil
    }
    
    func configure(with viewModel : FeaturedPlayListCellViewModel){
        
        playlistNameLabel.text = viewModel.name
        creatorNameLabel.text = viewModel.creatorName
        playlistCoverImageView.sd_setImage(with: viewModel.artWorkURL, completed: nil)
        
        
    }
    
}
