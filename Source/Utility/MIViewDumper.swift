/**
 * @file MIViewDumper.swift
 * @brief  Define MIViewDumper class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

#if os(OSX)
import AppKit
#else
import UIKit
#endif
import Foundation

public class MIViewDumper: MIVisitor
{
        private var mIndent: Int

        public override init() {
                mIndent         = 0
        }

        private func dump(view v: MIInterfaceView) {
                let spaces    = generateSpaces()
                let className = String(describing: type(of: v))
                let tag       = v.tag
                let framestr  = v.frame.description
                let boundsstr = v.bounds.description
                NSLog(spaces + "\(className) tag:\(tag) frame:\(framestr) bounds:\(boundsstr)")
        }

        private func dump(image img: MIImage) {
                let spaces    = generateSpaces()
                let imgstr    = img.size.description
                NSLog(spaces + "[image] size \(imgstr)")
        }

        private func generateSpaces() -> String {
                var spaces = ""
                for _ in 0..<mIndent { spaces += "  " }
                return spaces
        }

        public override func visit(button src: MIButton) {
                dump(view: src)
        }

        public override func visit(collectionView src: MICollectionView) {
                dump(view: src)
        }

        public override func visit(dropView src: MIDropView) {
                dump(view: src)
                mIndent += 1
                src.contentsView.accept(visitor: self)
                mIndent -= 1
        }

        public override func visit(fileSelector src: MIFileSelector) {
                dump(view: src)
        }

        #if os(OSX)
        public override func visit(iconView src: MIIconView) {
                dump(view: src)
        }
        #endif

        public override func visit(imageView src: MIImageView) {
                dump(view: src)
                mIndent += 1
                if let img = src.image {
                        dump(image: img)
                }
                mIndent -= 1
        }

        public override func visit(label src: MILabel) {
                dump(view: src)
        }

        public override func visit(popupMenu src: MIPopupMenu) {
                dump(view: src)
        }

        public override func visit(segmentedControl src: MISegmentedControl) {
                dump(view: src)
        }

        public override func visit(stack src: MIStack) {
                dump(view: src)

                mIndent += 1
                for child in src.arrangedSubviews {
                        child.accept(visitor: self)
                }
                mIndent -= 1
        }

        public override func visit(switchView src: MISwitch) {
                dump(view: src)
        }

        public override func visit(table src: MITable) {
                dump(view: src)
        }

        public override func visit(textField src: MITextField) {
                dump(view: src)
        }

        public override func visit(textView src: MITextView) {
                dump(view: src)
        }

        public override  func visit(webView src: MIWebView) {
                dump(view: src)
        }
}

