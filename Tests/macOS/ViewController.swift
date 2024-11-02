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
                mStack.addArrangedSubView(label)

                let buttons = MIStack()
                buttons.axis = .horizontal

                let switch0 = MISwitch()
                switch0.state = true
                buttons.addArrangedSubView(switch0)

                let button0 = MIButton()
                button0.title = "button-0"
                buttons.addArrangedSubView(button0)

                let button1 = MIButton()
                button1.title = "button-1"
                buttons.addArrangedSubView(button1)

                mStack.addArrangedSubView(buttons)
        }

        override var representedObject: Any? {
                didSet {
                // Update the view, if already loaded.
                }
        }


}

