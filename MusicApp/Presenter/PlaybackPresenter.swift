//
//  PlaybackPresenter.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 26/4/21.
//

import Foundation
import UIKit
import AVFoundation

protocol PlayerDataSource : AnyObject{
    var songName : String? {get}
    var subtitle : String? {get}
    var imageURL : URL? {get}
}

final class PlaybackPresenter{
    
    static let shared = PlaybackPresenter()
    private var track : AudioTrack?
    private var tracks = [AudioTrack]()
    
    var currentTrack : AudioTrack?{
        if let track = track , tracks.isEmpty{
            return track
        }
        else if !tracks.isEmpty{
            return tracks.first
        }
        
        return nil
    }
    
    var player : AVPlayer?
    
    public func startPlayback(from viewController : UIViewController , track : AudioTrack){
        
        guard let url = URL(string : track.preview_url ?? "") else{
            return
        }
        
        player = AVPlayer(url: url)
        player?.volume = 0.5
        self.track = track
        self.tracks = []
        let vc = PlayerViewController()
        vc.title = track.name
        vc.dataSource = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true){ [weak self]  in
            
            self?.player?.play()
            
        }
        
    }
    
    public func startPlayback(from viewController : UIViewController , tracks : [AudioTrack]){
        
        self.tracks = tracks
        self.track = nil
        let vc = PlayerViewController()
        
        viewController.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    
    
}

extension PlaybackPresenter : PlayerDataSource {
    var songName: String? {
        return currentTrack?.name
    }
    
    var subtitle: String? {
        return currentTrack?.artists.first?.name
    }
    
    var imageURL: URL? {
        return URL(string :currentTrack?.album?.images.first?.url ?? "")
    }
    
    
}
