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

#if os(iOS)
public typealias MITextFieldDelegate = UITextFieldDelegate
#else   // os(OSX)
public typealias MITextFieldDelegate = NSTextFieldDelegate
#endif  // os(OSX)

public class MITextFieldCore: MICoreView, MITextFieldDelegate
{
        public typealias CallbackFunction = (_ str: String) -> Void

        private var mCallbackFunction: CallbackFunction? = nil

        #if os(OSX)
        @IBOutlet weak var mTextField: NSTextField!
        #else
        @IBOutlet weak var mTextField: UITextField!
        #endif

        open override func setup() {
                super.setup(coreView: mTextField)
                mTextField.delegate = self
        }

        public func setCallback(_ cbfunc: @escaping CallbackFunction){
                mCallbackFunction = cbfunc
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

        public var placeholderString: String? {
                get {
                        #if os(iOS)
                        return mTextField.placeholder
                        #else
                        return mTextField.placeholderString
                        #endif
                }
                set(value){
                        #if os(iOS)
                        mTextField.placeholder = value
                        #else
                        mTextField.placeholderString = value
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

        /* methods for MITexrFieldDelegate */
        #if os(iOS)
        public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
                if let cbfunc = mCallbackFunction {
                        cbfunc(self.stringValue)
                }
                return true
        }
        #else
        public func controlTextDidChange(_ obj: Notification) {
                if let cbfunc = mCallbackFunction {
                        cbfunc(self.stringValue)
                }
        }
        #endif
}

