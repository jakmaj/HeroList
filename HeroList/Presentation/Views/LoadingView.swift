//
//  LoadingView.swift
//  HeroList
//
//  Created by Jakub Majdl on 16.01.2023.
//

import Foundation
import UIKit

final class LoadingView: UIView {

    init() {
        super.init(frame: .zero)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = UIColor.separator

        let modalView = UIView()
        modalView.backgroundColor = UIColor.systemBackground
        modalView.layer.cornerRadius = 5.0
        addSubview(modalView)
        modalView.size(.init(width: 75, height: 75))
        modalView.centerInSuperview()

        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        modalView.addSubview(indicator)
        indicator.centerInSuperview()
    }

}
