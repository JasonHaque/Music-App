//
//  PlaybackPresenter.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 26/4/21.
//

import Foundation
import UIKit

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
    
    public func startPlayback(from viewController : UIViewController , track : AudioTrack){
        self.track = track
        self.tracks = []
        let vc = PlayerViewController()
        vc.title = track.name
        vc.dataSource = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
        
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
        return nil
    }
    
    var subtitle: String? {
        return nil
    }
    
    var imageURL: URL? {
        return nil
    }
    
    
}
