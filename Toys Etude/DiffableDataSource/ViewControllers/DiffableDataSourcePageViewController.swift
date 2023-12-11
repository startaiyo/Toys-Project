//
//  DiffableDataSourcePageViewController.swift
//  Toys Etude
//
//  Created by Shotaro Doi on 2023/12/09.
//

import UIKit

final class DiffableDataSourcePageViewController: UIViewController {
    var viewModel: DataSourceViewModel!
    @IBOutlet var refreshButton: UIButton! {
        didSet {
            refreshButton.addAction(.init {_ in
                self.viewModel.reload {
                    Task { @MainActor in
                        self.dataSource.apply(self.viewModel.itemIdentifiers)
                        print("cell reloaded!" + UUID().uuidString)
                    }
                }
            },
                                    for: .touchUpInside)
        }
    }
    @IBOutlet var updateButton: UIButton! {
        didSet {
            updateButton.addAction(.init {_ in
                guard let deleteObj = self.dataSource.itemIdentifier(for: IndexPath(item: 2, section: 0)) else { return }
                var snapShot = self.dataSource.snapshot()
                snapShot.deleteItems([deleteObj])
                self.dataSource.apply(snapShot)
            },
                                   for:.touchUpInside)
        }
    }
    @IBOutlet var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: "CollectionViewCell",
                                          bundle: nil),
                                    forCellWithReuseIdentifier: "CollectionViewCell")
        }
    }
    lazy var dataSource = RandomStringDataSource(collectionView)
}

final class RandomStringDataSource: UICollectionViewDiffableDataSource<Int, ItemIdentifier> {
    init(_ collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell",
                                                          for: indexPath) as! CollectionViewCell
            cell.viewModel = itemIdentifier.viewModel
            return cell
        }
    }
}

// MARK: - Public functions
extension RandomStringDataSource {
    func apply(_ items: [ItemIdentifier]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, ItemIdentifier>()
        snapshot.appendSections([0])
        snapshot.appendItems(items)

        DispatchQueue.main.async {
            self.apply(snapshot,
                       animatingDifferences: true)
        }
    }
}

struct ItemIdentifier: Hashable {
    let viewModel: CollectionViewCellViewModel
    let id: String = UUID().uuidString

    static func == (lhs: ItemIdentifier,
                    rhs: ItemIdentifier) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(viewModel.cellText)
    }
}
