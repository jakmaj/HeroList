//
//  ViewController.swift
//  HeroList
//
//  Created by Jakub Majdl on 11.01.2023.
//

import Foundation
import RxSwift
import UIKit

protocol ViewController {

    associatedtype VM = ViewModelProtocol

    var vm: VM! { get set }

}

class BaseViewController: UIViewController {

    let disposeBag = DisposeBag()

    var loadingView: LoadingView?

    func showLoading() {
        if let loadingView {
            loadingView.isHidden = false
            return
        }

        let loadingView = LoadingView()
        view.addSubview(loadingView)
        loadingView.stretchInSuperview()

        self.loadingView = loadingView
    }

    func hideLoading() {
        loadingView?.isHidden = true
    }

    func showError(message: String, dismissable: Bool = true, retryHandler: (() -> Void)? = nil) {
        let alert = UIAlertController(
            title: "Error".localized,
            message: message,
            preferredStyle: .alert
        )

        if dismissable {
            alert.addAction(UIAlertAction(
                title: "Dismiss".localized,
                style: .default
            ))
        }

        if let retryHandler {
            alert.addAction(UIAlertAction(
                title: "Retry".localized,
                style: .default,
                handler: { _ in retryHandler() }
            ))
        }

        present(alert, animated: true)
    }

}
