/*
 * @file MIStack.swift
 * @description Define MIStack class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)


public class MIStack: MIInterfaceView
{
        open override func setup(frame frm: CGRect) {
                super.setup(nibName: "MIStackCore", frameSize: frm.size)
        }

        private func coreStackView() -> MIStackCore {
                if let core: MIStackCore = super.coreView() {
                        return core
                } else {
                        fatalError("Failed to get core view")
                }
        }

        public var axis: MIStackCore.Axis {
                get {           return coreStackView().axis     }
                set(value){     coreStackView().axis = value    }
        }

        public func addSubView(_ view: MIInterfaceView) {
                coreStackView().addSubView(view)
        }

        public var arrangedSubviews: Array<MIInterfaceView> { get {
                return coreStackView().arrangedSubviews
        }}
}




