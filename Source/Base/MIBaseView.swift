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

        #if os(OSX)
        @objc open var backgroundColor: MIColor? {
                get {
                        if let layer = self.layer {
                                if let col = layer.backgroundColor {
                                        return NSColor(cgColor: col)
                                }
                        }
                        return nil
                }
                set(colp){
                        if let layer = self.layer {
                                if let col = colp {
                                        layer.backgroundColor = col.cgColor
                                } else {
                                        layer.backgroundColor = nil
                                }
                        }
                }
        }
        #endif // os(OSX)

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

        func allocateSubviewLayout(axis axs: LayoutOrientation, childView child: MIBaseView, space spc: CGFloat){
                child.translatesAutoresizingMaskIntoConstraints = false
                switch axs {
                case .horizontal:
                        addLeftSideConstraint(childView:  child, space: spc)
                        addRightSideConstraint(childView: child, space: spc)
                case .vertical:
                        addTopSideConstraint(childView: child, space: spc)
                        addBottomSideConstraint(childView: child, space: spc)
                @unknown default:
                        NSLog("[Error] Can not happen at \(#function) in \(#file)")
                }
        }

        func addLeftSideConstraint(childView cview: MIBaseView, space spc: CGFloat) {
                let constr = NSLayoutConstraint(item: self,
                                                attribute: NSLayoutConstraint.Attribute.leading,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: cview,
                                                attribute: NSLayoutConstraint.Attribute.leading,
                                                multiplier: 1.0,
                                                constant: spc)
                self.addConstraint(constr)
        }

        func addRightSideConstraint(childView cview: MIBaseView, space spc: CGFloat) {
                let constr = NSLayoutConstraint(item: self,
                                                attribute: NSLayoutConstraint.Attribute.trailing,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: cview,
                                                attribute: NSLayoutConstraint.Attribute.trailing,
                                                multiplier: 1.0,
                                                constant: spc)
                self.addConstraint(constr)
        }

        func addTopSideConstraint(childView cview: MIBaseView, space spc: CGFloat) {
                let constr = NSLayoutConstraint(item: self,
                                                attribute: NSLayoutConstraint.Attribute.top,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: cview,
                                                attribute: NSLayoutConstraint.Attribute.top,
                                                multiplier: 1.0,
                                                constant: spc)
                self.addConstraint(constr)
        }

        func addBottomSideConstraint(childView cview: MIBaseView, space spc: CGFloat) {
                let constr = NSLayoutConstraint(item: self,
                                                attribute: NSLayoutConstraint.Attribute.bottom,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: cview,
                                                attribute: NSLayoutConstraint.Attribute.bottom,
                                                multiplier: 1.0,
                                                constant: spc)
                self.addConstraint(constr)
        }

        func removeAllConstraints() {
                self.removeConstraints(self.constraints)
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

