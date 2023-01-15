//
//  CharacterListRequest.swift
//  HeroList
//
//  Created by Jakub Majdl on 15.01.2023.
//

import Foundation

struct CharacterListRequest: ApiRequest {

    private static var endpointPath = "characters"

    func prepareUrl(_ baseUrl: URL) -> URL {
        var requestUrl = baseUrl
        requestUrl.append(path: Self.endpointPath)
        return requestUrl
    }

}
