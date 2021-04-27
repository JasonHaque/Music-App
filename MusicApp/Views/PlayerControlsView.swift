//
//  PlayerControlsView.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 26/4/21.
//

import Foundation
import UIKit

protocol PlayerControlsViewDelegate : AnyObject{
    func playerControlsViewDidTapPlayPause(_ playersControlsView : PlayerControlsView)
    func playerControlsViewDidTapForward(_ playersControlsView : PlayerControlsView)
    func playerControlsViewDidTapBackward(_ playersControlsView : PlayerControlsView)
    func playerControlsViewDidSlideVolumeSlider(_ playersControlsView : PlayerControlsView, didSlideSlider value : Float)
}

struct PlayerControlsViewViewModel{
    let title : String?
    let subtitle : String?
}

final class PlayerControlsView : UIView{
    
    weak var delegate : PlayerControlsViewDelegate?
    
    private var isPlaying = true
    
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
        backgroundColor = .clear
        addSubview(nameLabel)
        addSubview(subtitleLabel)
        addSubview(volumeSlider)
        addSubview(backButton)
        addSubview(forwardButton)
        addSubview(playPauseButton)
        
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        forwardButton.addTarget(self, action: #selector(didTapForwardButton), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
        volumeSlider.addTarget(self, action: #selector(didSlideSlider), for: .valueChanged)
        
        clipsToBounds = true
    }
    
    @objc private func didSlideSlider(_ slider : UISlider){
        let value = slider.value
        delegate?.playerControlsViewDidSlideVolumeSlider(self, didSlideSlider: value)
    }
    
    @objc private func didTapBackButton(){
        delegate?.playerControlsViewDidTapBackward(self)
    }
    
    @objc private func didTapForwardButton(){
        delegate?.playerControlsViewDidTapForward(self)
    }
    
    @objc private func didTapPlayPauseButton(){
        self.isPlaying = !isPlaying
        delegate?.playerControlsViewDidTapPlayPause(self)
        let play = UIImage(systemName: "pause",withConfiguration: UIImage.SymbolConfiguration(pointSize: 40, weight: .regular))
        let pause = UIImage(systemName: "play.fill",withConfiguration: UIImage.SymbolConfiguration(pointSize: 40, weight: .regular))
        playPauseButton.setImage(isPlaying ? play : pause, for: .normal)
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
        
        playPauseButton.frame = CGRect(x: (width-buttonSize)/2, y: volumeSlider.bottom+20, width: buttonSize, height: buttonSize)
        backButton.frame = CGRect(x: playPauseButton.left - 80 - buttonSize, y: playPauseButton.top, width: buttonSize, height: buttonSize)
        
        forwardButton.frame = CGRect(x: playPauseButton.right + 80, y: playPauseButton.top, width: buttonSize, height: buttonSize)
    }
    
    func configure(with viewModel : PlayerControlsViewViewModel){
        nameLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
    }
}
