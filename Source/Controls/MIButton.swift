/*
 * @file MIButton.swift
 * @description Define MIButton class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)


public class MIButton: MIInterfaceView
{
        open override func setup(frame frm: CGRect) {
                super.setup(nibName: "MIButtonCore", frameSize: frm.size)
        }
        
        public var title: String {
                get {
                        if let button: MIButtonCore = super.coreView() {
                                return button.title
                        } else {
                                NSLog("Failed to set button title")
                                return ""
                        }
                }
                set(val){
                        if let button: MIButtonCore = super.coreView() {
                                button.title = val
                        } else {
                                NSLog("Failed to set button title")
                        }
                }
        }
}



