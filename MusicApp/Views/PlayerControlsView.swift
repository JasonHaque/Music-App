//
//  PlayerControlsView.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 26/4/21.
//

import Foundation
import UIKit

final class PlayerControlsView : UIView{
    
    private let volumeSlider : UISlider = {
        let slider = UISlider()
        slider.value = 0.5
        return slider
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "My Song"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let subtitleLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Jason feat. DreakeX"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let backButton : UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "backward.fill",withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    private let forwardButton : UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "forward.fill",withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    private let playPauseButton : UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "pause",withConfiguration: UIImage.SymbolConfiguration(pointSize: 40, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        addSubview(nameLabel)
        addSubview(subtitleLabel)
        addSubview(volumeSlider)
        addSubview(backButton)
        addSubview(forwardButton)
        addSubview(playPauseButton)
        
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.frame = CGRect(x: 0, y: 0, width: width, height: 50)
        
        subtitleLabel.frame = CGRect(x: 0, y: nameLabel.bottom+10, width: width, height: 50)
        volumeSlider.frame = CGRect(x: 0, y: subtitleLabel.bottom+20, width: width-20, height: 44)
        
        let buttonSize : CGFloat = 60
        
        playPauseButton.frame = CGRect(x: (width-buttonSize)/2, y: volumeSlider.bottom+30, width: buttonSize, height: buttonSize)
        backButton.frame = CGRect(x: playPauseButton.left - 80 - buttonSize, y: playPauseButton.top, width: buttonSize, height: buttonSize)
        
        forwardButton.frame = CGRect(x: playPauseButton.right + 80, y: playPauseButton.top, width: buttonSize, height: buttonSize)
    }
}
