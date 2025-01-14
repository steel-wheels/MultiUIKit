//
//  ViewController.swift
//  TabView_iOS
//
//  Created by Tomoo Hamada on 2025/01/13.
//

import MultiUIKit
import UIKit

class ViewController2: UIViewController
{
        @IBOutlet weak var mRootView: MIStack!

        override func viewDidLoad() {
                super.viewDidLoad()
                // Do any additional setup after loading the view.
                let label = MILabel()
                label.title = "Controller2"
                mRootView.addArrangedSubView(label)
        }
}

