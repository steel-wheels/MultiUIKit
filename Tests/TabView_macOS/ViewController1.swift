//
//  ViewController.swift
//  TabView_macOS
//
//  Created by Tomoo Hamada on 2025/01/13.
//

import MultiUIKit
import Cocoa

class ViewController1: MIViewController
{

        @IBOutlet weak var mRootView: MIStack!

        override func viewDidLoad() {
                super.viewDidLoad()

                // Do any additional setup after loading the view.
                let label = MILabel()
                label.title = "Controller1"
                mRootView.addArrangedSubView(label)
        }

        override var representedObject: Any? {
                didSet {
                // Update the view, if already loaded.
                }
        }


}

