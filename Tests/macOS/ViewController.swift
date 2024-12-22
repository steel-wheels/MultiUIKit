//
//  ViewController.swift
//  UnitTest_macOS
//
//  Created by Tomoo Hamada on 2024/10/20.
//

import MultiUIKit
import Cocoa

class ViewController: MIViewController {

        @IBOutlet weak var mStack: MIStack!

        override func viewDidLoad() {
                super.viewDidLoad()

                // Do any additional setup after loading the view.
                let label = MILabel()
                label.title = "Hello, world !!"
                mStack.addArrangedSubView(label)

                let popmenu0 = MIPopupMenu()
                popmenu0.setMenuItems(items: [
                        MIPopupMenu.MenuItem(menuId: 1, title: "item A"),
                        MIPopupMenu.MenuItem(menuId: 2, title: "item B")
                ])
                popmenu0.setCallback({
                        (_ menuId: Int) -> Void in NSLog("popupMenu: \(menuId)")
                })
                mStack.addArrangedSubView(popmenu0)

                let segment0 = MISegmentedControl()
                segment0.setMenuItems(items: [
                        MIPopupMenu.MenuItem(menuId: 1, title: "segment A"),
                        MIPopupMenu.MenuItem(menuId: 2, title: "segment B")
                ])
                segment0.setCallback({
                        (_ item: MIMenuItem?) in
                        if let item = item {
                                NSLog("segument0: \(item.title)")
                        } else {
                                NSLog("segument0: nil")
                        }
                })
                mStack.addArrangedSubView(segment0)

                #if false
                let web0 = MIWebView()
                if let url = URL(string: "https://www.apple.com") {
                        let request = URLRequest(url: url)
                        let _ = web0.load(request)
                }
                mStack.addArrangedSubView(web0)
                #endif

                let text0 = MITextField()
                text0.placeholderString = "This is place holder string"
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
                        super.alert(message: "Alert message", callback: {
                                (_ result: AlertResult) -> Void in
                                switch result {
                                case .ok:               NSLog("OK Pressed")
                                case .cancel:           NSLog("Cancel pressed")
                                @unknown default:       NSLog("Cam not happen")
                                }
                        })
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

