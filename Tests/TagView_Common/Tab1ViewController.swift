/*
 * @file Tab1ViewController.swift
 * @description Define Tab1ViewController class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

import MultiUIKit

public class Tab1ViewController: MIStackViewController
{
        public override func viewDidLoad() {
                super.setup(axis: .vertical)

                let label = MILabel()
                label.title = "View-1"
                self.root.addArrangedSubView(label)

                super.viewDidLoad()
        }
}
