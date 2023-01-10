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
        let viewModel = CharacterListVM(delegate: self)
        let viewController = CharacterListVC.instantiate(with: viewModel)

        navigationController.pushViewController(viewController, animated: false)
        characterListVC = viewController
    }
}
