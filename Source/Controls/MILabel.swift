/*
 * @file MILabel.swift
 * @description Define MILabel class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)


public class MILabel: MIInterfaceView
{
        open override func setup(frame frm: CGRect) {
                super.setup(nibName: "MILabelCore", frameSize: frm.size)
        }
        
        public var title: String {
                get {
                        if let label: MILabelCore = super.coreView() {
                                return label.title
                        } else {
                                NSLog("Failed to set label title")
                                return ""
                        }
                }
                set(val){
                        if let label: MILabelCore = super.coreView() {
                                label.title = val
                        } else {
                                NSLog("Failed to set label title")
                        }
                }
        }
}



