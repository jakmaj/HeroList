//
//  CharacterListVM.swift
//  HeroList
//
//  Created by Jakub Majdl on 08.01.2023.
//

import Foundation
import RxSwift

protocol CharacterListVMCoordinator: Coordinator {
    func showCharacterDetail(characterId: CharacterId, initialName: String)
}

final class CharacterListVM: ViewModel {

    enum State {
        case normal, loading, error
    }

    @Injected
    var characterService: CharacterService

    fileprivate let stateSubject = PublishSubject<State>()
    fileprivate let reloadTableSubject = PublishSubject<Void>()

    fileprivate var cellVMs: [ReusableViewModel] = []

    init(coordinator: CharacterListVMCoordinator) {
        super.init(coordinator: coordinator)
    }

    fileprivate func loadData() {
        stateSubject.onNext(.loading)
        _ = characterService.characterList()
            .map { $0.characters.map {
                CharacterListItemCellVM(character: $0)
            }}
            .observe(on: MainScheduler.instance)
            .do(onNext: { [weak self] cellVMs in
                self?.cellVMs = cellVMs
                self?.reloadTableSubject.onNext(())
                self?.stateSubject.onNext(.normal)
            })
            .catch { [weak self] error in
                print("Error getting list of characters: \(error)")
                self?.stateSubject.onNext(.error)
                return Observable.empty()
            }
            .subscribe()
    }

}

// Public input
extension Inputs where Base == CharacterListVM {

    func viewDidLoad() { vm.loadData() }
    func reloadData() { vm.loadData() }
    func routeToDetail(characterId: CharacterId, initialName: String) {
        let coordinator = vm.coordinator as? CharacterListVMCoordinator
        coordinator?.showCharacterDetail(characterId: characterId, initialName: initialName)
    }

}

// Public output
extension Outputs where Base == CharacterListVM {

    var cellVMs: [ReusableViewModel] { vm.cellVMs }

}

// Public rx input
extension Reactive where Base == Inputs<CharacterListVM> {

}

// Public rx output
extension Reactive where Base == Outputs<CharacterListVM> {

    var state: Observable<CharacterListVM.State> { base.vm.stateSubject.asObservable() }
    var reloadTable: Observable<Void> { base.vm.reloadTableSubject.asObservable() }

}
