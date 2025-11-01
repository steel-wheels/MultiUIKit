/*
 * @file MIImageView.swift
 * @description Define MIImageView class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

open class MIImageView: MIInterfaceView
{
        open override func setup(frame frm: CGRect) {
                super.setup(nibName: "MIImageCore", frameSize: frm.size)
        }

        private func coreImageView() -> MIImageCore {
                if let core: MIImageCore = super.coreView() {
                        return core
                } else {
                        fatalError("Failed to get core view")
                }
        }

        public var image: MIImage? {
                get {
                        return coreImageView().image
                }
                set(val){
                        coreImageView().image = val
                        if let img = val {
                                super.set(contentSize: img.size)
                        }
                }
        }

        open func set(symbol sym: MISymbol, size sz: MISymbolSize){
                self.image   = MISymbolTable.shared.load(symbol: sym, size: sz)
        }

        public func imageFrame() -> CGRect {
                coreImageView().imageFrame()
        }

        public override func accept(visitor vis: MIVisitor) {
                vis.visit(imageView: self)
        }
}

