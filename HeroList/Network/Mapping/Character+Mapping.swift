//
//  Character+Mapping.swift
//  HeroList
//
//  Created by Jakub Majdl on 08.01.2023.
//

import Foundation

extension Character: Decodable {

    private enum CodingKeys: String, CodingKey {
        case id
        case name
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }
}
