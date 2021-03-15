//
//  SettingsModels.swift
//  MusicApp
//
//  Created by Sanviraj Zahin Haque on 15/3/21.
//

import Foundation

struct Section{
    let title : String
    let options : [Option]
}

struct Option {
    let title : String
    let handler : ()-> Void
}
