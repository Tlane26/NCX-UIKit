//
//  FeaturedPlaylistResponse.swift
//  SpotifyUIkitClone
//
//  Created by Tlanetzi Chavez Madero on 01/04/24.
//

import Foundation

struct FeaturedPlaylistResponse: Codable {
    let playlists: PlaylistResponse
}

struct PlaylistResponse: Codable {
    let items: [Playlist]
}

struct User: Codable {
    let display_name: String
    let external_urls: [String: String]
    let id: String
}
