//
//  FeaturedPlaylistResponse.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 17/3/21.
//

import Foundation

struct FeaturedPlaylistResponse : Codable{
    let playlists : PlaylistResponse
}

struct PlaylistResponse : Codable{
    
    let items : [Playlist]
}


struct User: Codable{
    let display_name : String
    let external_urls :[String : String]
    let id : String
}
