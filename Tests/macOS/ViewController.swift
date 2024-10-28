//
//  ViewController.swift
//  UnitTest_macOS
//
//  Created by Tomoo Hamada on 2024/10/20.
//

import MultiUIKit
import Cocoa

class ViewController: NSViewController {


        @IBOutlet weak var mLabel: MILabel!
        @IBOutlet weak var mButton: MIButton!
        @IBOutlet weak var mStack: MIStack!

        override func viewDidLoad() {
                super.viewDidLoad()

                // Do any additional setup after loading the view.
                let label = MILabel()
                label.title = "Hello, world !!"
                mStack.addSubView(label)

                let button = MIButton()
                mStack.addSubView(button)
        }

        override var representedObject: Any? {
                didSet {
                // Update the view, if already loaded.
                }
        }


}

