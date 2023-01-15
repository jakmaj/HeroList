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

    @IBOutlet private var errorView: UIView!
    @IBOutlet private var errorLabel: UILabel!
    @IBOutlet private var errorButton: UIButton!

    @IBOutlet private var loadingView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = vm.out.initialName ?? "CharacterDetailVCTitlePlaceholder".localized

        setupImage()
        setupDescriptionTextView()
        setupErrorView()
        setupLoadingView()
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

    private func setupErrorView() {
        errorView.layer.cornerRadius = 5
        errorLabel.text = "CharacterDetailVCErrorMessage".localized
        errorButton.setTitle("Retry".localized, for: .normal)
    }

    private func setupLoadingView() {
        loadingView.layer.cornerRadius = 5
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

        errorButton.rx.tap
            .do(onNext: { [weak self] in
                self?.vm.in.reloadData()
        })
        .subscribe()
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
        errorView.isHidden = state != .error
        loadingView.isHidden = state != .loading
    }

}
