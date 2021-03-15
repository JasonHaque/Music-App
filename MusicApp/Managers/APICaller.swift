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
        AuthManager.shared.withValidToken { token in
            
            //code to be done
            
        }
    }
    
}
