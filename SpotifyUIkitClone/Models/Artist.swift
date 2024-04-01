//
//  Artist.swift
//  SpotifyUIkitClone
//
//  Created by Tlanetzi Chavez Madero on 26/03/24.
//

import Foundation

struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let external_urls: [String: String]
}
