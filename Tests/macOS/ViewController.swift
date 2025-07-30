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

                if let names = NSFontManager.shared.availableFontNames(with: .fixedPitchFontMask) {
                        var str = ""
                        for name in names {
                                str = str + name + ", "
                        }
                        NSLog("avaiable font names = " + str)
                }

                /* init tests */
                stringTest()
                symbolTest()

                // Do any additional setup after loading the view.
                let label = MILabel()
                label.title = "Hello, world !!"
                mStack.addArrangedSubView(label)

                let popmenu0 = MIPopupMenu()
                popmenu0.setMenuItems(items: [
                        MIPopupMenu.MenuItem(title: "item A", value: .intValue(1)),
                        MIPopupMenu.MenuItem(title: "item B", value: .intValue(2))
                ])
                popmenu0.setCallback({
                        (_ value: MIMenuItem.Value) -> Void in NSLog("popupMenu: " + value.toString())
                })
                mStack.addArrangedSubView(popmenu0)

                let segment0 = MISegmentedControl()
                segment0.setMenuItems(items: [
                        MIPopupMenu.MenuItem(title: "segment A", value: .intValue(1)),
                        MIPopupMenu.MenuItem(title: "segment B", value: .intValue(2))
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

                /* Dropview */
                let dropview = MIDropView()
                dropview.contentsView.axis = .vertical
                mStack.addArrangedSubView(dropview)

                //let imgview0 = MIImageView()
                //imgview0.set(symbol: .pencil, size: .regular)
                //dropview.contentsView.addArrangedSubView(imgview0)

                //let imgview1 = MIImageView()
                //imgview1.set(symbol: .buttonHorizontal, size: .regular)
                //dropview.contentsView.addArrangedSubView(imgview1)

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

                let table0 = MITable()
                table0.setTableData(["Hello", "GoodMorinig"])
                mStack.addArrangedSubView(table0)

                let icon0 = MIButton()
                let sym0  = MISymbolTable.shared.load(symbol: .pencil, size: .regular)
                icon0.title = "Icon0"
                icon0.setImage(sym0)
                mStack.addArrangedSubView(icon0)

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
                button0.setButtonPressedCallback({
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
                button1.setButtonPressedCallback({
                        () -> Void in NSLog("button1 pressed")
                })
                buttons.addArrangedSubView(button1)
                buttons.distribution = .fillEqually

                mStack.addArrangedSubView(buttons)
        }

        override var representedObject: Any? {
                didSet {
                // Update the view, if already loaded.
                }
        }

        private func stringTest() {
                divideTest(string: "a\nb")
                divideTest(string: "a\nb\n\nc\n")
                divideTest(string: "\na--\nb----\n\nc--\n-")
        }

        private func symbolTest() {
                let symbol = MISymbol.pencil
                let url    = symbol.encodeToURL()
                NSLog("symbol url: \(url.path)")
                if let ressym = MISymbol.decode(fromURL: url) {
                        if ressym == symbol {
                                NSLog("decoded symbol: \(ressym.identifier)")
                        } else {
                                NSLog("[Error] unexpected symbol \(ressym.name) at \(#function)")
                        }
                } else {
                        NSLog("[Error] Failed to decode at \(#function)")
                }
        }

        private func divideTest(string str: String) {
                let astr  = NSAttributedString(string: str)
                let lines = NSAttributedString.devideByNewline(source: astr)
                NSLog("{source: \(str)")
                for line in lines {
                        NSLog("line: \"" + line.string + "\"")
                }
                NSLog("}")
        }
}

