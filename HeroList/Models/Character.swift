//
//  Character.swift
//  HeroList
//
//  Created by Jakub Majdl on 08.01.2023.
//

import Foundation

typealias CharacterId = Int

struct Character {
    let id: CharacterId
    let name: String
    let realName: String?
    let publisherName: String
    let deck: String
    let description: String
    let imageURL: URL?
}
