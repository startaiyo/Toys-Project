//
//  CollectionViewCellViewModel.swift
//  Toys Etude
//
//  Created by Shotaro Doi on 2023/12/09.
//

protocol CollectionViewCellViewModelOutput {
    var cellText: String { get }
}

typealias CollectionViewCellViewModelProtocol = CollectionViewCellViewModelOutput

final class CollectionViewCellViewModel {
    private var text: String?

    init(text: String) {
        self.text = text
    }
}

extension CollectionViewCellViewModel: CollectionViewCellViewModelOutput {
    var cellText: String { text ?? "" }
}

