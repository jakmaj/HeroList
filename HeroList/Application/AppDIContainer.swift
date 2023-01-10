//
//  AppDIContainer.swift
//  HeroList
//
//  Created by Jakub Majdl on 08.01.2023.
//

import Foundation
import Swinject

// TODO: figure out better solution for testability

final class AppDIContainer {

    private static let container = Container(defaultObjectScope: .container)

    static func setupRegistrations() {
        container.register(AppConfiguration.self, factory: { _ in AppConfigurationImpl() })
        container.register(ApiManager.self, factory: { _ in ApiManagerImpl() })
        container.register(CharacterService.self, factory: { _ in CharacterRepository() })
    }

    static func get<T>() -> T? {
        return container.resolve(T.self)
    }

}

@propertyWrapper
struct Injected<T> {

    var dependency: T

    init() {
        self.dependency = AppDIContainer.get()!
    }

    public var wrappedValue: T {
        get { return dependency}
        mutating set { dependency = newValue }
    }

}
