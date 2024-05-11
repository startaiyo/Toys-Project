//
//  AccessControlViewController.swift
//  Toys Etude
//
//  Created by Shotaro Doi on 2024/05/11.
//

import UIKit

final class AccessControlViewController: UIViewController {
    var viewModel: AccessControlViewModel!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var privateButton: UIButton! {
        didSet {
            privateButton.addAction(.init {[weak self] _ in
                guard let self else { return }
//                // ここでコンパイルエラー
//                self.viewModel.privateSetResult = "altered"
                self.viewModel.changeResult()
                self.resultLabel.text = self.viewModel.privateSetResult
            },
                                    for: .touchUpInside)
        }
    }
    @IBOutlet var fileprivateButton: UIButton! {
        didSet {
            fileprivateButton.addAction(.init {[weak self] _ in
                guard let self else { return }
//                // ここでコンパイルエラー
//                print(SecretClass().secretFileprivate)
                self.viewModel.changeResultFromFileprivate()
                self.resultLabel.text = self.viewModel.privateSetResult
            },
                                    for: .touchUpInside)
        }
    }
    @IBOutlet var internalButton: UIButton! {
        didSet {
            internalButton.addAction(.init {[weak self] _ in
                guard let self else { return }
                self.resultLabel.text = self.viewModel.internalResult
            },
                                    for: .touchUpInside)
        }
    }
    @IBOutlet var publicButton: UIButton! {
        didSet {
            publicButton.addAction(.init {[weak self] _ in
                guard let self else { return }
                self.viewModel.changeResultFromAnotherModule()
                self.resultLabel.text = self.viewModel.privateSetResult
            },
                                    for: .touchUpInside)
        }
    }
    @IBOutlet var openButton: UIButton! {
        didSet {
            openButton.addAction(.init {[weak self] _ in
                guard let self else { return }
                self.viewModel.changeResultFromInheritedClassFromModule()
                self.resultLabel.text = self.viewModel.privateSetResult
            },
                                    for: .touchUpInside)
        }
    }
}
