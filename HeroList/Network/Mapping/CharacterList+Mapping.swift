//
//  CharacterList+Mapping.swift
//  HeroList
//
//  Created by Jakub Majdl on 08.01.2023.
//

import Foundation

extension CharacterList: Decodable {

    private enum CodingKeys: String, CodingKey {
        case status = "status_code"
        case error
        case characters = "results"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        status = try container.decode(Int.self, forKey: .status)
        error = try container.decode(String.self, forKey: .error)
        characters = try container.decode([CharacterListItem].self, forKey: .characters)
    }
}

extension CharacterListItem: Decodable {

    private enum RootKeys: String, CodingKey {
        case id
        case name
        case realName = "real_name"
        case publisher
        case image
    }

    private enum PublisherKeys: String, CodingKey {
        case name
    }

    private enum ImageKeys: String, CodingKey {
        case iconUrl = "icon_url"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        realName = try container.decode(String.self, forKey: .realName)

        let publisherContainer = try container.nestedContainer(keyedBy: PublisherKeys.self, forKey: .publisher)
        publisherName = try publisherContainer.decode(String.self, forKey: .name)

        let imageContainer = try container.nestedContainer(keyedBy: ImageKeys.self, forKey: .image)
        imageURL = URL(string: try imageContainer.decode(String.self, forKey: .iconUrl))
    }
}
