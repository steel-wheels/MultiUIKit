/*
 * @file MIBaseView.swift
 * @description Define MIBaseView class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

#if os(OSX)
public typealias MIBaseView = NSView
#else  // os(OSX)
public typealias MIBaseView = UIView
#endif // os(OSX)

public let MINullTagId : Int     = -1
public let MITagBits:    Int     = 1

public func MICoreTagToInterfaceTag(coreTag tag: Int) -> Int {
        return tag != MINullTagId ? tag & ~MITagBits : MINullTagId
}

public func MIInterfaceTagToCoreTag(interfaceTag tag: Int) -> Int {
        return tag != MINullTagId ? tag | MITagBits : MINullTagId
}

public extension MIBaseView
{
        enum ExpansionPriority {
                case high
                case low
        }

        #if os(iOS)
        typealias LayoutPriority    = UILayoutPriority
        typealias LayoutOrientation = NSLayoutConstraint.Axis
        #else
        typealias LayoutPriority    = NSLayoutConstraint.Priority
        typealias LayoutOrientation = NSLayoutConstraint.Orientation
        #endif

        func activateAutolayout() {
                self.translatesAutoresizingMaskIntoConstraints = false
                self.autoresizesSubviews = true
        }

        func requireLayout() {
                #if os(OSX)
                        self.needsLayout = true
                #else
                        self.setNeedsLayout()
                #endif
        }

        func requireDisplay() {
                #if os(OSX)
                        self.needsDisplay = true
                #else
                        self.setNeedsDisplay()
                #endif
        }

        func addLeftSideConstraint(childView child: MIBaseView, space spc: CGFloat) {
                let constr = NSLayoutConstraint(item: child, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: spc)
                addConstraint(constr)
        }

        func addRightSideConstraint(childView child: MIBaseView, space spc: CGFloat) {
                let constr = NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: child, attribute: .right, multiplier: 1.0, constant: spc)
                addConstraint(constr)
        }

        func addTopSideConstraint(childView child: MIBaseView, space spc: CGFloat) {
                let constr = NSLayoutConstraint(item: child, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: spc)
                addConstraint(constr)
        }

        func addBottomSideConstraint(childView child: MIBaseView, space spc: CGFloat) {
                let constr = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: child, attribute: .bottom, multiplier: 1.0, constant: spc)
                addConstraint(constr)
        }

        func addInterConstraint(upperView uview: MIBaseView, lowerView lview: MIBaseView, space spc: CGFloat){
                let constr = NSLayoutConstraint(item: uview, attribute: .bottom, relatedBy: .equal, toItem: lview, attribute: .top, multiplier: 1.0, constant: spc)
                addConstraint(constr)
        }

        func addInterConstraint(leftView lview: MIBaseView, rightView rview: MIBaseView, space spc: CGFloat){
                let constr = NSLayoutConstraint(item: lview, attribute: .right, relatedBy: .equal, toItem: rview, attribute: .left, multiplier: 1.0, constant: spc)
                addConstraint(constr)
        }

        func setContentExpansionPriority(_ priority: ExpansionPriority, for axs: LayoutOrientation) {
                let hugging:    LayoutPriority
                let registance: LayoutPriority
                switch priority {
                case .low:
                        hugging    = .defaultHigh
                        registance = .defaultHigh
                case .high:
                        hugging    = .defaultLow
                        registance = .defaultLow
                }
                setContentHuggingPriority(hugging, for: axs)
                setContentCompressionResistancePriority(registance, for: axs)
        }
}

