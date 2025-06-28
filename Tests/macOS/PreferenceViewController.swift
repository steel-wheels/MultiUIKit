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

                let icon0 = MIIconView()
                icon0.set(symbol: .buttonHorizontalTopPress, size: .regular)
                root.addArrangedSubView(icon0)

                let button = MIButton()
                button.title = "Hello"
                root.addArrangedSubView(button)

                self.view = root
                root.setFrameSize(NSSize(width: 320, height: 240))
        }
}
