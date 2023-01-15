//
//  Character+Mapping.swift
//  HeroList
//
//  Created by Jakub Majdl on 08.01.2023.
//

import Foundation

extension Character: Decodable {

    private enum RootKeys: String, CodingKey {
        case status = "status_code"
        case error
        case character = "results"
    }

    private enum CharacterKeys: String, CodingKey {
        case id
        case name
        case realName = "real_name"
        case deck
        case description
        case publisher
        case image
    }

    private enum PublisherKeys: String, CodingKey {
        case name
    }

    private enum ImageKeys: String, CodingKey {
        case screenUrl = "screen_large_url"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)

        let error = try container.decode(String.self, forKey: .error)
        if error != "OK" { throw RuntimeError("Received error from API: \(error)")}
        let status = try container.decode(Int.self, forKey: .status)
        if status != 1 { throw RuntimeError("Received error code from API: \(status)")}

        let characterContainer = try container.nestedContainer(keyedBy: CharacterKeys.self, forKey: .character)

        id = try characterContainer.decode(Int.self, forKey: .id)
        name = try characterContainer.decode(String.self, forKey: .name)
        realName = try? characterContainer.decode(String.self, forKey: .realName)
        deck = try characterContainer.decode(String.self, forKey: .deck)
        description = Self.stripLinkTags(text: try characterContainer.decode(String.self, forKey: .description))

        let publisherContainer = try characterContainer.nestedContainer(keyedBy: PublisherKeys.self, forKey: .publisher)
        publisherName = try publisherContainer.decode(String.self, forKey: .name)

        let imageContainer = try characterContainer.nestedContainer(keyedBy: ImageKeys.self, forKey: .image)
        imageURL = URL(string: try imageContainer.decode(String.self, forKey: .screenUrl))
    }

    fileprivate static func stripLinkTags(text: String) -> String {
        text.replacingOccurrences(
            of: "<(a|\\\\/a)[^>]*>",
            with: "",
            options: .regularExpression,
            range: nil
        )
    }
}
