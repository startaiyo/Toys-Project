//
//  DataSourcePageViewController.swift
//  Toys Etude
//
//  Created by Shotaro Doi on 2023/12/09.
//

import UIKit

final class DataSourcePageViewController: UIViewController {
    @IBOutlet var refreshButton: UIButton! {
        didSet {
            refreshButton.addAction(.init {_ in
                self.viewModel.reload {
                    Task { @MainActor in
                        self.collectionView.reloadData()
                        print("cell reloaded!" + UUID().uuidString)
                    }
                }
            },
                                    for: .touchUpInside)
        }
    }
    var viewModel: DataSourceViewModelProtocol!
    @IBOutlet var updatebutton: UIButton! {
        didSet {
            updatebutton.addAction(.init {_ in
//                self.viewModel.deleteData(for: IndexPath(item: 2, section: 0).row) {
//                    self.collectionView.performBatchUpdates({
                        self.collectionView.deleteItems(at: [IndexPath(item: 2, section: 0)])
//                        },
//                                                            completion:nil)
//                }      
//                print("cell reloaded!" + UUID().uuidString)
            },
                                    for: .touchUpInside)
        }
    }
    @IBOutlet var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(UINib(nibName: "CollectionViewCell",
                                          bundle: nil),
                                    forCellWithReuseIdentifier: "CollectionViewCell")
            collectionView.reloadData()
        }
    }
}

extension DataSourcePageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        print(viewModel.items.count)
        return viewModel.items.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell",
                                                      for: indexPath) as! CollectionViewCell
        let vm = CollectionViewCellViewModel(text: viewModel.items[indexPath.row].string)
        cell.viewModel = vm
        return cell
    }
}

extension DataSourcePageViewController: UICollectionViewDelegate {
    
}
