//
//  MovieAPICaller.swift
//  Netflix
//
//  Created by AbdooMaaz's playground on 30.04.22.
//

import Foundation

struct Constants {
    static let TMDB_API_KEY = Bundle.main.infoDictionary?["TMDB_API_KEY"] as? String
    static let baseURL = "https://api.themoviedb.org"
}

// TODO: Create a function that save the reduntant work of each function
class TmdbApiCaller {
    static let shared = TmdbApiCaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Show], Error>) -> Void) {
        guard let apikey = Constants.TMDB_API_KEY else {return}
        let urlString = "\(Constants.baseURL)/3/trending/movie/day?api_key=\(apikey)"
        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let responseData = data, error == nil else{return}
            
            do {
                let results = try JSONDecoder().decode(TrendingShowResponse.self, from: responseData)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Show], Error>) -> Void) {
        guard let apikey = Constants.TMDB_API_KEY else {return}
        let urlString = "\(Constants.baseURL)/3/movie/upcoming?api_key=\(apikey)&language=en-US&page=1"
        print(urlString)
        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let responseData = data, error == nil else{return}
            
            do {
                let results = try JSONDecoder().decode(TrendingShowResponse.self, from: responseData)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getPopularMovies(completion: @escaping (Result<[Show], Error>) -> Void) {
        guard let apikey = Constants.TMDB_API_KEY else {return}
        let urlString = "\(Constants.baseURL)/3/movie/popular?api_key=\(apikey)&language=en-US&page=1"
        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let responseData = data, error == nil else{return}
            
            do {
                let results = try JSONDecoder().decode(TrendingShowResponse.self, from: responseData)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getTopRatedMovies(completion: @escaping (Result<[Show], Error>) -> Void) {
        guard let apikey = Constants.TMDB_API_KEY else {return}
        let urlString = "\(Constants.baseURL)/3/movie/top_rated?api_key=\(apikey)&language=en-US&page=1"
        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let responseData = data, error == nil else{return}
            
            do {
                let results = try JSONDecoder().decode(TrendingShowResponse.self, from: responseData)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getTrendingTv(completion: @escaping (Result<[Show], Error>) -> Void) {
        guard let apikey = Constants.TMDB_API_KEY else {return}
        let urlString = "\(Constants.baseURL)/3/trending/tv/day?api_key=\(apikey)"
        guard let url  = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let responseData = data else {return}
            
            do {
                let trendingTv = try JSONDecoder().decode(TrendingShowResponse.self, from: responseData)
                completion(.success(trendingTv.results))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
