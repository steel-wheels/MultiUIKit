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

        public func addArrangedSubView(_ view: MIInterfaceView) {
                coreStackView().addArrangedSubView(view)
                switch self.axis {
                case .vertical:
                        view.setContentExpansionPriority(.defaultLow, for: .horizontal)
                        MIBaseView.allocateSubviewLayout(axis: .horizontal, parentView: self, childView: view, space: 4.0)
                        view.invalidateIntrinsicContentSize()
                case .horizontal:
                        view.setContentExpansionPriority(.defaultLow, for: .vertical)
                        MIBaseView.allocateSubviewLayout(axis: .vertical, parentView: self, childView: view, space: 4.0)
                        view.invalidateIntrinsicContentSize()
                @unknown default:
                        NSLog("can not happen")
                }
        }

        public var arrangedSubviews: Array<MIInterfaceView> { get {
                return coreStackView().arrangedSubviews
        }}
}




