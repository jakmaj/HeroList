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

}
