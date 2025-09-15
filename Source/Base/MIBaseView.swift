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

        class func allocateSubviewLayout(axis axs: LayoutOrientation, parentView parent: MIBaseView, childView child: MIBaseView, space spc: CGFloat){
                child.translatesAutoresizingMaskIntoConstraints = false
                switch axs {
                case .horizontal:
                        parent.addConstraint(allocateLayout(fromView: child, toView: parent, attribute: .left, length: spc))
                        parent.addConstraint(allocateLayout(fromView: parent, toView: child, attribute: .right, length: spc))
                case .vertical:
                        parent.addConstraint(allocateLayout(fromView: child, toView: parent, attribute: .top, length: spc))
                        parent.addConstraint(allocateLayout(fromView: parent, toView: child, attribute: .bottom, length: spc))
                @unknown default:
                        NSLog("[Error] Can not happen at \(#function) in \(#file)")
                }
        }

        class func allocateLayout(fromView fview : MIBaseView, toView tview: MIBaseView, attribute attr: NSLayoutConstraint.Attribute, length len: CGFloat) -> NSLayoutConstraint {
                return NSLayoutConstraint(item: fview, attribute: attr, relatedBy: NSLayoutConstraint.Relation.equal, toItem: tview, attribute: attr, multiplier: 1.0, constant: len) ;
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

