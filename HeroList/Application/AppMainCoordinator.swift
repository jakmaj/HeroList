//
//  AppMainCoordinator.swift
//  HeroList
//
//  Created by Jakub Majdl on 08.01.2023.
//

import Foundation
import UIKit

final class AppMainCoordinator: NSObject, Coordinator {

    var children: [Coordinator] = []
    weak var parentCoordinator: Coordinator?

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.delegate = self

        let coordinator = CharacterListCoordinator(
            parentCoordinator: self,
            navigationController: navigationController
        )
        coordinator.start()
        children.append(coordinator)
    }

}

extension AppMainCoordinator: UINavigationControllerDelegate {

    func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        guard
            let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(fromViewController),
            let vc = fromViewController as? (any ViewController)
        else {
            return
        }

        (vc.vm as? ViewModel)?.coordinator?.didFinish()
    }

}
