//
//  UITableView+Register.swift
//  HeroList
//
//  Created by Jakub Majdl on 14.01.2023.
//

import Foundation
import UIKit

extension UITableView {

    func registerCell(_ cell: ConfigurableReusableView.Type) {
        register(nibFromClass(cell), forCellReuseIdentifier: cell.identifier)
    }

    fileprivate func nibFromClass(_ type: ConfigurableReusableView.Type) -> UINib? {
        guard let classType = type as? AnyClass else { return nil }
        guard let name = String(describing: classType).components(separatedBy: ".").last else { return nil }

        return UINib(nibName: name, bundle: Bundle(for: classType))
    }

}
