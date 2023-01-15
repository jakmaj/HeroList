//
//  CharacterDetailCoordinator.swift
//  HeroList
//
//  Created by Jakub Majdl on 08.01.2023.
//

import Foundation
import UIKit

class CharacterDetailCoordinator: Coordinator {

    var children: [Coordinator] = []
    var navigationController: UINavigationController

    private let characterId: CharacterId
    private let initialName: String?

    private weak var characterDetailVC: CharacterDetailVC?

    init(
        navigationController: UINavigationController,
        characterId: CharacterId,
        initialName: String? = nil
    ) {
        self.navigationController = navigationController
        self.characterId = characterId
        self.initialName = initialName
    }

    func start() {
        let vm = CharacterDetailVM(characterId: characterId, initialName: initialName)
        let vc = CharacterDetailVC(vm: vm, nibName: nil)

        navigationController.pushViewController(vc, animated: false)
        characterDetailVC = vc
    }
}
