//
//  ViewController.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 18/2/21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
        
        fetchData()
        
    }
    
    private func fetchData(){
        APICaller.shared.getAllNewReleases { result in
            
            switch result{
            
            case .success(let model):
                break
            case .failure(let error):
                break
            }
            
        }
    }
    
    @objc private func didTapSettings(){
        let vc = SettingsViewController()
        vc.title = "Settings"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }


}

