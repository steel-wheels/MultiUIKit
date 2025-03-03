//
//  ViewController.swift
//  TextView_iOS
//
//  Created by Tomoo Hamada on 2025/03/02.
//

import MultiUIKit
import UIKit

class ViewController: UIViewController
{
        @IBOutlet weak var mTextView: MITextView!

        override func viewDidLoad() {
                super.viewDidLoad()

                // Do any additional setup after loading the view.
                mTextView.textBackgroundColor = MIColor.blue

                let storage = mTextView.textStorage
                let commands: Array<MITextStorage.Command> = [
                        .font(MIFont.monospacedSystemFont(ofSize: MIFont.systemFontSize, weight: .regular)),
                        .textColor(MIColor.yellow),
                        .backgroundColor(MIColor.blue),
                        .append("Hello, world")
                ]
                storage.update(commands: commands)
                NSLog("storage = \(storage.string)")
        }
}

