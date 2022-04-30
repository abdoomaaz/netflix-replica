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

class MovieApiCaller {
    static let shared = MovieApiCaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let apikey = Constants.TMDB_API_KEY else{return}
        let urlString = "\(Constants.baseURL)/3/trending/all/day?api_key=\(apikey)"
        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{return}
            
            do {
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
