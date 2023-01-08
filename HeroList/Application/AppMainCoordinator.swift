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
    private let appDIContainer: AppDIContainer

    init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        let coordinator = CharacterListCoordinator(navigationController: navigationController)
        coordinator.start()
        children.append(coordinator)
    }

}
