//
//  Person.swift
//  Mega6Box
//
//  Created by imhs on 4/23/24.
//

import Foundation

// MARK: - 영화를 만든 사람들
struct PersonResults: Decodable {
    let results: [Person]
}

struct Person: Decodable {
    let id: Int
    let name: String
    let profilePath: String
    let knownFor: [KnownFor]
}

struct KnownFor: Decodable {
    let backdropPath: String
    let id: Int
    let originalTitle: String
    let overView: String
    let posterPath: String
    
    enum CodingKeys: String, CodingKey {
        case backdropPath
        case id
        case originalTitle = "original_title"
        case overView
        case posterPath = "poster_path"
    }
}
