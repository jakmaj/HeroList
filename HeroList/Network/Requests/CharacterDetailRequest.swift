//
//  CharacterDetailRequest.swift
//  HeroList
//
//  Created by Jakub Majdl on 15.01.2023.
//

import Foundation

struct CharacterDetailRequest: ApiRequest {

    private static var endpointPath = "character/4005-"

    private let characterId: CharacterId

    init(characterId: CharacterId) {
        self.characterId = characterId
    }

    func prepareUrl(_ baseUrl: URL) -> URL {
        var requestUrl = baseUrl
        requestUrl.append(path: "\(Self.endpointPath)\(characterId)")
        return requestUrl
    }

}
