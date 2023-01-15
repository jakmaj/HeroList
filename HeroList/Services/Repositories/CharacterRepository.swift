//
//  CharacterRepository.swift
//  HeroList
//
//  Created by Jakub Majdl on 08.01.2023.
//

import Foundation
import RxSwift

final class CharacterRepository: CharacterService {

    @Injected
    var apiManager: ApiManager

    func characterList() -> Observable<CharacterList> {
        apiManager.call(request: CharacterListRequest())
    }

    func characterDetail(characterId: CharacterId) -> Observable<Character> {
        apiManager.call(request: CharacterDetailRequest(characterId: characterId))
    }

}
