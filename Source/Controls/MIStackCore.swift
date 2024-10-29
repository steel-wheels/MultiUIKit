/*
 * @file MIStackCore.swift
 * @description Define MIStackCore class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

public class MIStackCore: MICoreView
{
        #if os(iOS)
        public typealias Axis = NSLayoutConstraint.Axis
        #else
        public typealias Axis = NSUserInterfaceLayoutOrientation
        #endif

        #if os(iOS)
        @IBOutlet weak var mStack: UIStackView!
        #else
        @IBOutlet weak var mStack: NSStackView!
        #endif

        open override func setup() {
                super.setup(coreView: mStack)
        }

        public var axis: Axis {
                get {
                        #if os(iOS)
                                return mStack.axis
                        #else
                                return mStack.orientation
                        #endif
                }
                set(value){
                        #if os(iOS)
                                mStack.axis = value
                        #else
                                mStack.orientation = value
                        #endif
                }
        }

        public func addSubView(_ view: MIInterfaceView) {
                #if os(OSX)
                mStack.addArrangedSubview(view)
                #else
                mStack.addArrangedSubview(view)
                #endif
        }

        public var arrangedSubviews: Array<MIInterfaceView> { get {
                var result: Array<MIInterfaceView> = []
                for subview in mStack.arrangedSubviews {
                        if let ifview = subview as? MIInterfaceView {
                                result.append(ifview)
                        } else {
                                NSLog("Failed to get interface view")
                        }
                }
                return result
        }}
}

