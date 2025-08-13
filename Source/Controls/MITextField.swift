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
        public typealias CallbackFunction = MITextFieldCore.CallbackFunction

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

        public func setCallback(_ cbfunc: @escaping CallbackFunction){
                coreTextFieldView().setCallback(cbfunc)
        }

        public var stringValue: String {
                get        { return coreTextFieldView().stringValue  }
                set(value) { coreTextFieldView().stringValue = value }
        }

        public var signedIntValue: Int? {
                get        { return coreTextFieldView().signedIntValue  }
                set(value) { coreTextFieldView().signedIntValue = value }
        }

        public var unsignedIntValue: UInt? {
                get        { return coreTextFieldView().unsignedIntValue  }
                set(value) { coreTextFieldView().unsignedIntValue = value }
        }

        public var floatValue: Double? {
                get        { return coreTextFieldView().floatValue  }
                set(value) { coreTextFieldView().floatValue = value }
        }

        public var placeholderString: String? {
                get        { return coreTextFieldView().placeholderString }
                set(value) { coreTextFieldView().placeholderString = value }
        }
}






