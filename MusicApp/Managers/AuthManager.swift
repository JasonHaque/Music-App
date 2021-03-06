//
//  AuthManager.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 1/3/21.
//

import Foundation

final class AuthManager{
    
    static let shared = AuthManager()
    
    struct Constants{
        static let clientID = "42157579101c4d5ba3cd04ef455e46b0"
        static let clientSecret = "6ea5624768cf41a0b02aa3753b67d8be"
        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
    }
    
    private init(){}
    
    public var signInURL : URL? {
        let base = "https://accounts.spotify.com/authorize"
        let scopes = "user-read-private"
        let redirectURI = "https://m.facebook.com/jason.haque.3"
        let string = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(scopes)&redirect_uri=\(redirectURI)&show_dialog=TRUE"
        
        return URL(string: string)
    }
    
    var isSignedIn : Bool {
        return false
    }
    
    private var accessToken : String? {
        return nil
    }
    
    private var refreshToken : String? {
        return nil
    }
    
    private var tokenExpirationDate : Date?{
        return nil
    }
    
    private var shouldRefreshToken : Bool {
        return false
    }
    
    public func exchangeCodeForToken(code : String, completion : @escaping ((Bool)-> Void)){
        guard let url = URL(string: Constants.tokenAPIURL) else{
            return
        }
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data , error == nil else{
                completion(false)
                return
            }
            
        }
        
        task.resume()
        
    }
    
    private func cacheToken(){
        
    }
    
    func refreshAccessToken(){
        
    }
}
