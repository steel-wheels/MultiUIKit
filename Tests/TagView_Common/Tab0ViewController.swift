/*
 * @file Tab0ViewController.swift
 * @description Define Tab0ViewController class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

import MultiUIKit

public class Tab0ViewController: MIViewController
{
        public override func viewDidLoad() {
                let root = MIStack()
                self.view.addSubview(root)

                MIBaseView.allocateSubviewLayout(axis: .horizontal, parentView: self.view, childView: root, space: 0.0)
                MIBaseView.allocateSubviewLayout(axis: .vertical, parentView: self.view, childView: root, space: 0.0)

                root.axis = .vertical
                let label = MILabel()
                label.title = "View-0"
                root.addArrangedSubView(label)

                super.viewDidLoad()
        }
}
