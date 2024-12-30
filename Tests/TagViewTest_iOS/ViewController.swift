//
//  ViewController.swift
//  TagViewTest_iOS
//
//  Created by Tomoo Hamada on 2024/12/26.
//

import MultiUIKit
import UIKit

open class ViewController: MITabViewController
{
        public override func viewDidLoad() {
                NSLog("view did load")
                let tab0 = TabView0() ; tab0.setup(label: "label 0")
                let tab1 = TabView0() ; tab1.setup(label: "label 1")
                super.addContentView(title: "label 0", contentView: tab0)
                super.addContentView(title: "label 1", contentView: tab1)

                super.viewDidLoad()
        }
}

