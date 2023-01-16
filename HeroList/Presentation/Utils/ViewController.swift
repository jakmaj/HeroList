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

}
