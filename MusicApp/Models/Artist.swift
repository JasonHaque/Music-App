//
//  Artist.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 1/3/21.
//

import Foundation

struct Artist : Codable{
    let id : String
    let name : String
    let type : String
    let images : [APIImage]?
    let external_urls : [String : String]
}
