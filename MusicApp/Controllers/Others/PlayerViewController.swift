//
//  PlayerViewController.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 1/3/21.
//

import UIKit
import SDWebImage

class PlayerViewController: UIViewController {
    
    weak var dataSource : PlayerDataSource?
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemBlue
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let controlsView = PlayerControlsView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        view.addSubview(imageView)
        view.addSubview(controlsView)
        controlsView.delegate = self
        configureBarButtonItems()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let imageSize = view.width-100
        imageView.frame = CGRect(x: 50, y: view.safeAreaInsets.top, width: imageSize, height: imageSize)
        controlsView.frame = CGRect(x: 10, y: imageView.bottom+10, width: view.width-20, height: view.height-imageView.height-view.safeAreaInsets.top-view.safeAreaInsets.bottom-15)
    }

    private func configureBarButtonItems(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapAction))
    }
    private func configure(){
        imageView.sd_setImage(with: dataSource?.imageURL, completed: nil)
        controlsView.configure(with: PlayerControlsViewViewModel(title: dataSource?.songName, subtitle: dataSource?.subtitle))
    }
    @objc private func didTapClose(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapAction(){
        
    }

}

extension PlayerViewController : PlayerControlsViewDelegate{
    func playerControlsViewDidTapPlayPause(_ playersControlsView: PlayerControlsView) {
        print("Play or pause")
    }
    
    func playerControlsViewDidTapForward(_ playersControlsView: PlayerControlsView) {
        print("forward")
    }
    
    func playerControlsViewDidTapBackward(_ playersControlsView: PlayerControlsView) {
        print("backward")
    }
    
    
}
