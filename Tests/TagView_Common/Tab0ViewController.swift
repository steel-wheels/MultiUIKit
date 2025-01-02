/*
 * @file Tab0ViewController.swift
 * @description Define Tab0ViewController class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

import MultiUIKit

public class Tab0ViewController: MIStackViewController
{
        public override func viewDidLoad() {
                super.setup(axis: .vertical)

                let label = MILabel()
                label.title = "View-0"
                self.root.addArrangedSubView(label)

                super.viewDidLoad()
        }
}
