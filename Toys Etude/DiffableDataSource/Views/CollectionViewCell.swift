//
//  CollectionViewCell.swift
//  Toys Etude
//
//  Created by Shotaro Doi on 2023/12/09.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
    var viewModel: CollectionViewCellViewModelProtocol! {
        didSet {
            setupBindings()
        }
    }
    @IBOutlet weak var label: UILabel!

    func setupBindings() {
        label.text = viewModel.cellText
        backgroundColor = .red
    }
}
