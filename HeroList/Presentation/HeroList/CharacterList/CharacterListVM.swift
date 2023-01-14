//
//  CharacterListVM.swift
//  HeroList
//
//  Created by Jakub Majdl on 08.01.2023.
//

import Foundation
import RxSwift

protocol CharacterListVMDelegate: AnyObject {
    func showCharacterDetail(characterId: CharacterId)
}

final class CharacterListVM: ViewModel {

    @Injected
    var characterService: CharacterService

    weak var delegate: CharacterListVMDelegate?

    fileprivate var cellVMs: [ReusableViewModel] = [
        CharacterListItemCellVM(character: CharacterListItem(id: 20, name: "Deadpool", realName: "Wade Wilson", publisherName: "Marvel", imageURL: nil))
    ]

    init(delegate: CharacterListVMDelegate) {
        self.delegate = delegate
        super.init()
    }

}

// Public input
extension Inputs where Base == CharacterListVM {

}

// Public output
extension Outputs where Base == CharacterListVM {

    var cellVMs: [ReusableViewModel] { vm.cellVMs }

}

// Public rx input
extension Reactive where Base == Inputs<CharacterListVM> {

}

// Public rx output
extension Reactive where Base == Outputs<CharacterListVM> {

}
