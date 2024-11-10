/*
 * @file MISwitchCore.swift
 * @description Define MISwitchCore class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

public class MISwitchCore: MICoreView
{
        public typealias CallbackFunction = (_ state: Bool) -> Void

        private var mCallbackFunction: CallbackFunction? = nil

#if os(iOS)
        @IBOutlet weak var mSwitch: UISwitch!
        @IBAction func mValueChanged(_ sender: UISwitch) {
                changed()
        }
#else
        @IBOutlet weak var mSwitch: NSSwitch!

        @IBAction func mAction(_ sender: NSSwitch) {
                changed()
        }
#endif

        open override func setup() {
                super.setup(coreView: mSwitch)
        }

        public func setCallback(_ cbfunc: @escaping CallbackFunction){
                mCallbackFunction = cbfunc
        }

        private func changed() {
                if let callback = mCallbackFunction {
                        callback(self.state)
                }
        }

        public var state: Bool {
                get {
                        let result: Bool
                        #if os(iOS)
                                result = mSwitch.isOn
                        #else
                                switch mSwitch.state {
                                case .on:    result = true
                                case .mixed: result = true
                                case .off:   result = false
                                default:     result = false
                                }
                        #endif
                        return result
                }
                set(value) {
                        #if os(iOS)
                        mSwitch.setOn(value, animated: true)
                        #else
                        mSwitch.state = value ? .on : .off
                        #endif
                }
        }
}

