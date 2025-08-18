//
//  ViewController.swift
//  CollectionView_Test
//
//  Created by Tomoo Hamada on 2025/08/18.
//

import MultiUIKit
import Cocoa

class ViewController: NSViewController
{

        @IBOutlet weak var mCollectionView: MICollectionView!
        
        override func viewDidLoad() {
                super.viewDidLoad()

                // Do any additional setup after loading the view.
        }

        override var representedObject: Any? {
                didSet {
                // Update the view, if already loaded.
                }
        }


}

