//
//  CharacterListCoordinator.swift
//  HeroList
//
//  Created by Jakub Majdl on 08.01.2023.
//

import Foundation
import UIKit

final class CharacterListCoordinator: Coordinator {

    var children: [Coordinator] = []
    weak var parentCoordinator: Coordinator?

    var navigationController: UINavigationController

    init(parentCoordinator: Coordinator, navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }

    func start() {
        let vm = CharacterListVM(coordinator: self)
        let vc = CharacterListVC()
        vc.vm = vm

        navigationController.pushViewController(vc, animated: false)
    }
}

extension CharacterListCoordinator: CharacterListVMCoordinator {

    func showCharacterDetail(characterId: CharacterId, initialName: String) {
        let coordinator = CharacterDetailCoordinator(
            parentCoordinator: self,
            navigationController: navigationController,
            characterId: characterId,
            initialName: initialName
        )

        children.append(coordinator)
        coordinator.start()
    }

}
