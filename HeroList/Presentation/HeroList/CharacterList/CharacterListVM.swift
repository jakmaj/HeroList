//
//  CharacterListVM.swift
//  HeroList
//
//  Created by Jakub Majdl on 08.01.2023.
//

import Foundation
import RxSwift

protocol CharacterListVMDelegate: AnyObject {
    func showCharacterDetail(characterId: CharacterId)
}

enum CharacterListVMState {
    case normal, loading, error
}

final class CharacterListVM: ViewModel {

    @Injected
    var characterService: CharacterService

    weak var delegate: CharacterListVMDelegate?

    fileprivate let stateSubject = PublishSubject<CharacterListVMState>()
    fileprivate let reloadTableSubject = PublishSubject<Void>()

    fileprivate var cellVMs: [ReusableViewModel] = []

    init(delegate: CharacterListVMDelegate) {
        self.delegate = delegate
        super.init()
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
            .do(onError: { [weak self] error in
                print("Error getting list of characters: \(error)")
                self?.stateSubject.onNext(.error)
            })
            .subscribe()
    }

}

// Public input
extension Inputs where Base == CharacterListVM {

    func viewDidLoad() { vm.loadData() }
    func reloadData() { vm.loadData() }

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

    var state: Observable<CharacterListVMState> { base.vm.stateSubject.asObservable() }
    var reloadTable: Observable<Void> { base.vm.reloadTableSubject.asObservable() }

}
