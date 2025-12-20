/**
 * @file MIDropFinder.swift
 * @brief  Define MIDropFinder class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

#if os(OSX)
import AppKit
#else
import UIKit
#endif
import Foundation

public class MIDropFinder: MIVisitor
{
        private var mDropRect:          Array<CGRect>
        private var mDroppedView:       Array<MIInterfaceView>

        public static func detectDroppedView(rootView root: MIInterfaceView, dropRect drect: CGRect) -> MIInterfaceView? {
                let finder = MIDropFinder(dropRect: drect)
                root.accept(visitor: finder)
                return finder.mDroppedView.last
        }

        private init(dropRect drect: CGRect){
                mDropRect       = [drect]
                mDroppedView    = []
        }

        private func hasIntersection(target tgt: CGRect, view vw: MIInterfaceView) -> Bool {
                if tgt.intersects(vw.frame) {
                        mDroppedView.append(vw)
                        return true
                } else {
                        return false
                }
        }

        private func currentDropRect() -> CGRect {
                if let rect = mDropRect.last {
                        return rect
                } else {
                        NSLog("[Error] No drop rect at \(#file)")
                        return CGRect.zero
                }
        }

        private func pushDropRect(rect rct: CGRect) {
                mDropRect.append(rct)
        }

        private func popDropRect() {
                if mDropRect.count > 1 {
                        let _ = mDropRect.popLast()
                } else {
                        NSLog("[Error] Failed to pop at \(#file)")
                }
        }

        public override func visit(button src: MIButton) {
                let _ = hasIntersection(target: currentDropRect(), view: src)
        }

        public override func visit(collectionView src: MICollectionView) {
                let _ = hasIntersection(target: currentDropRect(), view: src)
        }

        public override func visit(dropView src: MIDropView) {
                let _ = src.contentsView.accept(visitor: self)
        }

        public override func visit(fileSelector src: MIFileSelector) {
                let _ = hasIntersection(target: currentDropRect(), view: src)
        }

        #if os(OSX)
        public override func visit(iconView src: MIIconView) {
                let _ = hasIntersection(target: currentDropRect(), view: src)
        }
        #endif

        public override func visit(imageView src: MIImageView) {
                let _ = hasIntersection(target: currentDropRect(), view: src)
        }

        public override func visit(label src: MILabel) {
                let _ = hasIntersection(target: currentDropRect(), view: src)
        }

        public override func visit(popupMenu src: MIPopupMenu) {
                let _ = hasIntersection(target: currentDropRect(), view: src)
        }

        public override func visit(segmentedControl src: MISegmentedControl) {
                let _ = hasIntersection(target: currentDropRect(), view: src)
        }

        public override func visit(stack src: MIStack) {
                let currect = currentDropRect()
                if hasIntersection(target: currect, view: src){
                        for subview in src.arrangedSubviews {
                                let localdirty = subview.convert(currect, from: src)
                                if !localdirty.isEmpty {
                                        pushDropRect(rect: localdirty)
                                        subview.accept(visitor: self)
                                        popDropRect()
                                }
                        }
                }
        }

        public override func visit(switchView src: MISwitch) {
                let _ = hasIntersection(target: currentDropRect(), view: src)
        }

        public override func visit(table src: MITable) {
                let _ = hasIntersection(target: currentDropRect(), view: src)
        }

        public override func visit(textField src: MITextField) {
                let _ = hasIntersection(target: currentDropRect(), view: src)
        }

        public override func visit(textView src: MITextView) {
                let _ = hasIntersection(target: currentDropRect(), view: src)
        }

        public override func visit(webView src: MIWebView) {
                let _ = hasIntersection(target: currentDropRect(), view: src)
        }
}

