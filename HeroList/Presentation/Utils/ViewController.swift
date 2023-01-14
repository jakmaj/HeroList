//
//  ViewController.swift
//  HeroList
//
//  Created by Jakub Majdl on 11.01.2023.
//

import Foundation
import RxSwift
import UIKit

class ViewController<VM: ViewModelProtocol>: UIViewController {

    var vm: VM!

    let disposeBag = DisposeBag()

    required init(vm: VM, nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.vm = vm
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("Use `init(vm:,nibName:,bundle:)` instead")
    }
}
