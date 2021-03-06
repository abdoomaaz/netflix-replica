//
//  Movie.swift
//  Netflix
//
//  Created by AbdooMaaz's playground on 30.04.22.
//

import Foundation

struct TrendingShowResponse: Codable {
    let results: [Show]
}

struct Show: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}
