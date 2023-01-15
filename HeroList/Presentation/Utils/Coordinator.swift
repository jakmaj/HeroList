//
//  Coordinator.swift
//  HeroList
//
//  Created by Jakub Majdl on 08.01.2023.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {

    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }

    var navigationController: UINavigationController { get set }

    func start()
    func didFinish()
    func childDidFinish(_ child: Coordinator?)

}

extension Coordinator {

    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }

    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in children.enumerated() where coordinator === child {
            children.remove(at: index)
            break
        }
    }

}
