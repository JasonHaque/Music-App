//
//  APICaller.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 1/3/21.
//

import Foundation

final class APICaller{
    
    static let shared = APICaller()
    
    private init(){}
    
    struct Constants {
        
        static let baseAPIURL = "https://api.spotify.com/v1"
        
    }
    //MARK: - Albums
    
    public func getAlbumDetails(for album : Album, completion : @escaping ((Result<AlbumDetailsResponse,Error>)->Void)){
        
        createRequest(with: URL(string: Constants.baseAPIURL+"/albums/"+album.id), type: .GET) { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                
                guard let data = data , error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do{
                    let result = try JSONDecoder().decode(AlbumDetailsResponse.self, from: data)
                    
                    print(result)
                    completion(.success(result))
                }
                catch{
                    print("Somthing went wrong \(error.localizedDescription)")
                    completion(.failure(error))
                }
                
            }
            task.resume()
        }
        
    }
    
    //MARK: - Playlists
    
    public func getPlayListDetails(for playlist : Playlist, completion : @escaping ((Result<PlayListDetailsResponse,Error>)->Void)){
        
        createRequest(with: URL(string: Constants.baseAPIURL+"/playlists/"+playlist.id), type: .GET) { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                
                guard let data = data , error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do{
                    let result = try JSONDecoder().decode(PlayListDetailsResponse.self, from: data)
                    
                    //print(result)
                    completion(.success(result))
                }
                catch{
                    print("Somthing went wrong \(error.localizedDescription)")
                    completion(.failure(error))
                }
                
            }
            task.resume()
        }
        
    }
    
    
    
    //MARK: - Profile
    
    public func getCurrentUserProfile(completion : @escaping (Result<UserProfile,Error>) -> Void){
        
        createRequest(with: URL(string: Constants.baseAPIURL + "/me"), type: .GET) { baseRequest in
            
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                
                guard let data = data , error == nil else{
                    
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do{
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    
                    
                    completion(.success(result))
                }
                catch{
                    completion(.failure(error))
                }
                
            }
            
            task.resume()
            
        }
        
    }
    
    //MARK: - Browse
    
    public func getAllNewReleases(completion : @escaping ((Result<NewReleasesResponse,Error>)-> Void)){
        
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/new-releases?limit=50"), type: .GET) { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                
                guard let data = data , error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do{
                    let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                    
                    completion(.success(result))
                }
                catch{
                    completion(.failure(error))
                }
                
            }
            
            task.resume()
        }
        
    }
    
    public func getFeaturedPlayLists(completion : @escaping ((Result<FeaturedPlaylistResponse,Error>)->Void)){
        
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/featured-playlists?limit=20"), type: .GET) { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                
                guard let data = data , error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do{
                    let result = try JSONDecoder().decode(FeaturedPlaylistResponse.self, from: data)
                    completion(.success(result))
                }
                catch{
                    print("failed to get the data")
                    completion(.failure(error))
                }
                
            }
            
            task.resume()
        }
        
    }
    
    public func getRecommendations(genres : Set<String>,completion : @escaping ((Result<RecommendationsResponse,Error>)-> Void)){
        
        let seeds = genres.joined(separator: ",")
        
        createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations?limit=40&seed_genres=\(seeds)"), type: .GET) { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                
                guard let data = data , error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do{
                    let result = try JSONDecoder().decode(RecommendationsResponse.self, from: data)
                    completion(.success(result))
                }
                catch{
                    print("failed to get the data")
                    completion(.failure(error))
                }
                
            }
            
            task.resume()
            
        }
        
    }
    
    public func getRecommendedGenres(completion : @escaping ((Result<RecommendedGenresResponse,Error>)-> Void)){
        createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations/available-genre-seeds"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                
                guard let data = data , error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do{
                    let result = try JSONDecoder().decode(RecommendedGenresResponse.self, from: data)
                    
                    completion(.success(result))
                }
                catch{
                    print("failed to get the data")
                    completion(.failure(error))
                }
                
            }
            
            task.resume()
        }
    }
    
    //MARK:- Categories
    
    public func getCategories(completion : @escaping (Result<[Category],APIError>)-> Void){
        
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/categories?limit=30"), type: .GET) { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                
                guard let data = data , error == nil else{
                    completion(.failure(.failedToGetData))
                    return
                }
                
                do{
                    let result = try JSONDecoder().decode(AllCategoriesResponse.self, from: data)
                
                    //print(result.categories.items)
                    
                    completion(.success(result.categories.items))
                }
                catch{
                    
                    print(error.localizedDescription)
                    
                    completion(.failure(.failedToGetData))
                }
                
            }
            task.resume()
        }
        
    }
    public func getCategoryPlayLists(category : Category, completion : @escaping (Result<[Playlist],APIError>)-> Void){
        
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/categories/\(category.id)/playlists?limit=50"), type: .GET) { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                
                guard let data = data , error == nil else{
                    completion(.failure(.failedToGetData))
                    return
                }
                
                do{
                    let result = try JSONDecoder().decode(CategoryPlaylistResponse.self, from: data)
                        //JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    let playlists = result.playlists.items
                    //print(result)
                    
                    completion(.success(playlists))
                }
                catch{
                    
                    print(error.localizedDescription)
                    
                    completion(.failure(.failedToGetData))
                }
                
            }
            task.resume()
        }
        
    }
    
    //MARK:- Search
    
    public func search(with query : String, completion : @escaping (Result<[String],APIError>)-> Void){
        
        createRequest(with: URL(string: Constants.baseAPIURL+"/search?limit=10&type=album,artist,playlist,track&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"), type: .GET) { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                
                print(request.url?.absoluteString ?? "none")
                
                guard let data = data, error == nil else{
                    completion(.failure(.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(SearchResultResponse.self, from: data)
                        //JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    
                    print(result)
                }
                catch{
                    print(error.localizedDescription)
                    
                    completion(.failure(.failedToGetData))
                }
            }
            
            task.resume()
            
        }
        
    }
    
    
    
    //MARK:- Enums and useful methods
    enum HTTPMethod : String{
        
        case GET
        case POST
        
    }
    
    enum APIError : Error{
        case failedToGetData
    }
    
    private func createRequest(with url : URL?,type : HTTPMethod,completion : @escaping (URLRequest) -> Void) {
        
        AuthManager.shared.withValidToken { token in
            
            guard let apiURL = url else{
                return
            }
            
            //code to be done
            var request = URLRequest(url: apiURL)
            
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            request.httpMethod = type.rawValue
            
            request.timeoutInterval = 30
            
            completion(request)
            
        }
        
        
        
    }
    
}
