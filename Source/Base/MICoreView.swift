/*
 * @file MICoreView.swift
 * @description Define MICoreView class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

public class MICoreView: MIBaseView
{
        private var mCoreView:  MIBaseView?             = nil

        open func setup() {
                NSLog("Must be override: MICoreView")
        }

        public func setup(coreView core: MIBaseView) {
                mCoreView  = core
                self.activateAutolayout()
                core.activateAutolayout()
        }

        #if os(iOS)
        public func setFrameSize(_ newsize: CGSize) {
                self.frame.size = newsize
                if let core = mCoreView {
                        core.frame.size = newsize
                }
        }
        #else // os(iOS)
        public override func setFrameSize(_ newsize: NSSize) {
                super.setFrameSize(newsize)
                if let core = mCoreView {
                        core.setFrameSize(newsize)
                }
        }
        #endif // os(iOS)

        public override var intrinsicContentSize: CGSize { get {
                if let core = mCoreView {
                        return core.intrinsicContentSize
                } else {
                        NSLog("Failed to get core")
                        return super.intrinsicContentSize
                }
        }}

        public override func invalidateIntrinsicContentSize() {
                if let core = mCoreView {
                        core.invalidateIntrinsicContentSize()
                }
                super.invalidateIntrinsicContentSize()
        }

        public override func setContentHuggingPriority(_ priority: LayoutPriority , for axis: LayoutOrientation) {
                super.setContentHuggingPriority(priority, for: axis)
                if let core = mCoreView {
                        core.setContentHuggingPriority(priority, for: axis)
                }
        }

        public override func setContentCompressionResistancePriority(_ priority: LayoutPriority, for axis: LayoutOrientation) {
                super .setContentCompressionResistancePriority(priority, for: axis)
                if let core = mCoreView {
                        core.setContentCompressionResistancePriority(priority, for: axis)
                }
        }
}

