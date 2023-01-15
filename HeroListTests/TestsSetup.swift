//
//  TestsSetup.swift
//  HeroListTests
//
//  Created by Jakub Majdl on 15.01.2023.
//

import Foundation
@testable import HeroList

class TestsSetup: NSObject {

    override init() {
        AppDIContainer.setupRegistrations()
    }

}
