//
//  PlaybackPresenter.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 26/4/21.
//

import Foundation
import UIKit

final class PlaybackPresenter{
    
    static func startPlayback(from viewController : UIViewController , track : AudioTrack){
        let vc = PlayerViewController()
        
        viewController.present(vc, animated: true, completion: nil)
        
    }
    
    static func startPlayback(from viewController : UIViewController , album : Album){
        
    }
    
    static func startPlayback(from viewController : UIViewController , playlist : Playlist){
        
    }
    
}
