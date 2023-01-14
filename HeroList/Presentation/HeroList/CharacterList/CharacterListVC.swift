//
//  CharacterListVC.swift
//  HeroList
//
//  Created by Jakub Majdl on 08.01.2023.
//

import Foundation
import UIKit

final class CharacterListVC: ViewController<CharacterListVM> {

    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupRx()
    }

    private func setupUI() {
        tableView.registerCell(CharacterListItemCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setupRx() {
    }

}

extension CharacterListVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.out.cellVMs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellVM = vm.out.cellVMs[safe: indexPath.item] else {
            return UITableViewCell()
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: cellVM).reusableIdentifier, for: indexPath)
        let configurableCell = cell as? ConfigurableReusableView
        configurableCell?.set(vm: cellVM)
        configurableCell?.configure()

        return cell
    }

}
