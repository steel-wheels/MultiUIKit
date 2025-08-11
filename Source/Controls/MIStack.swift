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


open class MIStack: MIInterfaceView
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

        public var distribution: MIStackCore.Distribution {
                get         { return coreStackView().distribution   }
                set(newval) { coreStackView().distribution = newval }
        }

        public func addArrangedSubView(_ view: MIInterfaceView) {
                coreStackView().addArrangedSubView(view)
        }

        public func insertArrangedSubView(_ view: MIInterfaceView, at index: Int) {
                coreStackView().insertArrangedSubView(view, at: index)
        }

        public var arrangedSubviews: Array<MIInterfaceView> { get {
                return coreStackView().arrangedSubviews
        }}

        public func removeAllSubviews() {
                coreStackView().removeAllSubviews()
        }
}




