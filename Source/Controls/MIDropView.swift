/*
 * @file MIDropViewn.swift
 * @description Define MIDropView class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)


public class MIDropView: MIInterfaceView
{
        #if os(OSX)
        private var mDroppableTypes: Set<NSPasteboard.PasteboardType> = []
        #endif

        open override func setup(frame frm: CGRect) {
                super.setup(nibName: "MIDropViewCore", frameSize: frm.size)
                #if os(OSX)
                registerForDraggedTypes(Array(mDroppableTypes))
                #endif
        }

        private func dropCoreView() -> MIDropViewCore {
                if let core: MIDropViewCore = super.coreView() {
                        return core
                } else {
                        fatalError("Failed to get core view")
                }
        }

        public var contentsView: MIStack { get {
                return dropCoreView().contentsView
        }}
}




