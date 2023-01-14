//
//  CharacterList.swift
//  HeroList
//
//  Created by Jakub Majdl on 08.01.2023.
//

import Foundation

struct CharacterList {
    let status: Int
    let error: String
    let characters: [CharacterListItem]
}

struct CharacterListItem {
    let id: CharacterId
    let name: String
    let realName: String?
    let publisherName: String
    let imageURL: URL?
}
