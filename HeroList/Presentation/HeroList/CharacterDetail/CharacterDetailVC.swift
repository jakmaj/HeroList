//
//  CharacterDetailVC.swift
//  HeroList
//
//  Created by Jakub Majdl on 08.01.2023.
//

import Foundation
import Kingfisher
import UIKit

final class CharacterDetailVC: BaseViewController, ViewController {

    var vm: CharacterDetailVM!

    @IBOutlet private var realNameLabel: UILabel!
    @IBOutlet private var publisherLabel: UILabel!
    @IBOutlet private var deckLabel: UILabel!
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var descriptionTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = vm.out.initialName ?? "CharacterDetailVCTitlePlaceholder".localized

        setupImage()
        setupDescriptionTextView()
        setupRx()

        vm.in.viewDidLoad()
    }

    private func setupImage() {
        avatarImageView.kf.indicatorType = .activity
    }

    private func setupDescriptionTextView() {
        descriptionTextView.textContainerInset = .zero
        descriptionTextView.textContainer.lineFragmentPadding = 0
    }

    private func setupRx() {
        vm.out.rx.name
            .skip(1)
            .bind(to: rx.title)
            .disposed(by: disposeBag)

        vm.out.rx.realName
            .bind(to: realNameLabel.rx.text)
            .disposed(by: disposeBag)

        vm.out.rx.publisherName
            .bind(to: publisherLabel.rx.text)
            .disposed(by: disposeBag)

        vm.out.rx.deck
            .bind(to: deckLabel.rx.text)
            .disposed(by: disposeBag)

        vm.out.rx.imageURL
            .do(onNext: { [weak self] imageURL in
                self?.avatarImageView.kf.setImage(with: imageURL, placeholder: UIImage(named: "avatarPlaceholder"))
            })
            .subscribe()
            .disposed(by: disposeBag)

        vm.out.rx.description
            .map(\.?.htmlToAttributedString)
            .bind(to: descriptionTextView.rx.attributedText)
            .disposed(by: disposeBag)

        vm.out.rx.state
            .distinctUntilChanged()
            .do(onNext: { [weak self] state in
                self?.updateForState(state)
            })
            .subscribe()
            .disposed(by: disposeBag)

    }

    private func updateForState(_ state: CharacterDetailVM.State) {
        state == .loading ? showLoading() : hideLoading()

        if state == .error {
            showError(message: "CharacterDetailVCErrorMessage".localized) { [weak self] in
                self?.vm.in.reloadData()
            }
        }
    }

}
