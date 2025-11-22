/**
 * @file MIConstraintInserter.swift
 * @brief  Define MIConstraintInserter class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

import Foundation

public class MIConstraintInserter: MIVisitor
{
        private var mSpace: CGFloat

        static public func insertConstraints(view v: MIInterfaceView, space spc: CGFloat) {
                let inserter = MIConstraintInserter(space: spc)
                v.accept(visitor: inserter)
        }

        public init(space spc: CGFloat) {
                mSpace = spc
        }

        public override func visit(button src: MIButton) {
        }

        public override func visit(collectionView src: MICollectionView) {
        }

        public override func visit(dropView src: MIDropView) {
                src.contentsView.accept(visitor: self)
        }

        public override func visit(fileSelector src: MIFileSelector) {
        }

        #if os(OSX)
        public override func visit(iconView src: MIIconView) {
        }
        #endif

        public override func visit(imageView src: MIImageView) {
        }

        public override func visit(label src: MILabel) {
        }

        public override func visit(popupMenu src: MIPopupMenu) {
        }

        public override func visit(segmentedControl src: MISegmentedControl) {
        }

        public override func visit(stack src: MIStack) {
                for subview in src.arrangedSubviews {
                        subview.accept(visitor: self)
                }
                src.insertConstraints(space: mSpace)
        }

        public override func visit(switchView src: MISwitch) {
        }

        public override func visit(table src: MITable) {
        }

        public override func visit(textField src: MITextField) {
        }

        public override func visit(textView src: MITextView) {
        }

        public override func visit(webView src: MIWebView) {
        }
}
