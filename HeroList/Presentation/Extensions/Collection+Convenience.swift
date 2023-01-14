//
//  Collection+Convenience.swift
//  HeroList
//
//  Created by Jakub Majdl on 14.01.2023.
//

import Foundation

public extension Collection {

    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }

}
