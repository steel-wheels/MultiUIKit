/*
 * @file MIStackViewController.swift
 * @description Define MIStackViewController class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

open class MIStackViewController: MIViewController
{
        private var mRootView: MIStack? = nil

        public var root: MIStack { get {
                if let stack = mRootView {
                        return stack
                } else {
                        fatalError("Root stack is not set")
                }
        }}

        public func setup(axis axs: MIStackCore.Axis) {
                let root  = MIStack()
                root.axis = axs
                self.view.addSubview(root)
                MIBaseView.allocateSubviewLayout(axis: .horizontal, parentView: self.view, childView: root, space: 0.0)
                MIBaseView.allocateSubviewLayout(axis: .vertical, parentView: self.view, childView: root, space: 0.0)
                mRootView = root
        }
}

