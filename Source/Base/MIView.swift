/*
 * @file MIView.swift
 * @description Define MIView class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

public class MIView: MIBaseView
{
        private var mCoreView: MIBaseView? = nil

        public func setup(nibName nm: String) -> NSError? {
                guard let child = loadChildXib(thisClass: MIView.self, nibName: nm) else {
                        return MIError.error(errorCode: .bundleError, message: "Failed to load resource: \(nm)")
                }
                allocateSubviewLayout(subView: child)
                mCoreView = child
                return nil
        }

        private func loadChildXib(thisClass tc: AnyClass, nibName nn: String) -> MIBaseView? {
                let bundle : Bundle = Bundle(for: tc) ;
                #if os(iOS)
                let nib = UINib(nibName: nn, bundle: bundle)
                let views = nib.instantiate(withOwner: nil, options: nil)
                for view in views {
                        if let v = view as? UIView {
                                return v ;
                        }
                }
                #else   // os(iOS)
                if let nib = NSNib(nibNamed: nn, bundle: bundle) {
                        var viewsp : NSArray? = NSArray()
                        if(nib.instantiate(withOwner: nil, topLevelObjects: &viewsp)){
                                if let views = viewsp {
                                        for view in views {
                                                if let v = view as? MIBaseView {
                                                        return v ;
                                                }
                                        }
                                }
                        }
                }
                #endif
                return nil
        }
        
        public func allocateSubviewLayout(subView sview: MIBaseView){
                sview.translatesAutoresizingMaskIntoConstraints = false
                addConstraint(MIView.allocateLayout(fromView: sview,  toView: self,   attribute: .top,    length: 0.0)) ;
                addConstraint(MIView.allocateLayout(fromView: sview,  toView: self,   attribute: .left,   length: 0.0)) ;
                addConstraint(MIView.allocateLayout(fromView: self,   toView: sview,  attribute: .bottom, length: 0.0)) ;
                addConstraint(MIView.allocateLayout(fromView: self,   toView: sview,  attribute: .right,  length: 0.0)) ;
        }
        
        private class func allocateLayout(fromView fview : MIBaseView, toView tview: MIBaseView, attribute attr: NSLayoutConstraint.Attribute, length len: CGFloat) -> NSLayoutConstraint {
                return NSLayoutConstraint(item: fview, attribute: attr, relatedBy: NSLayoutConstraint.Relation.equal, toItem: tview, attribute: attr, multiplier: 1.0, constant: len) ;
        }
}
