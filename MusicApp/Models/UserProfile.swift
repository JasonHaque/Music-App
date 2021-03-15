//
//  UserProfile.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 1/3/21.
//

import Foundation

struct UserProfile{
    
    let country : String
    let display_name : String
    let email : String
    let explicit_content : [String : Int]
    let external_urls : [String : String]
    let followers : [String : Codable?]
    let id : String
    let product : String
    let images : [UserImage]
}

struct UserImage :Codable {
    let url : String
}





