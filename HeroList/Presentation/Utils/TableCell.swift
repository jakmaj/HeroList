//
//  TableCell.swift
//  HeroList
//
//  Created by Jakub Majdl on 14.01.2023.
//

import Foundation
import UIKit

class TableCell<RVM: ReusableViewModel>: UITableViewCell, ConfigurableReusableView {

    static var identifier: String { return RVM.reusableIdentifier }

    var vm: RVM!

    func set(vm: ReusableViewModel) {
        guard let vm = vm as? RVM else {
            fatalError("Passed instance of `ReusableVM` does not match `ReusableVM` type" +
                       "used in \( String(describing: type(of: self))).")
        }
        self.vm = vm
    }

    func configure() {
    }

}
