//
//  AppMainCoordinator.swift
//  HeroList
//
//  Created by Jakub Majdl on 08.01.2023.
//

import Foundation
import UIKit

final class AppMainCoordinator: Coordinator {

    var children: [Coordinator] = []

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let coordinator = CharacterListCoordinator(navigationController: navigationController)
        coordinator.start()
        children.append(coordinator)
    }

}
