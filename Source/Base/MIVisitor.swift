/**
 * @file MIVisitor.swift
 * @brief  Define MIVisitor class
 * @par Copyright
 *   Copyright (C) 2021-2025 Steel Wheels Project
 */

import Foundation

@MainActor open class MIVisitor
{
        public init() {
        }

        open func visit(button src: MIButton) {
                NSLog("[Error] Must be override \(#function) at \(#file)")
        }

        open func visit(collectionView src: MICollectionView) {
                NSLog("[Error] Must be override \(#function) at \(#file)")
        }

        open func visit(dropView src: MIDropView) {
                NSLog("[Error] Must be override \(#function) at \(#file)")
        }

        open func visit(fileSelector src: MIFileSelector) {
                NSLog("[Error] Must be override \(#function) at \(#file)")
        }

        #if os(OSX)
        open func visit(iconView src: MIIconView) {
                NSLog("[Error] Must be override \(#function) at \(#file)")
        }
        #endif

        open func visit(imageView src: MIImageView) {
                NSLog("[Error] Must be override \(#function) at \(#file)")
        }

        open func visit(label src: MILabel) {
                NSLog("[Error] Must be override \(#function) at \(#file)")
        }

        open func visit(popupMenu src: MIPopupMenu) {
                NSLog("[Error] Must be override \(#function) at \(#file)")
        }

        open func visit(segmentedControl src: MISegmentedControl) {
                NSLog("[Error] Must be override \(#function) at \(#file)")
        }

        open func visit(stack src: MIStack) {
                NSLog("[Error] Must be override \(#function) at \(#file)")
        }

        open func visitAllSubviews(stack src: MIStack) {
                let subviews = src.arrangedSubviews
                for subview in subviews {
                        subview.accept(visitor: self)
                }
        }

        open func visit(switchView src: MISwitch) {
                NSLog("[Error] Must be override \(#function) at \(#file)")
        }

        open func visit(table src: MITable) {
                NSLog("[Error] Must be override \(#function) at \(#file)")
        }

        open func visit(textField src: MITextField) {
                NSLog("[Error] Must be override \(#function) at \(#file)")
        }

        open func visit(textView src: MITextView) {
                NSLog("[Error] Must be override \(#function) at \(#file)")
        }

        open func visit(webView src: MIWebView) {
                NSLog("[Error] Must be override \(#function) at \(#file)")
        }
}

