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

        public var textStorage: MITextStorage { get {
                return coreTextView().textStorage
        }}

        public var isEditable: Bool {
                get         { return coreTextView().isEditable }
                set(newval) { coreTextView().isEditable = newval }
        }

        #if os(OSX)
        public var cursorMode: NSTextViewWrapper.CursorMode {
                get       { return coreTextView().cursorMode }
                set(mode) { coreTextView().cursorMode = mode }
        }
        #endif

        public var insertionPointColor: MIColor {
                get         { return coreTextView().insertionPointColor }
                set(newval) { coreTextView().insertionPointColor = newval }
        }

        public override func accept(visitor vis: MIVisitor) {
                vis.visit(textView: self)
        }
}

