/*
 * @file MIFileSelector.swift
 * @description Define MIFileSelector class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

open class MIFileSelector: MIInterfaceView
{
        open override func setup(frame frm: CGRect) {
                super.setup(nibName: "MIFileSelectorCore", frameSize: frm.size)
        }

        private func coreSelectorView() -> MIFileSelectorCore {
                if let core: MIFileSelectorCore = super.coreView() {
                        return core
                } else {
                        fatalError("Failed to get core view")
                }
        }

        public var url: URL {
                get             { return coreSelectorView().url }
                set(newval)     { coreSelectorView().url = newval }
        }
}
