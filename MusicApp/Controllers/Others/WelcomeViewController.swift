//
//  WelcomeViewController.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 1/3/21.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private let signInButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Sign In with spotify", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Spoitfy"
        view.backgroundColor = .systemGreen
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        signInButton.frame = CGRect(x: 20, y: view.height-50-view.safeAreaInsets.bottom, width: view.width-40, height: 50)
        
    }
    
    @objc func didTapSignIn(){
        let vc = AuthViewController()
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completionHandler = {[weak self] success in
            
            DispatchQueue.main.async {
                self?.handleSignIn(success : success)
            }
            
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func handleSignIn(success : Bool){
        
        guard success else {
            let alert = UIAlertController(title: "OOPs", message: "Something wrong while signing in", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert,animated: true)
            
            return
        }
        
        let mainApptabBarVC = TabsViewController()
        
        mainApptabBarVC.modalPresentationStyle = .fullScreen
        
        present(mainApptabBarVC, animated: true)
        
    }
    

    

}
