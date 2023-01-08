//
//  CharacterRepository.swift
//  HeroList
//
//  Created by Jakub Majdl on 08.01.2023.
//

import Foundation

final class CharacterRepository: CharacterService {

    func characterList(page: Int, with result: @escaping (Result<CharacterList, Error>) -> Void) {
        //TODO: implement
    }

    func characterDetail(characterId: CharacterId, with result: @escaping (Result<Character, Error>) -> Void) {
        //TODO: implement
    }

}
