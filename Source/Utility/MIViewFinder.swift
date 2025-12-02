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

        private func cross_product(u: CGPoint, v: CGPoint) -> CGFloat {
                return u.x * v.y - u.y * v.x;
        }

        private func create_vector(point1 p1: CGPoint, point2 p2: CGPoint) -> CGPoint {
                return CGPoint(x: p2.x - p1.x, y: p2.y - p1.y)
        }

        private func didClicked(view v: MIInterfaceView, point pt: CGPoint) -> DetectedPoint? {
                let frame       = v.frame

                let left   = frame.origin.x
                let right  = frame.origin.x + frame.size.width
                let top    = frame.origin.y
                let bottom = frame.origin.y + frame.size.height

                guard left <= pt.x && pt.x < right && top <= pt.y && pt.y < bottom else {
                        log(view: v, message: "pt:\(pt.description) in frame:\(frame.description) -> nil")
                        return nil
                }

                /*
                 長方形を2本の対角線で4分割したとき、ある点がどの領域に属するか判定する C 言語の関数
                 */

                /* rect ABCD */
                let pointA      = CGPoint(x: left,  y: bottom)          // left bottom
                let pointB      = CGPoint(x: right, y: bottom)          // right bottom
                let pointC      = CGPoint(x: right, y: top)             // right top
                let pointD      = CGPoint(x: left,  y: top)             // left top

                let pointO      = CGPoint(x: (right  - left) / 2.0 + left,
                                          y: (bottom - top ) / 2.0 + top)        // center

                let vec_OA      = create_vector(point1: pointO, point2: pointA)
                let vec_OB      = create_vector(point1: pointO, point2: pointB)
                let vec_OC      = create_vector(point1: pointO, point2: pointC)
                let vec_OD      = create_vector(point1: pointO, point2: pointD)
                let vec_OP      = create_vector(point1: pointO, point2: pt)

                let c_OA_OP = cross_product(u: vec_OA, v: vec_OP);
                let c_OB_OP = cross_product(u: vec_OB, v: vec_OP);
                let c_OC_OP = cross_product(u: vec_OC, v: vec_OP);
                let c_OD_OP = cross_product(u: vec_OD, v: vec_OP);

                let pos: Position
                if (c_OA_OP >= 0.0 && c_OB_OP <= 0.0) {
                        pos = .bottom   // OAB
                } else if (c_OB_OP >= 0.0 && c_OC_OP <= 0.0) {
                        pos = .right    // OBC
                } else if (c_OC_OP >= 0.0 && c_OD_OP <= 0.0) {
                        pos = .top      // OCD
                } else if (c_OD_OP >= 0.0 && c_OA_OP <= 0.0) {
                        pos = .left     // ODA
                } else {
                        return nil // no match
                }

                let dpt = DetectedPoint(position: pos, tag: v.tag)
                log(view: v, message: "pt:\(pt.description) in frame:\(frame.description) -> \(dpt.description)")
                return dpt
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
                if let dpc = didClicked(view: src, point: clickedPoint()) {
                        mDetectedPoint = dpc
                }
        }

        public override func visit(collectionView src: MICollectionView) {
                if let dpc = didClicked(view: src, point: clickedPoint()) {
                        mDetectedPoint = dpc
                }
        }

        public override func visit(dropView src: MIDropView) {
                if let dpc = didClicked(view: src, point: clickedPoint()) {
                        mDetectedPoint = dpc
                }
        }

        public override func visit(fileSelector src: MIFileSelector) {
                if let dpc = didClicked(view: src, point: clickedPoint()) {
                        mDetectedPoint = dpc
                }
        }

        #if os(OSX)
        public override func visit(iconView src: MIIconView) {
                if let dpc = didClicked(view: src, point: clickedPoint()) {
                        mDetectedPoint = dpc
                }
        }
        #endif

        public override func visit(imageView src: MIImageView) {
                if let dpc = didClicked(view: src, point: clickedPoint()) {
                        mDetectedPoint = dpc
                }
        }

        public override func visit(label src: MILabel) {
                if let dpc = didClicked(view: src, point: clickedPoint()) {
                        mDetectedPoint = dpc
                }
        }

        public override func visit(popupMenu src: MIPopupMenu) {
                if let dpc = didClicked(view: src, point: clickedPoint()) {
                        mDetectedPoint = dpc
                }
        }

        public override func visit(segmentedControl src: MISegmentedControl) {
                if let dpc = didClicked(view: src, point: clickedPoint()) {
                        mDetectedPoint = dpc
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
                        mDetectedPoint = didClicked(view: src, point: clickedPoint())
                }
        }

        public override func visit(switchView src: MISwitch) {
                if let dpc = didClicked(view: src, point: clickedPoint()) {
                        mDetectedPoint = dpc
                }
        }

        public override func visit(table src: MITable) {
                if let dpc = didClicked(view: src, point: clickedPoint()) {
                        mDetectedPoint = dpc
                }
        }

        public override func visit(textField src: MITextField) {
                if let dpc = didClicked(view: src, point: clickedPoint()) {
                        mDetectedPoint = dpc
                }
        }

        public override func visit(textView src: MITextView) {
                if let dpc = didClicked(view: src, point: clickedPoint()) {
                        mDetectedPoint = dpc
                }
        }

        public override func visit(webView src: MIWebView) {
                if let dpc = didClicked(view: src, point: clickedPoint()) {
                        mDetectedPoint = dpc
                }
        }
}

