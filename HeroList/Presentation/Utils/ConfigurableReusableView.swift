//
//  ConfigurableReusableView.swift
//  HeroList
//
//  Created by Jakub Majdl on 14.01.2023.
//

import Foundation

protocol ConfigurableReusableView {
    static var identifier: String { get }

    func set(vm: ReusableViewModel)
    func configure()
}
