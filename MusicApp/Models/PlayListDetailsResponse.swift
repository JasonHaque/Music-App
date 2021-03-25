//
//  PlayListDetailsResponse.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 26/3/21.
//

import Foundation

struct PlayListDetailsResponse : Codable{
    let description : String
    let external_urls : [String : String]
    let id : String
    let images : [APIImage]
    let name : String
    let tracks : PlaylistTrackResponse
}


struct PlaylistTrackResponse : Codable{
    let items : [PlaylistItem]
}

struct PlaylistItem : Codable{
    let track : AudioTrack
}
