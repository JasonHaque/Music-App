//
//  ProfileViewController.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 1/3/21.
//

import UIKit

class ProfileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    private let tableView : UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Profile"
        fetchProfile()
        view.backgroundColor = .systemBackground
        
    }
    
    
    private func fetchProfile(){
        APICaller.shared.getCurrentUserProfile {[weak self] result in
            
            DispatchQueue.main.async {
                switch result{

                case .success(let model):
                    self?.updateUI(with : model)
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.failedToGetProfile()
                }
                
            }
            
        }
    }
    
    private func updateUI(with model : UserProfile){
        
    }
    
    private func failedToGetProfile(){
        let label = UILabel(frame: .zero)
        
        label.text = "Failed to load Profile"
        label.textColor = .secondaryLabel
        label.sizeToFit()
        label.center = view.center
        
        view.addSubview(label)
    }

    

}
