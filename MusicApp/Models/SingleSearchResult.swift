//
//  SingleSearchResult.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 25/4/21.
//

import Foundation

enum SingleSearchResult {
    case album(model : Album)
    case artist(model : Artist)
    case track(model : AudioTrack)
    case playlist(model : Playlist)
}
