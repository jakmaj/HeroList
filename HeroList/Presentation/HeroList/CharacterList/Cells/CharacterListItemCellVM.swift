//
//  CharacterListItemCellVM.swift
//  HeroList
//
//  Created by Jakub Majdl on 08.01.2023.
//

import Foundation

final class CharacterListItemCellVM: ReusableViewModel {

    fileprivate let character: CharacterListItem

    init(character: CharacterListItem) {
        self.character = character
        super.init()
    }

}

// Public output
extension Outputs where Base == CharacterListItemCellVM {

    var name: String { vm.character.name }
    var realName: String? { vm.character.realName }
    var publisherName: String { vm.character.publisherName }
    var imageUrl: URL? { vm.character.imageURL }

}
