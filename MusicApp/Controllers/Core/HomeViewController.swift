//
//  ViewController.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 18/2/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var collectionView : UICollectionView = UICollectionView(frame: .zero,
                                                                     collectionViewLayout:  UICollectionViewCompositionalLayout { sectionIndex, _  -> NSCollectionLayoutSection? in
                                   
                                                                          return Self.createSectionLayout(index: sectionIndex)
                               })

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
        
        
        
       configureCollectionView()
       
        
        fetchData()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = view.bounds
    }
    private func configureCollectionView(){
        view.addSubview(collectionView)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
    }
    
    private static func createSectionLayout(index : Int)-> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(120)), subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
        
    }
    
    private func fetchData(){
        
        //GEttings recommended tracks , featured playlists and new releases
        APICaller.shared.getRecommendedGenres { result in
            
            switch result{
            
            case .success(let model):
                let genres = model.genres
                var seeds = Set<String>()
                
                while seeds.count < 5 {
                    if let random = genres.randomElement() {
                        seeds.insert(random)
                    }
                    
                }
                
                APICaller.shared.getRecommendations(genres: seeds) { result in
                    
                }
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


extension HomeViewController : UICollectionViewDataSource , UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemTeal
        return cell
    }
    
    
}
