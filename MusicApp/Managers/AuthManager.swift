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
        //will do later
        
        guard let url = URL(string: Constants.tokenAPIURL) else{
            return
        }
        //oauth stuff
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: "https://m.facebook.com/jason.haque.3"),
        ]
        
        //create a request
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = Constants.clientID+":"+Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else{
            print("Failed to get base 64")
            completion(false)
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            
            guard let data = data , error == nil else{
                print("Error Fetching data using urlsession")
                completion(false)
                return
            }
            
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                print("Success : \(json)")
            }
            catch{
                print("Error Parsing JSON")
                print("Error : \(error.localizedDescription)")
                
            }
            
        }
        
        task.resume()
        
    }
    
    private func cacheToken(){
        
    }
    
    func refreshAccessToken(){
        
    }
}
