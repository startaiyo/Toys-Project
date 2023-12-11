//
//  DiffableDataSourcePageViewControllerRepresentable.swift
//  Toys Etude
//
//  Created by Shotaro Doi on 2023/12/09.
//

import SwiftUI

struct DiffableDataSourcePageViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> DiffableDataSourcePageViewController {
        let storyboard = UIStoryboard(name: "DiffableDataSourcePage",
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DiffableDataSourcePage") as! DiffableDataSourcePageViewController
        let vm = DataSourceViewModel()
        vc.viewModel = vm
        vc.modalPresentationStyle = .fullScreen
        
        return vc
    }

    func updateUIViewController(_ uiViewController: DiffableDataSourcePageViewController,
                                context: Context) { }
}

struct DataSourcePageViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> DataSourcePageViewController {
        let storyboard = UIStoryboard(name: "DataSourcePage",
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DataSourcePage") as! DataSourcePageViewController
        let vm = DataSourceViewModel()
        vc.viewModel = vm
        vc.modalPresentationStyle = .fullScreen
        
        return vc
    }

    func updateUIViewController(_ uiViewController: DataSourcePageViewController,
                                context: Context) { }
}
