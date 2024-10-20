/*
 * @file MILabelCore.swift
 * @description Define MILabelCore class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

public class MILabelCore: MICoreView
{
#if os(OSX)
        @IBOutlet weak var mLabel: NSTextField!
#else
        @IBOutlet weak var mLabel: UILabel!
#endif
        open override func setup() {
                super.setup(coreView: mLabel)
        }
        
        public var title: String {
                get {
                        #if os(iOS)
                                return mLabel.text ?? ""
                        #else   // os(iOS)
                                return mLabel.stringValue
                        #endif // os(iOS)
                }
                set(value){
                        #if os(iOS)
                                mLabel.text = value
                        #else // os(iOS)
                                mLabel.stringValue = value
                        #endif
                }
        }
}
