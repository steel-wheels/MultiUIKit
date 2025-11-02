/**
 * @file MIPreLayput.swift
 * @brief  Define MIPreLayout class
 * @par Copyright
 *   Copyright (C) 2021-2025 Steel Wheels Project
 */

import Foundation

public class MIPreLayouter: MIVisitor
{
        private struct ParentView {
                public var parentView:          MIInterfaceView
                public var contentSize:         CGSize

                public init(parentView view: MIInterfaceView, contentSize csize: CGSize) {
                        self.parentView  = view
                        self.contentSize = csize
                }
        }

        private var mViewStack:         Array<ParentView>

        public override init() {
                mViewStack      = []
        }

        public func layout(rootView root: MIStack) {
                push(parentView: root, size: root.frame.size)
                root.accept(visitor: self)
                pop()
        }

        private func currentParentView() -> ParentView {
                if let view = mViewStack.last {
                        return view
                } else {
                        fatalError("[Fatal] Can not happen 1 at \(#file)")
                }
        }

        private func push(parentView pview: MIInterfaceView, size sz: CGSize){
                mViewStack.append(ParentView(parentView: pview, contentSize: sz))
        }

        private func pop(){
                if mViewStack.count > 0 {
                        let _ = mViewStack.removeLast()
                } else {
                        fatalError("[Fatal] Can not happen 2 at \(#file)")
                }
        }

        public override func visit(button src: MIButton) {
                /* nothing have to do */
        }

        public override func visit(collectionView src: MICollectionView) {
                /* nothing have to do */
        }

        public override func visit(dropView src: MIDropView) {
                src.contentsView.accept(visitor: self)
        }

        public override func visit(fileSelector src: MIFileSelector) {
                /* nothing have to do */
        }

        #if os(OSX)
        public override func visit(iconView src: MIIconView) {
                /* nothing have to do */
        }
        #endif

        public override func visit(imageView src: MIImageView) {
                if let img = src.image {
                        let size = img.size
                        NSLog("image size: width=\(size.width) height=\(size.height)")
                } else {
                        NSLog("image size: width=none height=none")
                }

                let isize = src.intrinsicContentSize
                NSLog("content size: width=\(isize.width) height=\(isize.height)")
        }

        public override func visit(label src: MILabel) {
                /* nothing have to do */
        }

        public override func visit(popupMenu src: MIPopupMenu) {
                /* nothing have to do */
        }

        public override func visit(segmentedControl src: MISegmentedControl) {
                /* nothing have to do */
        }

        public override func visit(stack src: MIStack) {
                let childnum = src.arrangedSubviews.count
                if childnum == 0 {
                        return
                }
                let psize = currentParentView().contentSize
                let childwidth, childheigt : CGFloat
                switch src.axis {
                case .vertical:
                        childwidth = psize.width
                        childheigt = psize.height / CGFloat(childnum)
                case .horizontal:
                        childwidth = psize.width  / CGFloat(childnum)
                        childheigt = psize.height
                @unknown default:
                        NSLog("[Error] Can not happen 3 at \(#file)")
                        childwidth = psize.width
                        childheigt = psize.height
                }
                push(parentView: src, size: CGSize(width: childwidth, height: childheigt))
                for child in src.arrangedSubviews {
                        child.accept(visitor: self)
                }
                pop()
        }

        public override func visit(switchView src: MISwitch) {
                /* nothing have to do */
        }

        public override func visit(table src: MITable) {
                /* nothing have to do */
        }

        public override func visit(textField src: MITextField) {
                /* nothing have to do */
        }

        public override func visit(textView src: MITextView) {
                /* nothing have to do */
        }

        public override func visit(webView src: MIWebView) {
                /* nothing have to do */
        }
}
