/**
 * @file MIPreLayouter.swift
 * @brief  Define MIPreLayouter. class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

#if os(OSX)
import AppKit
#else
import UIKit
#endif
import Foundation

public class MIPreLayouter: MIVisitor
{
        private var mCurrentFrames: Array<CGRect>

        public static func layout(rootView root: MIInterfaceView){
                let layouter = MIPreLayouter()

                let rootfrm = CGRect(origin: CGPoint.zero, size: root.frame.size)
                layouter.pushCurrentFrame(frame: rootfrm)
                root.accept(visitor: layouter)
        }

        public override init() {
                mCurrentFrames = []
        }

        private func pushCurrentFrame(frame frm: CGRect){
                mCurrentFrames.append(frm)
        }

        private func popCurrentFrame() {
                if mCurrentFrames.count > 0 {
                        mCurrentFrames.removeLast()
                } else {
                        NSLog("[Error] Empty stack at \(#file)")
                }
        }

        private func currentFrame() -> CGRect {
                if let frm = mCurrentFrames.last {
                        return frm
                } else {
                        NSLog("[Error] Empty stack at \(#file)")
                        return CGRect.zero
                }
        }

        private func updateSize(view v: MIInterfaceView, size sz: CGSize){
                v.frame.size  = sz
                v.bounds.size = sz
        }

        private func updateOrigin(view v: MIInterfaceView, point pt: CGPoint){
                v.frame.origin = pt
        }

        public override func visit(button src: MIButton) {
                let curframe = currentFrame()
                updateSize(view: src, size: curframe.size)
        }

        public override func visit(collectionView src: MICollectionView) {
                let curframe = currentFrame()
                updateSize(view: src, size: curframe.size)
        }

        public override func visit(dropView src: MIDropView) {
                let curframe = currentFrame()
                updateSize(view: src, size: curframe.size)

                let content = src.contentsView
                pushCurrentFrame(frame: CGRect(origin: CGPoint.zero, size: content.frame.size))
                content.accept(visitor: self)
                popCurrentFrame()
        }

        public override func visit(fileSelector src: MIFileSelector) {
                let curframe = currentFrame()
                updateSize(view: src, size: curframe.size)
        }

        #if os(OSX)
        public override func visit(iconView src: MIIconView) {
                let curframe = currentFrame()
                updateSize(view: src, size: curframe.size)
        }
        #endif

        public override func visit(imageView src: MIImageView) {
                let curframe = currentFrame()
                updateSize(view: src, size: curframe.size)

                guard let img = src.image else {
                        return
                }
                let parentsz = curframe.size
                let imgsz    = img.size
                if parentsz.width != imgsz.width || parentsz.height != imgsz.height {
                        /* update image size */
                        src.explicitContentsSize = parentsz
                }
                src.frame.size  = parentsz
                src.bounds.size = parentsz
        }

        public override func visit(label src: MILabel) {
                let curframe = currentFrame()
                updateSize(view: src, size: curframe.size)
        }

        public override func visit(popupMenu src: MIPopupMenu) {
                let curframe = currentFrame()
                updateSize(view: src, size: curframe.size)
        }

        public override func visit(segmentedControl src: MISegmentedControl) {
                let curframe = currentFrame()
                updateSize(view: src, size: curframe.size)
        }

        public override func visit(stack src: MIStack) {
                let curframe = currentFrame()
                updateSize(view: src, size: curframe.size)

                let count = src.arrangedSubviews.count
                guard count > 0 else {
                        return
                }
                switch src.axis {
                case .vertical:
                        visitVerticalStack(tack: src)
                case .horizontal:
                        visitHorizontalStack(tack: src)
                @unknown default:
                        NSLog("[Error] Must be override \(#function) at \(#file)")
                }
        }

        private func visitHorizontalStack(tack src: MIStack) {
                let curframe = currentFrame()
                let spacing  = src.spacing
                let count    = src.arrangedSubviews.count

                let curheight = curframe.size.height
                let curwidth  = curframe.size.width
                let subheight = max(curheight, 0.0)
                let subwidth  = max(curwidth  - spacing * CGFloat(count - 1), 0.0) / CGFloat(count)

                var subframe  = CGRect(x: 0.0, y: 0.0, width: subwidth, height: subheight)
                for subview in src.arrangedSubviews {
                        updateOrigin(view: subview, point: subframe.origin)
                        pushCurrentFrame(frame: subframe)
                        subview.accept(visitor: self)
                        popCurrentFrame()
                        subframe.origin.x += subwidth + spacing
                }
        }

        private func visitVerticalStack(tack src: MIStack) {
                let curframe = currentFrame()
                let spacing  = src.spacing
                let count    = src.arrangedSubviews.count

                let curheight = curframe.size.height
                let curwidth  = curframe.size.width
                let subheight = max(curheight - spacing * CGFloat(count - 1), 0.0) / CGFloat(count)
                let subwidth  = max(curwidth, 0.0)

                var subframe  = CGRect(x: 0.0, y: 0.0, width: subwidth, height: subheight)
                for subview in src.arrangedSubviews.reversed() {
                        updateOrigin(view: subview, point: subframe.origin)
                        pushCurrentFrame(frame: subframe)
                        subview.accept(visitor: self)
                        popCurrentFrame()
                        subframe.origin.y += subheight + spacing
                }
        }

        public override func visit(switchView src: MISwitch) {
                let curframe = currentFrame()
                updateSize(view: src, size: curframe.size)
        }

        public override func visit(table src: MITable) {
                let curframe = currentFrame()
                updateSize(view: src, size: curframe.size)
        }

        public override func visit(textField src: MITextField) {
                let curframe = currentFrame()
                updateSize(view: src, size: curframe.size)
        }

        public override func visit(textView src: MITextView) {
                let curframe = currentFrame()
                updateSize(view: src, size: curframe.size)
        }

        public override func visit(webView src: MIWebView) {
                let curframe = currentFrame()
                updateSize(view: src, size: curframe.size)
        }
}

