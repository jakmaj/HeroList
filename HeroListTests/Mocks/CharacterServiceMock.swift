//
//  CharacterServiceMock.swift
//  HeroListTests
//
//  Created by Jakub Majdl on 15.01.2023.
//

import Foundation
import RxSwift
@testable import HeroList

class CharacterServiceMock: CharacterService {

    var throwError = false

    func characterList() -> Observable<CharacterList> {
        return Observable.create { observer in
            if self.throwError == true {
                observer.onError(RuntimeError("error"))
            } else {
                observer.onNext(self.listData)
                observer.onCompleted()
            }

            return Disposables.create()
        }
    }

    func characterDetail(characterId: CharacterId) -> Observable<Character> {
        return Observable.create { observer in
            if self.throwError == true {
                observer.onError(RuntimeError("error"))
            } else {
                observer.onNext(self.detailData)
                observer.onCompleted()
            }

            return Disposables.create()
        }
    }

    // MOCK DATA

    let listData = CharacterList(characters: [
        CharacterListItem(id: 0, name: "Deadpool", realName: "Wade Wilson", publisherName: "Marvel", imageURL: nil),
        CharacterListItem(id: 1, name: "Spider-Man", realName: "Peter Parker", publisherName: "Marvel", imageURL: nil),
        CharacterListItem(id: 2, name: "Batman", realName: "Bruce Wayne", publisherName: "DC Comics", imageURL: nil)
    ])

    let detailData = Character(
        id: 0,
        name: "Deadpool",
        realName: "Wade Wilson",
        publisherName: "Marvel",
        deck: "Deadpool is a character appearing in American comic books published by Marvel Comics." +
            "The character was created by Fabian Nicieza and Rob Liefeld, and first appeared in " +
            "New Mutants #98 in December 1990.",
        description: nil,
        imageURL: nil
    )
}
