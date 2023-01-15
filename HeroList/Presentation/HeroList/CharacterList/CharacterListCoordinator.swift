//
//  CharacterListCoordinator.swift
//  HeroList
//
//  Created by Jakub Majdl on 08.01.2023.
//

import Foundation
import UIKit

class CharacterListCoordinator: Coordinator {

    var children: [Coordinator] = []
    var navigationController: UINavigationController

    private weak var characterListVC: CharacterListVC?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vm = CharacterListVM(delegate: self)
        let vc = CharacterListVC(vm: vm, nibName: nil)

        navigationController.pushViewController(vc, animated: false)
        characterListVC = vc
    }
}

extension CharacterListCoordinator: CharacterListVMDelegate {

    func showCharacterDetail(characterId: CharacterId, initialName: String) {
        let coordinator = CharacterDetailCoordinator(
            navigationController: navigationController,
            characterId: characterId,
            initialName: initialName
        )

        children.append(coordinator)
        coordinator.start()
    }

}
