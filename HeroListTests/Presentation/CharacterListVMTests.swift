//
//  CharacterListVMTests.swift
//  HeroListTests
//
//  Created by Jakub Majdl on 15.01.2023.
//

import XCTest
import RxSwift
import RxTest
@testable import HeroList

final class CharacterListVMTests: XCTestCase {

    final class VMCoordinator: CoordinatorMock, CharacterListVMCoordinator {

        var showCharacterDetailCallCount = 0

        func showCharacterDetail(characterId: CharacterId, initialName: String) {
            showCharacterDetailCallCount += 1
        }
    }

    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!

    override func setUp() {
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }

    override func tearDown() {
    }

    func testLoadingData() throws {
        let vm = CharacterListVM(coordinator: VMCoordinator())
        let characterService = CharacterServiceMock()
        vm.characterService = characterService

        let state = scheduler.createObserver(CharacterListVM.State.self)
        let reloadTable = scheduler.createObserver(Void.self)

        vm.out.rx.state
            .bind(to: state)
            .disposed(by: disposeBag)
        vm.out.rx.reloadTable
            .bind(to: reloadTable)
            .disposed(by: disposeBag)

        XCTAssertEqual(vm.out.cellVMs.count, 0)

        vm.in.viewDidLoad()

        XCTAssertEqual(state.events, [
            .next(0, .loading),
            .next(0, .normal)
        ])
        XCTAssertEqual(reloadTable.events.count, 1)
        XCTAssertEqual(vm.out.cellVMs.count, characterService.listData.characters.count)

        for (index, character) in characterService.listData.characters.enumerated() {
            let cellVM = vm.out.cellVMs[index] as? CharacterListItemCellVM

            XCTAssertEqual(cellVM?.out.id, character.id)
            XCTAssertEqual(cellVM?.out.name, character.name)
            XCTAssertEqual(cellVM?.out.realName, character.realName)
            XCTAssertEqual(cellVM?.out.publisherName, character.publisherName)
            XCTAssertEqual(cellVM?.out.imageURL, character.imageURL)
        }
    }

    func testErrorAndReloadingData() throws {
        let characterService = CharacterServiceMock()
        characterService.throwError = true
        let vm = CharacterListVM(coordinator: VMCoordinator())
        vm.characterService = characterService

        let state = scheduler.createObserver(CharacterListVM.State.self)
        let reloadTable = scheduler.createObserver(Void.self)

        vm.out.rx.state
            .bind(to: state)
            .disposed(by: disposeBag)
        vm.out.rx.reloadTable
            .bind(to: reloadTable)
            .disposed(by: disposeBag)

        XCTAssertEqual(vm.out.cellVMs.count, 0)

        vm.in.viewDidLoad()

        XCTAssertEqual(state.events, [
            .next(0, .loading),
            .next(0, .error)
        ])
        XCTAssertEqual(reloadTable.events.count, 0)
        XCTAssertEqual(vm.out.cellVMs.count, 0)

        characterService.throwError = false
        vm.in.reloadData()

        XCTAssertEqual(state.events, [
            .next(0, .loading),
            .next(0, .error),
            .next(0, .loading),
            .next(0, .normal)
        ])
        XCTAssertEqual(reloadTable.events.count, 1)
        XCTAssertEqual(vm.out.cellVMs.count, characterService.listData.characters.count)
    }

    func testRouting() throws {
        let coordinator = VMCoordinator()
        let vm = CharacterListVM(coordinator: coordinator)

        vm.in.routeToDetail(characterId: 0, initialName: "")

        XCTAssertEqual(coordinator.showCharacterDetailCallCount, 1)
    }

}
