//
//  Credit.swift
//  Mega6Box
//
//  Created by imhs on 4/23/24.
//

import Foundation

// MARK: - 영화에 출연한 사람
struct Credit: Decodable {
    let id: Int
    let cast: [Cast]
}

struct Cast: Decodable {
    let id: Int
    let knownForDepartment: String
    let name: String
    let profilePath: String?
    let character: String
    let job: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case knownForDepartment = "known_for_department"
        case name
        case profilePath = "profile_path"
        case character
        case job
    }
}
