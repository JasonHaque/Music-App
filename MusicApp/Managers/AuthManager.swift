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
    }
    
    private init(){}
    
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
}
