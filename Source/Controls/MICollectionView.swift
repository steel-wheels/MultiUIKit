/*
 * @file MICollectionView.swift
 * @description Define MICollectionView class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)


open class MICollectionView: MIInterfaceView
{
        public override func setup(frame frm: CGRect) {
                super.setup(nibName: "MICollectionViewCore", frameSize: frm.size)
        }

        private func coreCollectionView() -> MICollectionViewCore {
                if let core: MICollectionViewCore = super.coreView() {
                        return core
                } else {
                        fatalError("Failed to get core view")
                }
        }

        public func set(symbols syms: Array<MISymbol>, size sz: MISymbolSize){
                coreCollectionView().set(symbols: syms, size: sz)
        }

        public override func accept(visitor vis: MIVisitor) {
                vis.visit(collectionView: self)
        }
}

