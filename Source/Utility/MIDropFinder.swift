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
        private var mDroppedPoints:     Array<CGPoint>
        private var mDroppedView:       Array<MIInterfaceView>

        public static func detectDroppedView(rootView root: MIInterfaceView, droppedPoint dpoint: CGPoint) -> MIInterfaceView? {
                let finder = MIDropFinder(droppedPoint: dpoint)
                root.accept(visitor: finder)
                return finder.mDroppedView.last
        }

        private init(droppedPoint dpoint: CGPoint){
                mDroppedPoints  = [dpoint]
                mDroppedView    = []
        }

        private func hasIntersection(target tgt: CGPoint, view vw: MIInterfaceView) -> Bool {
                if vw.frame.contains(tgt) {
                        mDroppedView.append(vw)
                        return true
                } else {
                        return false
                }
        }

        private func currentDroppedPoint() -> CGPoint {
                if let pt = mDroppedPoints.last {
                        return pt
                } else {
                        NSLog("[Error] No dropped point at \(#file)")
                        return CGPoint.zero
                }
        }

        private func pushDroppedPoint(point pt: CGPoint) {
                mDroppedPoints.append(pt)
        }

        private func popDropRect() {
                if mDroppedPoints.count >= 1 {
                        let _ = mDroppedPoints.popLast()
                } else {
                        NSLog("[Error] Failed to pop at \(#file)")
                }
        }

        public override func visit(button src: MIButton) {
                let _ = hasIntersection(target: currentDroppedPoint(), view: src)
        }

        public override func visit(collectionView src: MICollectionView) {
                let _ = hasIntersection(target: currentDroppedPoint(), view: src)
        }

        public override func visit(dropView src: MIDropView) {
                let _ = src.contentsView.accept(visitor: self)
        }

        public override func visit(fileSelector src: MIFileSelector) {
                let _ = hasIntersection(target: currentDroppedPoint(), view: src)
        }

        #if os(OSX)
        public override func visit(iconView src: MIIconView) {
                let _ = hasIntersection(target: currentDroppedPoint(), view: src)
        }
        #endif

        public override func visit(imageView src: MIImageView) {
                let _ = hasIntersection(target: currentDroppedPoint(), view: src)
        }

        public override func visit(label src: MILabel) {
                let _ = hasIntersection(target: currentDroppedPoint(), view: src)
        }

        public override func visit(popupMenu src: MIPopupMenu) {
                let _ = hasIntersection(target: currentDroppedPoint(), view: src)
        }

        public override func visit(segmentedControl src: MISegmentedControl) {
                let _ = hasIntersection(target: currentDroppedPoint(), view: src)
        }

        public override func visit(stack src: MIStack) {
                let curpt = currentDroppedPoint()
                if hasIntersection(target: curpt, view: src){
                        for subview in src.arrangedSubviews {
                                let localpt = subview.convert(curpt, from: src)
                                pushDroppedPoint(point: localpt)
                                subview.accept(visitor: self)
                                popDropRect()
                        }
                }
        }

        public override func visit(switchView src: MISwitch) {
                let _ = hasIntersection(target: currentDroppedPoint(), view: src)
        }

        public override func visit(table src: MITable) {
                let _ = hasIntersection(target: currentDroppedPoint(), view: src)
        }

        public override func visit(textField src: MITextField) {
                let _ = hasIntersection(target: currentDroppedPoint(), view: src)
        }

        public override func visit(textView src: MITextView) {
                let _ = hasIntersection(target: currentDroppedPoint(), view: src)
        }

        public override func visit(webView src: MIWebView) {
                let _ = hasIntersection(target: currentDroppedPoint(), view: src)
        }
}

