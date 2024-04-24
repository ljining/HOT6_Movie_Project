//
//  PersonImage.swift
//  Mega6Box
//
//  Created by imhs on 4/23/24.
//

import Foundation

// MARK: - 사람 이미지
struct PersonImage: Decodable {
    let id: Int
    let profiles: [profiles]
}

struct profiles: Decodable {
    let filePath: String
    let height: Int
    let width: Int
    
    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
        case height
        case width
    }
}
