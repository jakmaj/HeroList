//
//  CoordinatorMock.swift
//  HeroListTests
//
//  Created by Jakub Majdl on 15.01.2023.
//

import Foundation
import UIKit
@testable import HeroList

class CoordinatorMock: Coordinator {

    var parentCoordinator: Coordinator?

    var children: [Coordinator] = []

    var navigationController: UINavigationController

    init() {
        navigationController = UINavigationController()
    }

    func start() {
    }

}
