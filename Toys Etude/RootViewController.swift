//
//  RootViewController.swift
//  Toys Etude
//
//  Created by Shotaro Doi on 2023/12/09.
//

import UIKit
import SwiftUI

final class RootViewController: UIViewController {
    @IBOutlet private var startButton: UIButton! {
        didSet {
            startButton.addAction(.init {_ in
                let vc = UIHostingController(rootView: RootListView())
                self.navigationController?.pushViewController(vc,
                                                              animated: true)
            },
                                  for: .touchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
