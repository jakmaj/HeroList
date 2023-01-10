//
//  CharacterRepository.swift
//  HeroList
//
//  Created by Jakub Majdl on 08.01.2023.
//

import Foundation
import RxSwift

//TODO: unify having protocol and implementation in one file or in separate
final class CharacterRepository: CharacterService {

    @Injected
    var apiManager: ApiManager

    func characterList() -> Observable<CharacterList> {
        apiManager.characterList()
    }

    func characterDetail(characterId: CharacterId) -> Observable<Character> {
        apiManager.characterDetail(characterId: characterId)
    }

}
