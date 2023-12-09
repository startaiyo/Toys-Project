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
        vc.modalPresentationStyle = .fullScreen
        
        return vc
    }

    func updateUIViewController(_ uiViewController: DiffableDataSourcePageViewController,
                                context: Context) { }
}
