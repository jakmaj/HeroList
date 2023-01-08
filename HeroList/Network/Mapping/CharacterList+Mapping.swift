//
//  CharacterList+Mapping.swift
//  HeroList
//
//  Created by Jakub Majdl on 08.01.2023.
//

import Foundation

extension CharacterList: Decodable {

    private enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case characters = "results"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        page = try container.decode(Int.self, forKey: .page)
        totalPages = try container.decode(Int.self, forKey: .totalPages)
        characters = try container.decode([Character].self, forKey: .characters)
    }
}
