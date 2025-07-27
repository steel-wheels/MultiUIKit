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
        public typealias Distribution = UIStackView.Distribution
        #else
        public typealias Distribution = NSStackView.Distribution
        #endif

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
                #if os(iOS)
                mStack.alignment = .fill
                #else
                mStack.alignment = .width
                #endif
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

        public var distribution: Distribution {
                get         { return mStack.distribution }
                set(newval) { mStack.distribution = newval }
        }

        public func addArrangedSubView(_ view: MIInterfaceView) {
                mStack.addArrangedSubview(view)
                switch self.axis {
                case .horizontal:
                        MIBaseView.allocateSubviewLayout(axis: .vertical, parentView: mStack, childView: view, space: 0.0)
                        view.setContentExpansionPriority(.defaultLow, for: .horizontal)
                case .vertical:
                        MIBaseView.allocateSubviewLayout(axis: .horizontal, parentView: mStack, childView: view, space: 0.0)
                        view.setContentExpansionPriority(.defaultLow, for: .vertical)
                @unknown default:
                        NSLog("[Error] Unknown case")
                }
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

        public func removeAllSubviews() {
                #if os(OSX)
                while mStack.views.count > 0 {
                        mStack.removeView(mStack.views[0])
                }
                #else
                while mStack.arrangedSubviews.count > 0 {
                        mStack.removeArrangedSubview(mStack.arrangedSubviews[0])
                }
                #endif
        }
}

