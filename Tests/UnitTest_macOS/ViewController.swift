//
//  ViewController.swift
//  UnitTest_macOS
//
//  Created by Tomoo Hamada on 2026/08/22.
//

import MultiUIKit
import Cocoa

class ViewController: NSViewController
{
        @IBOutlet weak var mStack: MIStack!
        override func viewDidLoad() {
                super.viewDidLoad()

                // Do any additional setup after loading the view.
                mStack.addArrangedSubView(allocateOpenButton())
                mStack.addArrangedSubView(allocateSaveButton())
        }

        private func allocateOpenButton() -> MIButton {
                let button = MIButton()
                button.title = "Open file"
                button.setButtonPressedCallback({
                        () -> Void in
                        let panel = MIOpenPanel()
                        DispatchQueue.global(qos: .userInitiated).async {
                                panel.show(title: "Select file", type: .file, fileExtensions: ["js"])
                                NSLog("select start")
                                while !panel.selected {
                                        Thread.sleep(forTimeInterval: 0.1)
                                }
                                NSLog("select done")
                        }
                })
                return button
        }

        private func allocateSaveButton() -> MIButton {
                let button = MIButton()
                button.title = "Save file"
                button.setButtonPressedCallback({
                        () -> Void in
                        let panel = MISavePanel()
                        DispatchQueue.global(qos: .userInitiated).async {
                                let outurl = URL(fileURLWithPath: FileManager.default.homeDirectoryForCurrentUser.path())
                                panel.show(title: "Select file", outputDirectory: outurl)
                                NSLog("select start")
                                while !panel.selected {
                                        Thread.sleep(forTimeInterval: 0.1)
                                }
                                NSLog("select done")
                        }
                })
                return button
        }

        override var representedObject: Any? {
                didSet {
                // Update the view, if already loaded.
                }
        }


}

