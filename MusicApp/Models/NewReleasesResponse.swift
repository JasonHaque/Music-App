//
//  NewReleasesResponse.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 16/3/21.
//

import Foundation

struct NewReleasesResponse : Codable{
    let albums : AlbumResponse
}

struct AlbumResponse : Codable{
    let items : [Album]
}

struct Album: Codable{
    let album_type : String
    let available_markets : [String]
    let id : String
}
