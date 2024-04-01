//
//  Playlist.swift
//  SpotifyUIkitClone
//
//  Created by Tlanetzi Chavez Madero on 26/03/24.
//

import Foundation

struct Playlist: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
}
