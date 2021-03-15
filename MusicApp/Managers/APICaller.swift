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
    
    public func getCurrentUserProfile(completion : @escaping (Result<UserProfile,Error>) -> Void){
        
        createRequest(with: URL(string: ""), type: .GET) { baseRequest in
            
        }
        
    }
    
    enum HTTPMethod : String{
        
        case GET
        case POST
        
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
