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
        public typealias CallbackFunction = () -> Void

        private var mCallbackFunction: CallbackFunction? = nil

#if os(OSX)
        @IBOutlet weak var mButton: NSButton!

        @IBAction func action(_ sender: NSButton) {
                pressed()
        }

#else
        @IBOutlet weak var mButton: UIButton!

        @IBAction func action(_ sender: UIButton) {
                pressed()
        }
#endif

        open override func setup() {
                super.setup(coreView: mButton)
        }

        public func setCallback(_ cbfunc: @escaping CallbackFunction){
                mCallbackFunction = cbfunc
        }

        private func pressed() {
                if let callback = mCallbackFunction {
                        callback()
                }
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
