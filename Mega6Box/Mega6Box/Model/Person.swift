//
//  Person.swift
//  Mega6Box
//
//  Created by imhs on 4/23/24.
//

import Foundation

// MARK: - 배우 ID로 배우 검색, 영화를 만든 사람들
struct PersonResults: Decodable {
    let results: [Person]
}

struct Person: Decodable {
    let id: Int
    let name: String
    let profilePath: String?
    let knownFor: [KnownFor]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
        case knownFor = "known_for"
    }
}

struct KnownFor: Decodable {
    let backdropPath: String
    let id: Int
    let originalTitle: String?
    let overview: String
    let title: String?
    let posterPath: String
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case originalTitle = "original_title"
        case overview
        case title
        case posterPath = "poster_path"
    }
}
