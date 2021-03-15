//
//  ProfileViewController.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 1/3/21.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Profile"
        
        APICaller.shared.getCurrentUserProfile { result in
            
            switch result{
            
            case .success(let model):
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    

    

}
