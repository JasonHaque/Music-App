//
//  PlaylistHeaderCollectionReusableView.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 22/4/21.
//

import SDWebImage
import UIKit

protocol PlaylistHeaderCollectionReusableViewDelegate : AnyObject {
    
    func PlaylistHeaderCollectionReusableViewDidTapPlayAll(_ header : PlaylistHeaderCollectionReusableView)
}

final class PlaylistHeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "PlaylistHeaderCollectionReusableView"
    
    weak var delegate : PlaylistHeaderCollectionReusableViewDelegate?
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight : .semibold)
        return label
    }()
    
    private let descriptionLabel : UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight : .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let ownerLabel : UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight : .light)
        return label
    }()
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    
    private let playAllButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        let image = UIImage(systemName: "play.fill",withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        return button
    }()
    
    //MARK:- init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(ownerLabel)
        addSubview(playAllButton)
        playAllButton.addTarget(self, action: #selector(didTapPlayAll), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize = height/1.8
        
        imageView.frame = CGRect(x: (width-imageSize)/2, y: 20, width: imageSize, height: imageSize)
        nameLabel.frame = CGRect(x: 10, y: imageView.bottom, width: width-20, height: 44)
        descriptionLabel.frame = CGRect(x: 10, y: nameLabel.bottom, width: width-20, height: 44)
        ownerLabel.frame = CGRect(x: 10, y: descriptionLabel.bottom, width: width-20, height: 44)
        playAllButton.frame = CGRect(x: width-70, y: height-70, width: 40, height: 40)
    }
    
    @objc private func didTapPlayAll(){
        
        delegate?.PlaylistHeaderCollectionReusableViewDidTapPlayAll(self)
        
    }
    
    func configure(with viewModel : PlayListHeaderViewModel){
        nameLabel.text = viewModel.playListName
        ownerLabel.text = viewModel.ownerName
        descriptionLabel.text = viewModel.description
        
        imageView.sd_setImage(with: viewModel.artWorkURL, completed: nil)
    }
}
