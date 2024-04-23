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
  let overview: String
  let backdropPath: String
  let releaseDate: String
    
  enum CodingKeys: String, CodingKey {
    case id
    case title
    case overview
    case backdropPath = "backdrop_path"
    case releaseDate = "release_date"
  }
}
