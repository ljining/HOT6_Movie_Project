//
//  Movie.swift
//  Mega6Box
//
//  Created by imhs on 4/23/24.
//

import Foundation

struct Movie: Decodable {
    let originalTitle: String
    let title: String
    let overview: String
    let releaseDate: String
    let posterPath: String
    let genreIds: [Int]

    enum CodingKeys: String, CodingKey {
        case originalTitle = "original_title"
        case title         
        case overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
    }
}
