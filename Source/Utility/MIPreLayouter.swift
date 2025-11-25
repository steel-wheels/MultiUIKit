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
                layouter.pushCurrentFrame(frame: root.frame)
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

        private func adjustFrame(view v: MIInterfaceView) {
                let curframe = currentFrame()
                v.frame  = curframe
                v.bounds = CGRect(origin: CGPoint.zero, size: curframe.size)
        }

        public override func visit(button src: MIButton) {
                adjustFrame(view: src)
        }

        public override func visit(collectionView src: MICollectionView) {
                adjustFrame(view: src)
        }

        public override func visit(dropView src: MIDropView) {
                adjustFrame(view: src)

                let content = src.contentsView
                pushCurrentFrame(frame: content.frame)
                content.accept(visitor: self)
                popCurrentFrame()
        }

        public override func visit(fileSelector src: MIFileSelector) {
                adjustFrame(view: src)
        }

        #if os(OSX)
        public override func visit(iconView src: MIIconView) {
                adjustFrame(view: src)
        }
        #endif

        public override func visit(imageView src: MIImageView) {
                adjustFrame(view: src)
                guard let img = src.image else {
                        return
                }
                let parentsz = currentFrame().size
                let imgsz    = img.size
                if parentsz.width != imgsz.width || parentsz.height != imgsz.height {
                        /* update image size */
                        src.set(contentSize: parentsz)
                }
                src.frame.size  = parentsz
                src.bounds.size = parentsz
        }

        public override func visit(label src: MILabel) {
                adjustFrame(view: src)
        }

        public override func visit(popupMenu src: MIPopupMenu) {
                adjustFrame(view: src)
        }

        public override func visit(segmentedControl src: MISegmentedControl) {
                adjustFrame(view: src)
        }

        public override func visit(stack src: MIStack) {
                adjustFrame(view: src)
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
                let subheight = max(curheight - spacing * 2.0, 0.0)
                let subwidth  = max(curwidth  - spacing * CGFloat(count + 1), 0.0) / CGFloat(count)

                var subframe  = CGRect(x: spacing, y: spacing, width: subwidth, height: subheight)
                for subview in src.arrangedSubviews {
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
                let subheight = max(curheight - spacing * CGFloat(count + 1), 0.0) / CGFloat(count)
                let subwidth  = max(curwidth  - spacing * 2.0, 0.0)

                var subframe  = CGRect(x: spacing, y: spacing, width: subwidth, height: subheight)
                for subview in src.arrangedSubviews {
                        pushCurrentFrame(frame: subframe)
                        subview.accept(visitor: self)
                        popCurrentFrame()
                        subframe.origin.y += subheight + spacing
                }
        }

        public override func visit(switchView src: MISwitch) {
                adjustFrame(view: src)
        }

        public override func visit(table src: MITable) {
                adjustFrame(view: src)
        }

        public override func visit(textField src: MITextField) {
                adjustFrame(view: src)
        }

        public override func visit(textView src: MITextView) {
                adjustFrame(view: src)
        }

        public override func visit(webView src: MIWebView) {
                adjustFrame(view: src)
        }
}

