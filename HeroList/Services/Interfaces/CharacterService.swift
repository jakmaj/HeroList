//
//  CharacterService.swift
//  HeroList
//
//  Created by Jakub Majdl on 08.01.2023.
//

import Foundation
import RxSwift

protocol CharacterService {

    func characterList() -> Observable<CharacterList>
    func characterDetail(characterId: CharacterId) -> Observable<Character>

}
