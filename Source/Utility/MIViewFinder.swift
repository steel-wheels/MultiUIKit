/**
 * @file MIViewFinder.swift
 * @brief  Define MIViewFinder class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

#if os(OSX)
import AppKit
#else
import UIKit
#endif
import Foundation

public class MIViewFinder: MIVisitor
{
        public enum Position {
                case left
                case right
                case top
                case bottom

                public var description: String {
                        let result: String
                        switch self {
                        case .left:     result = "left"
                        case .right:    result = "right"
                        case .top:      result = "top"
                        case .bottom:   result = "bottom"
                        }
                        return result
                }
        }

        public struct DetectedPoint {
                public var position            : Position
                public var tag                 : Int

                public init(position p: Position, tag t: Int) {
                        self.position    = p
                        self.tag         = t
                }

                public var description: String { get {
                        return "{tag: \(self.tag), position: \(position.description)}"
                }}
        }

        private var mClickedPoint:      Array<CGPoint>
        private var mDetectedPoint:     DetectedPoint?

        public init(clickedPorint cpoint: CGPoint) {
                mClickedPoint   = [cpoint]
                mDetectedPoint  = nil
        }

        static public func find(in root: MIInterfaceView, at point: CGPoint) -> DetectedPoint? {
                let finder = MIViewFinder(clickedPorint: point)
                root.accept(visitor: finder)
                return finder.mDetectedPoint
        }

        private func pushClickedPoint(point pt: CGPoint){
                mClickedPoint.append(pt)
        }

        private func clickedPoint() -> CGPoint {
                if let pt = mClickedPoint.last {
                        return pt
                } else {
                        NSLog("[Error] Empty clikeced point \(#file)")
                        return CGPoint.zero
                }
        }

        private func popClickedPoint() -> CGPoint {
                if mClickedPoint.count > 0 {
                        return mClickedPoint.removeLast()
                } else {
                        NSLog("[Error] Empty clikeced point \(#file)")
                        return CGPoint.zero
                }
        }

        /*
        長方形を2本の対角線で4分割したとき、ある点がどの領域に属するか判定する swiftdeの関数。
        macOS用でPointにはCGPoint。矩形にはCGRectを使って下さい。領域は、
         上, 下, 左 もしくは右で、enumで定義して、領域外にはnilを返して下さい。
        コメントは英語でお願いします。

        Here’s a Swift implementation for macOS that classifies a point into one of four regions
        (top, bottom, left, right) when a rectangle is divided by its two diagonals.
        If the point lies outside the rectangle, the function returns nil.
        */

        /// Determine which region a point belongs to
        /// - Parameters:
        ///   - point: The point to classify
        ///   - rect: The rectangle whose diagonals define the regions
        /// - Returns: The region (top, bottom, left, right), or nil if the point is outside
        private func didClicked(view v: MIInterfaceView, point pt: CGPoint) -> Position? {
                // Return nil if the point is outside the rectangle
                let frame = v.frame
                guard frame.contains(pt) else {
                        return nil
                }

                // Calculate the center of the rectangle (intersection of diagonals)
                let cx = frame.midX
                let cy = frame.midY

                // Vector from center to the point
                let dx = pt.x - cx
                let dy = pt.y - cy

                // Compare absolute values of dx and dy
                // If vertical component dominates, classify as top/bottom
                // If horizontal component dominates, classify as left/right
                if abs(dy) >= abs(dx) {
                        return dy >= 0 ? .top : .bottom
                } else {
                        return dx >= 0 ? .right : .left
                }
        }

        private func log(view v: MIInterfaceView, message msg: String){
                let depth = mClickedPoint.count
                var space = ""
                for _ in 0..<depth {
                        space += "  "
                }
                let classname = String(describing: type(of: v))
                NSLog("(MIViewFinder) \(space)\(classname) tag:\(v.tag) \(msg)")
        }

        public override func visit(button src: MIButton) {
                if let pos = didClicked(view: src, point: clickedPoint()) {
                        mDetectedPoint = DetectedPoint(position: pos, tag: src.tag)
                }
        }

        public override func visit(collectionView src: MICollectionView) {
                if let pos = didClicked(view: src, point: clickedPoint()) {
                        mDetectedPoint = DetectedPoint(position: pos, tag: src.tag)
                }
        }

        public override func visit(dropView src: MIDropView) {
                if let pos = didClicked(view: src, point: clickedPoint()) {
                        mDetectedPoint = DetectedPoint(position: pos, tag: src.tag)
                }
        }

        public override func visit(fileSelector src: MIFileSelector) {
                if let pos = didClicked(view: src, point: clickedPoint()) {
                        mDetectedPoint = DetectedPoint(position: pos, tag: src.tag)
                }
        }

        #if os(OSX)
        public override func visit(iconView src: MIIconView) {
                if let pos = didClicked(view: src, point: clickedPoint()) {
                        mDetectedPoint = DetectedPoint(position: pos, tag: src.tag)
                }
        }
        #endif

        public override func visit(imageView src: MIImageView) {
                if let pos = didClicked(view: src, point: clickedPoint()) {
                        mDetectedPoint = DetectedPoint(position: pos, tag: src.tag)
                }
        }

        public override func visit(label src: MILabel) {
                if let pos = didClicked(view: src, point: clickedPoint()) {
                        mDetectedPoint = DetectedPoint(position: pos, tag: src.tag)
                }
        }

        public override func visit(popupMenu src: MIPopupMenu) {
                if let pos = didClicked(view: src, point: clickedPoint()) {
                        mDetectedPoint = DetectedPoint(position: pos, tag: src.tag)
                }
        }

        public override func visit(segmentedControl src: MISegmentedControl) {
                if let pos = didClicked(view: src, point: clickedPoint()) {
                        mDetectedPoint = DetectedPoint(position: pos, tag: src.tag)
                }
        }

        public override func visit(stack src: MIStack) {
                let dx = src.frame.origin.x
                let dy = src.frame.origin.y

                var newpoint = clickedPoint()
                newpoint.x = max(newpoint.x - dx, 0.0)
                newpoint.y = max(newpoint.y - dy, 0.0)
                pushClickedPoint(point: newpoint)

                for subview in src.arrangedSubviews {
                        subview.accept(visitor: self)
                        if let _ = mDetectedPoint {
                                break
                        }
                }

                let _ = popClickedPoint()

                if mDetectedPoint == nil {
                        if let pos = didClicked(view: src, point: clickedPoint()) {
                                mDetectedPoint = DetectedPoint(position: pos, tag: src.tag)
                        }
                }
        }

        public override func visit(switchView src: MISwitch) {
                if let pos = didClicked(view: src, point: clickedPoint()) {
                        mDetectedPoint = DetectedPoint(position: pos, tag: src.tag)
                }
        }

        public override func visit(table src: MITable) {
                if let pos = didClicked(view: src, point: clickedPoint()) {
                        mDetectedPoint = DetectedPoint(position: pos, tag: src.tag)
                }
        }

        public override func visit(textField src: MITextField) {
                if let pos = didClicked(view: src, point: clickedPoint()) {
                        mDetectedPoint = DetectedPoint(position: pos, tag: src.tag)
                }
        }

        public override func visit(textView src: MITextView) {
                if let pos = didClicked(view: src, point: clickedPoint()) {
                        mDetectedPoint = DetectedPoint(position: pos, tag: src.tag)
                }
        }

        public override func visit(webView src: MIWebView) {
                if let pos = didClicked(view: src, point: clickedPoint()) {
                        mDetectedPoint = DetectedPoint(position: pos, tag: src.tag)
                }
        }
}

