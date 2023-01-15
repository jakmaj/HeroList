//
//  CharacterDetailVM.swift
//  HeroList
//
//  Created by Jakub Majdl on 08.01.2023.
//

import Foundation
import RxSwift

final class CharacterDetailVM: ViewModel {

    enum State {
        case normal, loading, error
    }

    @Injected
    var characterService: CharacterService

    fileprivate let characterId: CharacterId
    fileprivate let initialName: String

    fileprivate let stateSubject = PublishSubject<State>()
    fileprivate let characterSubject: BehaviorSubject<Character?> = BehaviorSubject(value: nil)

    init(characterId: CharacterId, initialName: String? = nil) {
        self.characterId = characterId
        self.initialName = initialName ?? "Loading..."
        super.init()
    }

    fileprivate func loadData() {
        stateSubject.onNext(.loading)
        _ = characterService.characterDetail(characterId: characterId)
            .observe(on: MainScheduler.instance)
            .do(onNext: { [weak self] character in
                self?.characterSubject.onNext(character)
                self?.stateSubject.onNext(.normal)
            })
            .catch { [weak self] error in
                print("Error getting detail of character \(self?.characterId ?? -1): \(error)")
                self?.stateSubject.onNext(.error)
                return Observable.empty()
            }
            .subscribe()
    }

}

// Public input
extension Inputs where Base == CharacterDetailVM {

    func viewDidLoad() { vm.loadData() }
    func reloadData() { vm.loadData() }

}

// Public output
extension Outputs where Base == CharacterDetailVM {

    var initialName: String { vm.initialName }

}

// Public rx input
extension Reactive where Base == Inputs<CharacterDetailVM> {

}

// Public rx output
extension Reactive where Base == Outputs<CharacterDetailVM> {

    var name: Observable<String?> { base.vm.characterSubject.map(\.?.name) }
    var realName: Observable<String?> { base.vm.characterSubject.map(\.?.realName) }
    var publisherName: Observable<String?> { base.vm.characterSubject.map(\.?.publisherName) }
    var deck: Observable<String?> { base.vm.characterSubject.map(\.?.deck) }
    var description: Observable<String?> { base.vm.characterSubject.map(\.?.description) }
    var imageURL: Observable<URL?> { base.vm.characterSubject.map(\.?.imageURL) }

    var state: Observable<CharacterDetailVM.State> { base.vm.stateSubject.asObservable() }

}
