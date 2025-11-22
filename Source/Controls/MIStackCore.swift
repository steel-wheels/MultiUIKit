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
        }

        public func insertArrangedSubView(_ view: MIInterfaceView, at index: Int) {
                mStack.insertArrangedSubview(view, at: index)
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

        public func insertConstraints(space spc: CGFloat) {
                let subviews = self.arrangedSubviews
                let count    = subviews.count
                guard count > 0 else {
                        return // nothing have to do
                }
                switch self.axis {
                case .vertical:
                        insertConstraintsForVerticalStack(subviews: subviews, space: spc)
                case .horizontal:
                        insertConstraintsForHolizontalStack(subviews: subviews, space: spc)
                @unknown default:
                        NSLog("[Error] Can not happen at \(#file)")
                }
        }

        private func insertConstraintsForHolizontalStack(subviews: Array<MIInterfaceView>, space spc: CGFloat) {
                /* left side */
                if let firstview = subviews.first {
                        mStack.addLeftSideConstraint(childView: firstview, space: spc)
                }
                /* right side */
                if let lastview = subviews.last {
                        mStack.addRightSideConstraint(childView: lastview, space: spc)
                }
                /* middle */
                var prevview: MIInterfaceView = subviews[0]
                for i in 1..<subviews.count {
                        let curview = subviews[i]
                        mStack.addInterConstraint(leftView: prevview, rightView: curview, space: spc)
                        prevview = curview
                }
                /* vertical constraings */
                for subview in subviews {
                        mStack.addTopSideConstraint(childView: subview, space: spc)
                        mStack.addBottomSideConstraint(childView: subview, space: spc)
                }
        }

        private func insertConstraintsForVerticalStack(subviews: Array<MIInterfaceView>, space spc: CGFloat) {
                /* top side */
                if let firstview = subviews.first {
                        mStack.addTopSideConstraint(childView: firstview, space: spc)
                }
                /* bottom side */
                if let lastview = subviews.last {
                        mStack.addBottomSideConstraint(childView: lastview, space: spc)
                }
                /* middle */
                var prevview: MIInterfaceView = subviews[0]
                for i in 1..<subviews.count {
                        let curview = subviews[i]
                        mStack.addInterConstraint(upperView: prevview, lowerView: curview, space: spc)
                        prevview = curview
                }
                /* holizontal constraings */
                for subview in subviews {
                        mStack.addLeftSideConstraint(childView: subview, space: spc)
                        mStack.addRightSideConstraint(childView: subview, space: spc)
                }
        }
}

