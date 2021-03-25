//
//  ViewController.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 18/2/21.
//


import UIKit

enum BrowseSectionType{
    case newReleases(viewModel : [NewReleasesCellViewModel])
    case featuredPlayLists(viewModel : [FeaturedPlayListCellViewModel])
    case recommendedTracks(viewModel : [RecommendedTrackCellViewModel])
    
}

class HomeViewController: UIViewController {
    
    private var collectionView : UICollectionView = UICollectionView(frame: .zero,
                                                                     collectionViewLayout:  UICollectionViewCompositionalLayout { sectionIndex, _  -> NSCollectionLayoutSection? in
                                                                        
                                                                        return HomeViewController.createSectionLayout(index: sectionIndex)})
    
    private let spinner : UIActivityIndicatorView = {
        
        let spinner = UIActivityIndicatorView()
        spinner.tintColor = .label
        spinner.hidesWhenStopped = true
        return spinner
        
    }()
    private var sections = [BrowseSectionType]()
    private var newAlbums : [Album] = []
    private var playlists : [Playlist] = []
    private var tracks : [AudioTrack] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
        
        
        
        configureCollectionView()
        
        view.addSubview(spinner)
        
        fetchData()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = view.bounds
    }
    private func configureCollectionView(){
        view.addSubview(collectionView)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(NewReleaseCollectionViewCell.self, forCellWithReuseIdentifier: NewReleaseCollectionViewCell.identifier)
        collectionView.register(FeaturedPlayListCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedPlayListCollectionViewCell.identifier)
        collectionView.register(RecommendedTracksCollectionViewCell.self, forCellWithReuseIdentifier: RecommendedTracksCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
    }
    
    
    
    private func fetchData(){
        
        //calling dispatchGroup for concurrent operation
        
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        
        var newReleases : NewReleasesResponse?
        var featuredPlayList : FeaturedPlaylistResponse?
        var recommendedTracks : RecommendationsResponse?
        
        //getting new releases
        
        APICaller.shared.getAllNewReleases { result in
            defer{
                group.leave()
            }
            switch result{
            case .success(let model):
                newReleases = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        //getting featured playlists
        
        APICaller.shared.getFeaturedPlayLists { result in
            defer{
                group.leave()
            }
            switch result {
            case .success(let model):
                featuredPlayList = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        //GEttings recommended tracks
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
                
                APICaller.shared.getRecommendations(genres: seeds) { recommendedResult in
                    
                    defer{
                        group.leave()
                    }
                    
                    switch recommendedResult{
                    case .success(let recommendedModel):
                        recommendedTracks = recommendedModel
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        
        group.notify(queue: .main) {
            
            guard let newAlbums = newReleases?.albums.items ,
                  let playlists = featuredPlayList?.playlists.items,
                  let tracks = recommendedTracks?.tracks else{
                return
            }
            self.configureModels(newAlbums: newAlbums, playlists: playlists, tracks: tracks)
            
        }
        
        
    }
    
    private func configureModels(newAlbums : [Album],playlists : [Playlist],tracks : [AudioTrack]){
        
        //saving the properties
        
        self.newAlbums = newAlbums
        self.playlists = playlists
        self.tracks = tracks
        
        //configure models
        sections.append(.newReleases(viewModel: newAlbums.compactMap({
            return NewReleasesCellViewModel(name: $0.name, artworkURL: URL(string: $0.images.first?.url ?? "") , numberOfTracks: $0.total_tracks, artistName: $0.artists.first?.name ?? "-")
        })))
        sections.append(.featuredPlayLists(viewModel: playlists.compactMap({
            return FeaturedPlayListCellViewModel(name: $0.name, artWorkURL: URL(string: $0.images.first?.url ?? "" ) , creatorName: $0.owner.display_name)
        })))
        sections.append(.recommendedTracks(viewModel: tracks.compactMap({
            return RecommendedTrackCellViewModel(name: $0.name, artistName: $0.artists.first?.name ?? "-", artWorkURL: URL(string: $0.album.images.first?.url ?? ""))
        })))
        collectionView.reloadData()
    }
    
    @objc private func didTapSettings(){
        let vc = SettingsViewController()
        vc.title = "Settings"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


extension HomeViewController : UICollectionViewDataSource , UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = sections[section]
        
        switch type {
        case .newReleases(let viewModels):
            return viewModels.count
        case .featuredPlayLists(let viewModels):
            return viewModels.count
        case .recommendedTracks(let viewModels):
            return viewModels.count
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let type = sections[indexPath.section]
        
        switch type {
        case .newReleases(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewReleaseCollectionViewCell.identifier, for: indexPath) as? NewReleaseCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            let viewmodel = viewModels[indexPath.row]
            cell.configure(with: viewmodel)
            return cell
            
        case .featuredPlayLists(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedPlayListCollectionViewCell.identifier, for: indexPath) as? FeaturedPlayListCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            return cell
            
            
        case .recommendedTracks(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedTracksCollectionViewCell.identifier, for: indexPath) as? RecommendedTracksCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            return cell
            
            
        }
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let section = sections[indexPath.section]
        
        switch section{
        
        case .newReleases:
            break
        case .featuredPlayLists:
            break
        case .recommendedTracks:
            break
        }
    }
    
     static func createSectionLayout(index : Int)-> NSCollectionLayoutSection {
        
        switch index {
        
        case 0 :
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(390)), subitem: item, count: 3)
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(390)), subitem: verticalGroup, count: 1)
            
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            return section
        case 1 :
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(200)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(400)), subitem: item, count: 2)
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(400)), subitem: verticalGroup, count: 1)
            
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .continuous
            return section
            
        case 2 :
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80)), subitem: item, count: 1)
            
           
            
            let section = NSCollectionLayoutSection(group: group)
           
            return section
            
        default:
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(390)), subitem: item, count: 1)
            
            let section = NSCollectionLayoutSection(group: group)
            return section
            
        
        }
    }
    
    
}
