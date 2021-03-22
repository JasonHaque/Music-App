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
