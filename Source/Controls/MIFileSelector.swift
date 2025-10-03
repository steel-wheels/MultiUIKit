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
        public typealias FileType = MIFileSelectorCore.FileType
        public typealias CallbackFunction = MIFileSelectorCore.CallbackFunction

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

        public var fileType: FileType {
                get        { return coreSelectorView().fileType }
                set(ftype) { coreSelectorView().fileType = ftype }
        }

        public func setCallback(_ cbfunc: @escaping CallbackFunction){
                coreSelectorView().setCallback(cbfunc)
        }

        public var url: URL? {
                get             { return coreSelectorView().url }
                set(newval)     { coreSelectorView().url = newval }
        }

        public override func accept(visitor vis: MIVisitor) {
                vis.visit(fileSelector: self)
        }
}
