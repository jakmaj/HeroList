//
//  RuntimeError.swift
//  HeroList
//
//  Created by Jakub Majdl on 09.01.2023.
//

import Foundation

struct RuntimeError: Error {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    public var localizedDescription: String {
        return message
    }
}
