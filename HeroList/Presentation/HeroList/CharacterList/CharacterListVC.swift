//
//  CharacterListVC.swift
//  HeroList
//
//  Created by Jakub Majdl on 08.01.2023.
//

import Foundation
import UIKit

final class CharacterListVC: BaseViewController, ViewController {

    var vm: CharacterListVM!

    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "CharacterListVCTitle".localized

        setupTable()
        setupRx()

        vm.in.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // remove highlight when returning from detail
        if let selectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedRow, animated: true)
        }
    }

    private func setupTable() {
        tableView.registerCell(CharacterListItemCell.self)
        tableView.delegate = self
        tableView.dataSource = self

        tableView.tableHeaderView = UIView() // to remove first cell top separator
    }

    private func setupRx() {
        vm.out.rx.reloadTable
            .do(onNext: { [weak self] in
                self?.tableView.reloadData()
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

    private func updateForState(_ state: CharacterListVM.State) {
        state == .loading ? showLoading() : hideLoading()

        if state == .error {
            showError(message: "CharacterListVCErrorMessage".localized, dismissable: false) { [weak self] in
                self?.vm.in.reloadData()
            }
        }
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cellVM = vm.out.cellVMs[safe: indexPath.item] as? CharacterListItemCellVM else { return }

        vm.in.routeToDetail(characterId: cellVM.out.id, initialName: cellVM.out.name)
    }

}
