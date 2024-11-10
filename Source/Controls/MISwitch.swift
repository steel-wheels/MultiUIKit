/*
 * @file MISwitch.swift
 * @description Define MISwitch class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)


public class MISwitch: MIInterfaceView
{
        public typealias CallbackFunction = MISwitchCore.CallbackFunction

        open override func setup(frame frm: CGRect) {
                super.setup(nibName: "MISwitchCore", frameSize: frm.size)
        }

        private func coreSwitchView() -> MISwitchCore {
                if let core: MISwitchCore = super.coreView() {
                        return core
                } else {
                        fatalError("Failed to get core view")
                }
        }

        public func setCallback(_ cbfunc: @escaping CallbackFunction){
                coreSwitchView().setCallback(cbfunc)
        }

        public var state: Bool {
                get        { return coreSwitchView().state }
                set(value) { coreSwitchView().state = value }
        }
}





