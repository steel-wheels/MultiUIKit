//
//  ViewController.swift
//  TagViewTest_iOS
//
//  Created by Tomoo Hamada on 2024/12/26.
//

import MultiUIKit
import UIKit

class ViewController: MITabViewController
{
        override func viewDidLoad() {
                NSLog("setup")
                let ctrl0 = Tab0ViewController()
                super.addContentView(title: "label-0", controller: ctrl0)

                let ctrl1 = Tab1ViewController()
                super.addContentView(title: "label-1", controller: ctrl1)

                // Do any additional setup after loading the view.
                NSLog("viewDidLoad")
                super.viewDidLoad()
        }
}

