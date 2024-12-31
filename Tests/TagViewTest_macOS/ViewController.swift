//
//  ViewController.swift
//  TagViewTest_macOS
//
//  Created by Tomoo Hamada on 2024/12/31.
//

import MultiUIKit
import Cocoa

class ViewController: MITabViewController
{
        override func viewDidLoad() {
                // Do any additional setup after loading the view.
                let tab0 = TabView0() ; tab0.setup(label: "label 0")
                let tab1 = TabView0() ; tab1.setup(label: "label 1")
                NSLog("addContentView")
                super.addContentView(title: "label 0", contentView: tab0)
                super.addContentView(title: "label 1", contentView: tab1)
                NSLog("viewDidLoad")
                super.viewDidLoad()
        }

        override var representedObject: Any? {
                didSet {
                // Update the view, if already loaded.
                }
        }


}

