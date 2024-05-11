//
//  AccessControlViewControllerRepresentable.swift
//  Toys Etude
//
//  Created by Shotaro Doi on 2024/05/11.
//

import SwiftUI

struct AccessControlViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> AccessControlViewController {
        let storyboard = UIStoryboard(name: "AccessControl",
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AccessControlViewController") as! AccessControlViewController
        let vm = AccessControlViewModel()
        vc.viewModel = vm
        vc.modalPresentationStyle = .fullScreen

        return vc
    }

    func updateUIViewController(_ uiViewController: AccessControlViewController,
                                context: Context) { }
}
