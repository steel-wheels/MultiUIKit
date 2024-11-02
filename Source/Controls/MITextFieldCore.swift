/*
 * @file MITextFieldCore.swift
 * @description Define MITextFieldCore class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

public class MITextFieldCore: MICoreView
{
        #if os(OSX)
        @IBOutlet weak var mTextField: NSTextField!
        #else
        @IBOutlet weak var mTextField: UITextField!
        #endif

        open override func setup() {
                super.setup(coreView: mTextField)
        }

        public var stringValue: String {
                get {
                        #if os(iOS)
                                return mTextField.text ?? ""
                        #else
                                return mTextField.stringValue
                        #endif
                }
                set(value){
                        #if os(iOS)
                                mTextField.text = value
                        #else
                                mTextField.stringValue = value
                        #endif
                }
        }

        public var isEditable: Bool {
                get {
                        #if os(iOS)
                                return mTextField.isUserInteractionEnabled
                        #else
                                return mTextField.isEditable
                        #endif
                }
                set(value){
                        #if os(iOS)
                                mTextField.isUserInteractionEnabled = value
                        #else
                                mTextField.isEditable = value
                        #endif
                }
        }
}

