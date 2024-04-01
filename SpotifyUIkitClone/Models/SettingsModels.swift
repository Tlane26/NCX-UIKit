//
//  SettingsModels.swift
//  SpotifyUIkitClone
//
//  Created by Tlanetzi Chavez Madero on 27/03/24.
//

import Foundation


struct Section {
    let title: String
    let options: [Option]
    
}

struct Option {
    let title: String
    let handler: () -> Void
    
}


