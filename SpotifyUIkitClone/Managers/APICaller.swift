//
//  APICaller.swift
//  SpotifyUIkitClone
//
//  Created by Tlanetzi Chavez Madero on 26/03/24.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    struct Constants {
        static let baseURL = "https://api.spotify.com/v1"
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void){
        createRequest(with: URL(string: Constants.baseURL + "/me"), type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest){ data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    //print(result)
                    completion(.success(result))
                }
                catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
                
            }
            task.resume()
        }
    }
    
    public func getNewRealeases(completion: @escaping ((Result<NewReleasesResponse, Error>)) -> Void) {
        createRequest(with: URL(string: Constants.baseURL + "/browse/new-releases?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                    //print(result)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }

    
    public func getFeaturedPlaylists(completion: @escaping ((Result<FeaturedPlaylistResponse, Error>)) -> Void) {
        createRequest(with: URL(string: Constants.baseURL + "/browse/featured-playlists?limit=20"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(FeaturedPlaylistResponse.self, from: data)
                    //print(result)
                    completion(.success(result))
                   
                }
                catch {
                    print(error)
                    completion(.failure(error))
                }
            }
            task.resume()
            
        }
    }
     
    public func getRecommendations(genres: Set<String>, completion: @escaping ((Result<RecommendationsResponse, Error>)) -> Void) {
        let seeds = genres.joined(separator: ",")
        createRequest(with: URL(string: Constants.baseURL + "/recommendations?limit=20&seed_genres=\(seeds)"),
                      type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(RecommendationsResponse.self, from: data)
                   // let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    //print(result)
                    completion(.success(result))
                   
                }
                catch {
                    print(error)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getRecommendedGenres(completion: @escaping ((Result<RecommendedGenresResponse, Error>)) -> Void) {
        createRequest(with: URL(string: Constants.baseURL + "/recommendations/available-genre-seeds"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(RecommendedGenresResponse.self, from: data)
                    //let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    //print(result)
                    completion(.success(result))
                }
                catch {
                    print(error)
                    completion(.failure(error))
                }
            }
            task.resume()
            
        }
    }
    
    // MARK: - PRIVATE
    
    enum HTTPMethod: String{
        case GET
        case POST
    }
    
    private func createRequest(with url: URL?, type: HTTPMethod, completion:  @escaping(URLRequest) -> Void) {
        AuthManager.shared.withValidToken { token in
            guard let apiURL = url else {
                return
            }
            
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
    
}
