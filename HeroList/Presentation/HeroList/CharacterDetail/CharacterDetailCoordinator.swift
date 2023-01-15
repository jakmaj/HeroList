//
//  CharacterDetailCoordinator.swift
//  HeroList
//
//  Created by Jakub Majdl on 08.01.2023.
//

import Foundation
import UIKit

final class CharacterDetailCoordinator: Coordinator {

    var children: [Coordinator] = []
    weak var parentCoordinator: Coordinator?

    var navigationController: UINavigationController

    private let characterId: CharacterId
    private let initialName: String?

    init(
        parentCoordinator: Coordinator,
        navigationController: UINavigationController,
        characterId: CharacterId,
        initialName: String? = nil
    ) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.characterId = characterId
        self.initialName = initialName
    }

    func start() {
        let vm = CharacterDetailVM(coordinator: self, characterId: characterId, initialName: initialName)
        let vc = CharacterDetailVC()
        vc.vm = vm

        navigationController.pushViewController(vc, animated: false)
    }
}
