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
        public enum HorizontalPoint {
                case left
                case center
                case right

                public var description: String {
                        let result: String
                        switch self {
                        case .left:   result = "left"
                        case .center: result = "center"
                        case .right:  result = "right"
                        }
                        return result
                }
        }

        public enum VerticalPoint {
                case top
                case middle
                case bottom

                public var description: String {
                        let result: String
                        switch self {
                        case .top:    result = "top"
                        case .middle: result = "middle"
                        case .bottom: result = "bottom"
                        }
                        return result
                }
        }

        public struct DetectedPoint {
                var horizontalPoint     : HorizontalPoint
                var verticalPoint       : VerticalPoint
                var tag                 : Int

                public init(horizontalPoint: HorizontalPoint, verticalPoint: VerticalPoint, tag: Int) {
                        self.horizontalPoint    = horizontalPoint
                        self.verticalPoint      = verticalPoint
                        self.tag                = tag
                }

                public var description: String { get {
                        return "{" + horizontalPoint.description + ", "
                        + verticalPoint.description + "}"
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

        private func didClicked(view v: MIInterfaceView, point pt: CGPoint) -> DetectedPoint? {
                let frame  = v.frame
                let left   = frame.origin.x
                let right  = frame.origin.x + frame.size.width
                let top    = frame.origin.y
                let bottom = frame.origin.y + frame.size.height
                if left <= pt.x && pt.x < right && top <= pt.y && pt.y < bottom {
                        let hpos: HorizontalPoint
                        if left + (frame.size.width * 2.0 / 3.0) <= pt.x {
                                hpos = .right
                        } else if left + (frame.size.width * 1.0 / 3.0) <= pt.x {
                                hpos = .center
                        } else {
                                hpos = .left
                        }

                        let vpos: VerticalPoint
                        if top + (frame.size.height * 2.0 / 3.0) <= pt.y {
                                vpos = .top
                        } else if top + (frame.size.height * 1.0 / 3.0) <= pt.y {
                                vpos = .middle
                        } else {
                                vpos = .bottom
                        }

                        let dpt = DetectedPoint(horizontalPoint: hpos, verticalPoint: vpos, tag: v.tag)
                        log(view: v, message: "pt:\(pt.description) in frame:\(frame.description) -> \(dpt.description)")
                        return dpt
                } else {
                        log(view: v, message: "pt:\(pt.description) in frame:\(frame.description) -> nil")
                        return nil
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
                NSLog("point: \(clickedPoint().description) -> \(newpoint.description)")
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

