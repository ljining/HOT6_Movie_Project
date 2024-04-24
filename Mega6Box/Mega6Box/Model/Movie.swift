//
//  Movie.swift
//  Mega6Box
//
//  Created by imhs on 4/23/24.
//

import Foundation

struct MovieResults: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let id: Int
    let title: String
    let originalTitle: String
    let overview: String
    let backdropPath: String
    let releaseDate: String
    let posterPath: String
    let genreIds: [Int]

    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case title
        case overview
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date" //개봉일
    }
}


