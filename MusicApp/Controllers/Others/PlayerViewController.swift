//
//  PlayerViewController.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 1/3/21.
//

import UIKit

class PlayerViewController: UIViewController {
    
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
