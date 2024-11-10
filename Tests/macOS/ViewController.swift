//
//  ViewController.swift
//  UnitTest_macOS
//
//  Created by Tomoo Hamada on 2024/10/20.
//

import MultiUIKit
import Cocoa

class ViewController: NSViewController {

        @IBOutlet weak var mStack: MIStack!

        override func viewDidLoad() {
                super.viewDidLoad()

                // Do any additional setup after loading the view.
                let label = MILabel()
                label.title = "Hello, world !!"
                mStack.addArrangedSubView(label)

                let web0 = MIWebView()
                if let url = URL(string: "https://www.apple.com") {
                        let request = URLRequest(url: url)
                        let _ = web0.load(request)
                }
                mStack.addArrangedSubView(web0)

                let text0 = MITextField()
                text0.stringValue = "This is text field"
                text0.setCallback({
                        (_ str: String) -> Void in
                        NSLog("Text is updated")
                })
                mStack.addArrangedSubView(text0)

                let buttons = MIStack()
                buttons.axis = .horizontal

                let switch0 = MISwitch()
                switch0.state = true
                switch0.setCallback({
                        (_ state: Bool) -> Void in NSLog("switch0: state \(state)")
                })
                buttons.addArrangedSubView(switch0)

                let button0 = MIButton()
                button0.title = "button-0"
                button0.setCallback({
                        () -> Void in NSLog("button0 pressed")
                })
                buttons.addArrangedSubView(button0)

                let button1 = MIButton()
                button1.title = "button-1"
                button1.setCallback({
                        () -> Void in NSLog("button1 pressed")
                })
                buttons.addArrangedSubView(button1)

                mStack.addArrangedSubView(buttons)
        }

        override var representedObject: Any? {
                didSet {
                // Update the view, if already loaded.
                }
        }


}

