//
//  ProfileViewController.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 1/3/21.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    private let tableView : UITableView = {
        let table = UITableView()
        table.isHidden = true
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    private var models = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Profile"
        fetchProfile()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
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
        
        tableView.isHidden = false
        
        //configure tableview models
        
        models.append("Full Name : \(model.display_name)")
        models.append("Email Address : \(model.email)")
        models.append("User ID : \(model.id)")
        models.append("Plan : \(model.product)")
        createTableHeader(with : model.images.first?.url)
        tableView.reloadData()
        
    }
    
    private func createTableHeader(with string : String?){
        
        guard let urlString = string , let url = URL(string: urlString) else{
            
            return
        }
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.width/1.5))
        let imageSize = headerView.height/2
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
        headerView.addSubview(imageView)
        imageView.center = headerView.center
        imageView.contentMode = .scaleAspectFill
        imageView.sd_setImage(with: url, completed: nil)
        tableView.tableHeaderView = headerView
    }
    
    private func failedToGetProfile(){
        let label = UILabel(frame: .zero)
        
        label.text = "Failed to load Profile"
        label.textColor = .secondaryLabel
        label.sizeToFit()
        label.center = view.center
        
        view.addSubview(label)
    }

    //MARK:- TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }

}
