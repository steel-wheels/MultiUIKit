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
                }
        }

        open func set(symbol sym: MISymbol, size sz: MISymbolSize){
                let img = MISymbolTable.shared.load(symbol: sym, size: sz)
                self.image = img
                self.explicitContentsSize = img.size
        }

        public var explicitContentsSize: CGSize? {
                get         { return coreImageView().explicitContentsSize   }
                set(newval) { coreImageView().explicitContentsSize = newval }
        }

        public func imageFrame() -> CGRect {
                coreImageView().imageFrame()
        }

        public func rellocateSubviewLayout(){
                let coreview = coreImageView()
                coreview.translatesAutoresizingMaskIntoConstraints = false

                guard let coresize = explicitContentsSize else {
                        return
                }

                let parentsize  = self.frame
                let hspace = (parentsize.width  - coresize.width ) / 2.0
                let vspace = (parentsize.height - coresize.height) / 2.0

                guard hspace >= 0.0 && vspace > 0.0 else {
                        return
                }

                removeAllConstraints()

                addTopSideConstraint(childView: coreview, space: vspace)
                addBottomSideConstraint(childView: coreview, space: vspace)
                addLeftSideConstraint(childView: coreview, space: hspace)
                addRightSideConstraint(childView: coreview, space: hspace)
        }

        public override func accept(visitor vis: MIVisitor) {
                vis.visit(imageView: self)
        }
}

