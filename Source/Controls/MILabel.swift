/*
 * @file MILabel.swift
 * @description Define MILabel class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)


public class MILabel: MIInterfaceView
{
        open override func setup(frame frm: CGRect) {
                super.setup(nibName: "MILabelCore", frameSize: frm.size)
        }

        private func coreLabelView() -> MILabelCore {
                if let core: MILabelCore = super.coreView() {
                        return core
                } else {
                        fatalError("Failed to get core view")
                }
        }

        public var title: String {
                get {     return coreLabelView().title }
                set(val){ coreLabelView().title = val }
        }

        public override func accept(visitor vis: MIVisitor) {
                vis.visit(label: self)
        }
}


