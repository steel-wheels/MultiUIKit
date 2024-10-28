/*
 * @file MIButtonCore.swift
 * @description Define MIButtonCore class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

public class MIButtonCore: MICoreView
{
#if os(OSX)
        @IBOutlet weak var mButton: NSButton!
#else
        @IBOutlet weak var mButton: UIButton!
#endif

        open override func setup() {
                super.setup(coreView: mButton)
        }

        public var title: String {
                get {
                        #if os(iOS)
                                return mButton.title(for: .normal) ?? ""
                        #else   // os(iOS)
                                return mButton.title
                        #endif // os(iOS)
                }
                set(value){
                        #if os(iOS)
                                mButton.setTitle(value, for: .normal)
                        #else // os(iOS)
                                mButton.title = value
                        #endif
                }
        }
}
