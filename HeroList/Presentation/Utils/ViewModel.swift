//
//  ViewModel.swift
//  HeroList
//
//  Created by Jakub Majdl on 11.01.2023.
//

import Foundation
import RxSwift

protocol ViewModelProtocol: AnyObject {

}

class ViewModel: ViewModelProtocol, InputCompatible, OutputCompatible {

    weak var coordinator: Coordinator?

    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

}

class ReusableViewModel: ViewModelProtocol, InputCompatible, OutputCompatible {

    static var reusableIdentifier: String {
        String(describing: self)
    }

}

final class Inputs<Base>: ReactiveCompatible {

    public let vm: Base

    public init(_ vm: Base) {
        self.vm = vm
    }

}

protocol InputCompatible {

    associatedtype InputCompatibleType: ViewModelProtocol

    var `in`: Inputs<InputCompatibleType> { get }

}

extension InputCompatible where Self: ViewModelProtocol {
    var `in`: Inputs<Self> { return Inputs(self) }
}

final class Outputs<Base>: ReactiveCompatible {

    public let vm: Base

    public init(_ vm: Base) {
        self.vm = vm
    }

}

protocol OutputCompatible {

    associatedtype OutputCompatibleType: ViewModelProtocol

    var `out`: Outputs<OutputCompatibleType> { get }

}

extension OutputCompatible where Self: ViewModelProtocol {
    var `out`: Outputs<Self> { return Outputs(self) }
}
