//
//  PreferenceViewController.swift
//  UnitTest_macOS
//
//  Created by Tomoo Hamada on 2024/12/02.
//

import MultiUIKit
import Foundation

public class PreferenceViewController: MIViewController
{
        public override func viewDidLoad() {
                super.viewDidLoad()
                
                let root = MIStack()
                root.axis = .vertical

                let button = MIButton()
                button.title = "Hello"
                root.addArrangedSubView(button)

                self.view = root
        }
}
