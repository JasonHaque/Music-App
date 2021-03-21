//
//  NewReleaseCollectionViewCell.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 21/3/21.
//

import UIKit
import SDWebImage

class NewReleaseCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "NewReleaseCollectionViewCell"
    
    private let albumCoverImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private let albumNameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20,weight : .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let numberOfTracksLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18,weight : .thin)
        label.numberOfLines = 0
        return label
    }()
    
    private let artistNameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18,weight : .light)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(numberOfTracksLabel)
        contentView.clipsToBounds = true
        contentView.addSubview(artistNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize : CGFloat = contentView.height-10
        let albumLabelSize = albumNameLabel.sizeThatFits(CGSize(width: contentView.width-10-imageSize, height: contentView.height-10))
        artistNameLabel.sizeToFit()
        numberOfTracksLabel.sizeToFit()
        
        
        
        albumCoverImageView.frame = CGRect(x: 5, y: 5, width: imageSize, height: imageSize)
        
        let albumLabelHeight = min(60,albumLabelSize.height)
        
        albumNameLabel.frame = CGRect(x: albumCoverImageView.right+10, y: 5, width: albumLabelSize.width, height: albumLabelHeight)
        
        artistNameLabel.frame = CGRect(x: albumCoverImageView.right+10, y: albumNameLabel.bottom, width: contentView.width - albumCoverImageView.right-10, height: 30)
        
        numberOfTracksLabel.frame = CGRect(x: albumCoverImageView.right+10, y: contentView.bottom-44, width: numberOfTracksLabel.width, height: 44)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        albumNameLabel.text = nil
        numberOfTracksLabel.text = nil
        artistNameLabel.text = nil
        albumCoverImageView.image = nil
    }
    
    func configure(with viewModel : NewReleasesCellViewModel){
        
        albumNameLabel.text = viewModel.name
        numberOfTracksLabel.text = "Tracks: \(viewModel.numberOfTracks)"
        artistNameLabel.text = viewModel.artistName
        albumCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
        
        
    }
}
