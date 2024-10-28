//
//  ViewController.swift
//  UnitTest_iOS
//
//  Created by Tomoo Hamada on 2024/10/20.
//

import MultiUIKit
import UIKit

class ViewController: UIViewController {

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
}

