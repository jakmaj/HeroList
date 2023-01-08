//
//  CharacterService.swift
//  HeroList
//
//  Created by Jakub Majdl on 08.01.2023.
//

import Foundation

protocol CharacterService {

    func characterList(page: Int, with result: @escaping (Result<CharacterList, Error>) -> Void)
    func characterDetail(characterId: CharacterId, with result: @escaping (Result<Character, Error>) -> Void)

}
