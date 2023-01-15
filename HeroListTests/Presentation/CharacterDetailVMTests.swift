//
//  CharacterDetailVMTests.swift
//  HeroListTests
//
//  Created by Jakub Majdl on 15.01.2023.
//

import XCTest
import RxSwift
import RxTest
@testable import HeroList

final class CharacterDetailVMTests: XCTestCase {

    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!

    override func setUp() {
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }

    override func tearDown() {
    }

    func testLoadingData() throws {
        let initialName = "initialName"
        let vm = CharacterDetailVM(coordinator: CoordinatorMock(), characterId: 0, initialName: initialName)
        let characterService = CharacterServiceMock()
        vm.characterService = characterService

        XCTAssertEqual(vm.out.initialName, initialName)

        let state = scheduler.createObserver(CharacterDetailVM.State.self)
        let name = scheduler.createObserver(Optional<String>.self)
        let realName = scheduler.createObserver(Optional<String>.self)
        let publisherName = scheduler.createObserver(Optional<String>.self)
        let deck = scheduler.createObserver(Optional<String>.self)
        let description = scheduler.createObserver(Optional<String>.self)
        let imageURL = scheduler.createObserver(Optional<URL>.self)

        vm.out.rx.state.bind(to: state).disposed(by: disposeBag)
        vm.out.rx.name.bind(to: name).disposed(by: disposeBag)
        vm.out.rx.realName.bind(to: realName).disposed(by: disposeBag)
        vm.out.rx.publisherName.bind(to: publisherName).disposed(by: disposeBag)
        vm.out.rx.deck.bind(to: deck).disposed(by: disposeBag)
        vm.out.rx.description.bind(to: description).disposed(by: disposeBag)
        vm.out.rx.imageURL.bind(to: imageURL).disposed(by: disposeBag)

        vm.in.viewDidLoad()

        XCTAssertEqual(state.events, [.next(0, .loading), .next(0, .normal)])
        XCTAssertEqual(name.events, [.next(0, nil), .next(0, characterService.detailData.name)])
        XCTAssertEqual(realName.events, [.next(0, nil), .next(0, characterService.detailData.realName)])
        XCTAssertEqual(publisherName.events, [.next(0, nil), .next(0, characterService.detailData.publisherName)])
        XCTAssertEqual(deck.events, [.next(0, nil), .next(0, characterService.detailData.deck)])
        XCTAssertEqual(description.events, [.next(0, nil), .next(0, characterService.detailData.description)])
        XCTAssertEqual(imageURL.events, [.next(0, nil), .next(0, characterService.detailData.imageURL)])
    }

    func testErrorAndReloadingData() throws {
        let vm = CharacterDetailVM(coordinator: CoordinatorMock(), characterId: 0)
        let characterService = CharacterServiceMock()
        characterService.throwError = true
        vm.characterService = characterService

        XCTAssertEqual(vm.out.initialName, nil)

        let state = scheduler.createObserver(CharacterDetailVM.State.self)
        let name = scheduler.createObserver(Optional<String>.self)
        let realName = scheduler.createObserver(Optional<String>.self)
        let publisherName = scheduler.createObserver(Optional<String>.self)
        let deck = scheduler.createObserver(Optional<String>.self)
        let description = scheduler.createObserver(Optional<String>.self)
        let imageURL = scheduler.createObserver(Optional<URL>.self)

        vm.out.rx.state.bind(to: state).disposed(by: disposeBag)
        vm.out.rx.name.bind(to: name).disposed(by: disposeBag)
        vm.out.rx.realName.bind(to: realName).disposed(by: disposeBag)
        vm.out.rx.publisherName.bind(to: publisherName).disposed(by: disposeBag)
        vm.out.rx.deck.bind(to: deck).disposed(by: disposeBag)
        vm.out.rx.description.bind(to: description).disposed(by: disposeBag)
        vm.out.rx.imageURL.bind(to: imageURL).disposed(by: disposeBag)

        vm.in.viewDidLoad()

        XCTAssertEqual(state.events, [.next(0, .loading), .next(0, .error)])
        XCTAssertEqual(name.events, [.next(0, nil)])
        XCTAssertEqual(realName.events, [.next(0, nil)])
        XCTAssertEqual(publisherName.events, [.next(0, nil)])
        XCTAssertEqual(deck.events, [.next(0, nil)])
        XCTAssertEqual(description.events, [.next(0, nil)])
        XCTAssertEqual(imageURL.events, [.next(0, nil)])

        characterService.throwError = false
        vm.in.reloadData()

        XCTAssertEqual(state.events, [.next(0, .loading), .next(0, .error), .next(0, .loading), .next(0, .normal)])
        XCTAssertEqual(name.events, [.next(0, nil), .next(0, characterService.detailData.name)])
        XCTAssertEqual(realName.events, [.next(0, nil), .next(0, characterService.detailData.realName)])
        XCTAssertEqual(publisherName.events, [.next(0, nil), .next(0, characterService.detailData.publisherName)])
        XCTAssertEqual(deck.events, [.next(0, nil), .next(0, characterService.detailData.deck)])
        XCTAssertEqual(description.events, [.next(0, nil), .next(0, characterService.detailData.description)])
        XCTAssertEqual(imageURL.events, [.next(0, nil), .next(0, characterService.detailData.imageURL)])
    }

}
