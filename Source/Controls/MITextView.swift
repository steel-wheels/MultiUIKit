/*
 * @file MITextView.swift
 * @description Define MITextView class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

open class MITextView: MIInterfaceView
{
        open override func setup(frame frm: CGRect) {
                super.setup(nibName: "MITextViewCore", frameSize: frm.size)
                coreTextView().setup(storage: allocateStorage())
        }

        private func allocateStorage() -> MITextStorage {
                return MITextStorage()
        }

        private func coreTextView() -> MITextViewCore {
                if let core: MITextViewCore = super.coreView() {
                        return core
                } else {
                        fatalError("Failed to get core view")
                }
        }

        public var storage: MITextStorage { get {
                return coreTextView().storage
        }}

        public var isEditable: Bool {
                get         { return coreTextView().isEditable }
                set(newval) { coreTextView().isEditable = newval }
        }

        public var textColor: MIColor? {
                get         { return coreTextView().textColor   }
                set(newval) { coreTextView().textColor = newval }
        }

        public override var backgroundColor: MIColor? {
                get         { return coreTextView().backgroundColor }
                set(newval) { coreTextView().backgroundColor = newval }
        }

        public var insertionPointColor: MIColor {
                get         { return coreTextView().insertionPointColor }
                set(newval) { coreTextView().insertionPointColor = newval }
        }

        public override func accept(visitor vis: MIVisitor) {
                vis.visit(textView: self)
        }
}

