//
//  CharacterListItemCell.swift
//  HeroList
//
//  Created by Jakub Majdl on 08.01.2023.
//

import Foundation
import Kingfisher
import UIKit

final class CharacterListItemCell: TableCell<CharacterListItemCellVM> {

    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var realNameLabel: UILabel!
    @IBOutlet private var publisherNameLabel: UILabel!
    @IBOutlet private var avatarImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        avatarImageView.kf.indicatorType = .activity
    }

    override func configure() {
        super.configure()

        nameLabel.text = vm.out.name
        realNameLabel.text = vm.out.realName
        realNameLabel.isHidden = vm.out.realName == nil
        publisherNameLabel.text = vm.out.publisherName
        avatarImageView.kf.setImage(
            with: vm.out.imageUrl,
            placeholder: UIImage(named: "avatarPlaceholder")
        )
    }

}
