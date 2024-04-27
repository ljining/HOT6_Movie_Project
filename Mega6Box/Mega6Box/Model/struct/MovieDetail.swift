//
//  MovieDetail.swift
//  Mega6Box
//
//  Created by imhs on 4/24/24.
//

import Foundation

struct MovieDetail: Decodable {
    let id: Int
    let title: String
    let overview: String
    let backdropPath: String
    let releaseDate: String
    let genres: [Genres]
    let posterPath: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date" //개봉일
        case genres
        case posterPath = "poster_path"
    }
}

struct Genres: Decodable {
    let id: Int
    let name: String
}
