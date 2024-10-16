/*
 * @file MIInterfaceView.swift
 * @description Define MIInterfaceView class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

public class MIInterfaceView: MIBaseView
{
        private var mCoreView: MICoreView? = nil
        
        public func coreView<T>() -> T? {
                return mCoreView as? T
        }
        
        #if os(OSX)
        public override init(frame : NSRect){
                super.init(frame: frame)
                setup(frame: frame)
        }
        #else
        public override init(frame: CGRect){
                super.init(frame: frame)
                setup(frame: frame)
        }
        #endif

        public convenience init(){
                let frame = CGRect(x: 0.0, y: 0.0, width: 160, height: 32)
                self.init(frame: frame)
        }

        public required init?(coder: NSCoder) {
                super.init(coder: coder)
                setup(frame: self.frame)
        }
        
        open func setup(frame frm: CGRect) {
                NSLog("Must be override")
        }
        
        public func setup(nibName nm: String, frameSize size: CGSize) {
                guard let child = loadChildXib(thisClass: MIInterfaceView.self, nibName: nm) else {
                        NSLog("Failed to load bundle: \(nm)")
                        return
                }
                child.setup()

                self.addSubview(child)
                allocateSubviewLayout(subView: child)
                
                mCoreView = child
                setFrameSize(size)
        }

        private func loadChildXib(thisClass tc: AnyClass, nibName nn: String) -> MICoreView? {
                let bundle : Bundle = Bundle(for: tc) ;
                #if os(iOS)
                let nib = UINib(nibName: nn, bundle: bundle)
                let views = nib.instantiate(withOwner: nil, options: nil)
                for view in views {
                        if let v = view as? MICoreView {
                                return v ;
                        }
                }
                #else   // os(iOS)
                if let nib = NSNib(nibNamed: nn, bundle: bundle) {
                        var viewsp : NSArray? = NSArray()
                        if(nib.instantiate(withOwner: nil, topLevelObjects: &viewsp)){
                                if let views = viewsp {
                                        for view in views {
                                                if let v = view as? MICoreView {
                                                        return v ;
                                                }
                                        }
                                }
                        }
                }
                #endif
                return nil
        }
        
        public func allocateSubviewLayout(subView sview: MICoreView){
                sview.translatesAutoresizingMaskIntoConstraints = false
                addConstraint(MIInterfaceView.allocateLayout(fromView: sview,  toView: self,   attribute: .top,    length: 0.0)) ;
                addConstraint(MIInterfaceView.allocateLayout(fromView: sview,  toView: self,   attribute: .left,   length: 0.0)) ;
                addConstraint(MIInterfaceView.allocateLayout(fromView: self,   toView: sview,  attribute: .bottom, length: 0.0)) ;
                addConstraint(MIInterfaceView.allocateLayout(fromView: self,   toView: sview,  attribute: .right,  length: 0.0)) ;
        }
        
        private class func allocateLayout(fromView fview : MIBaseView, toView tview: MIBaseView, attribute attr: NSLayoutConstraint.Attribute, length len: CGFloat) -> NSLayoutConstraint {
                return NSLayoutConstraint(item: fview, attribute: attr, relatedBy: NSLayoutConstraint.Relation.equal, toItem: tview, attribute: attr, multiplier: 1.0, constant: len) ;
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
}
