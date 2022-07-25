//
//  APICaller.swift
//  Netflix
//
//  Created by Omar Tharwat on 7/16/22.
//  Copyright © 2022 Omar Tharwat. All rights reserved.
//

import Foundation

struct Constants {
    static let API_KEY = "44d30970814f771ba92bf40b7706228a"
    static let baseURL = "https://api.themoviedb.org"
    static let YoutubeAPI_KEY = "AIzaSyBx5A01jrGlCIP-ptL7rJaJks7SARqHtE4"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum APIError : Error {
    case failedTogetData
}

class APICaller {
    
    static let shared = APICaller()
    
    
    func getTrendingMovies(completion : @escaping (Result<[Title],Error>) ->Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else{return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, _, error) in
            guard let data = data , error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getTrendingTvs(completion : @escaping (Result<[Title],Error>) ->Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else{return}
       let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, _, error) in
            guard let data = data , error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))

            }catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getUpComingMovies(completion : @escaping (Result<[Title],Error>) ->Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else{return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, _, error) in
                 guard let data = data , error == nil else {
                     return
                 }
                 do {
                     let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                     completion(.success(results.results))

                 }catch{
                     completion(.failure(APIError.failedTogetData))
                 }
             }
        task.resume()
    }
    
    func getPopular(completion : @escaping (Result<[Title],Error>) ->Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else{return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, _, error) in
                     guard let data = data , error == nil else {
                         return
                     }
                     do {
                         let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                         completion(.success(results.results))

                     }catch{
                         completion(.failure(APIError.failedTogetData))
                     }
                 }
            task.resume()
    }
    //https://api.themoviedb.org/3/movie/top_rated?api_key=<<api_key>>&language=en-US&page=1
    func getTopRated(completion : @escaping (Result<[Title],Error>) ->Void) {
        guard let url = URL(string:"\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else{return}
             let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, _, error) in
                          guard let data = data , error == nil else {
                              return
                          }
                          do {
                              let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                              completion(.success(results.results))

                          }catch{
                              completion(.failure(APIError.failedTogetData))
                          }
                      }
                 task.resume()
    }
    
    func getDiscoverMovies(completion : @escaping (Result<[Title],Error>) ->Void){
        guard let url = URL(string:"\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else{return}
                    let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, _, error) in
                                 guard let data = data , error == nil else {
                                     return
                                 }
                                 do {
                                     let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                                     completion(.success(results.results))

                                 }catch{
                                     completion(.failure(APIError.failedTogetData))
                                 }
                             }
                        task.resume()
    }
    
    func search(with query: String,completion : @escaping (Result<[Title],Error>) ->Void){
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        
        
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else{return}
                    let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, _, error) in
                                 guard let data = data , error == nil else {
                                     return
                                 }
                                 do {
                                     let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                                     completion(.success(results.results))

                                 }catch{
                                     completion(.failure(APIError.failedTogetData))
                                 }
                             }
                        task.resume()
    }
    
    func getMovie(with query : String,completion : @escaping (Result<VideoElement,Error>) ->Void){
          guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.YoutubeBaseURL)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, _, error) in
                                        guard let data = data , error == nil else {
                                            return
                                        }
                                        do {
                                            let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                                            completion(.success(results.items[0]))

                                        }catch{
                                            completion(.failure(error))
                                            print(error.localizedDescription)
                                        }
                                    }
                               task.resume()
        
    }
    
}
