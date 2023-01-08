//
//  Coordinator.swift
//  HeroList
//
//  Created by Jakub Majdl on 08.01.2023.
//

import Foundation

protocol Coordinator {

    var children: [Coordinator] { get set }

    func start()
}
