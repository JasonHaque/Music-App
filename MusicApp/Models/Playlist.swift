//
//  Playlist.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 1/3/21.
//

import Foundation

struct Playlist: Codable{
    let description : String
    let external_urls :[String : String]
    let id : String
    let images : [APIImage]
    let name : String
    let owner : User
}
