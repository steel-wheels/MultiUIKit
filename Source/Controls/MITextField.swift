/*
 * @file MITextField.swift
 * @description Define MITextField class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)


public class MITextField: MIInterfaceView
{
        open override func setup(frame frm: CGRect) {
                super.setup(nibName: "MITextFieldCore", frameSize: frm.size)
        }

        private func coreTextFieldView() -> MITextFieldCore {
                if let core: MITextFieldCore = super.coreView() {
                        return core
                } else {
                        fatalError("Failed to get core view")
                }
        }

        public var stringValue: String {
                get        { return coreTextFieldView().stringValue  }
                set(value) { coreTextFieldView().stringValue = value }
        }
}






