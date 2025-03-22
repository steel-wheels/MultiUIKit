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

        open func allocateStorage() -> MITextStorage {
                return MITextStorage()
        }

        private func coreTextView() -> MITextViewCore {
                if let core: MITextViewCore = super.coreView() {
                        return core
                } else {
                        fatalError("Failed to get core view")
                }
        }

        public var textStorage: MITextStorage { get {
                return coreTextView().textStorage
        }}

        public var isEditable: Bool {
                get         { return coreTextView().isEditable }
                set(newval) { coreTextView().isEditable = newval }
        }

        public var textColor: MIColor? {
                get         { return coreTextView().textColor }
                set(newcol) { coreTextView().textColor = newcol }
        }

        public var textBackgroundColor: MIColor? {
                get         { return coreTextView().textBackgroundColor }
                set(newcol) { coreTextView().textBackgroundColor = newcol }
        }
}

