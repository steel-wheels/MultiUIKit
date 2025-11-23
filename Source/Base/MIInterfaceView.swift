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

open class MIInterfaceView: MIBaseView
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
                NSLog("[Error] Must be override in \(#file)")
        }

        public func setup(nibName nm: String, frameSize size: CGSize) {
                if let child = loadChildXib(thisClass: MIInterfaceView.self, nibName: nm)  {
                        child.setup()
                        self.addSubview(child)
                        child.activateAutolayout()
                        allocateSubviewLayout(subView: child)
                        mCoreView = child
                        setFrameSize(size)
                } else {
                        NSLog("[Error] Failed to load bundle: \(nm) in \(#file)")
                }
                self.activateAutolayout()
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

        public func set(contentSize csize: CGSize){
                if let core = mCoreView {
                        core.set(contentSize: csize)
                        self.invalidateIntrinsicContentSize()
                } else {
                        NSLog("[Error] No core view at \(#function) in \(#file)")
                }
        }

        public func allocateSubviewLayout(subView sview: MICoreView){
                sview.translatesAutoresizingMaskIntoConstraints = false
                let space: CGFloat = 0.0
                allocateSubviewLayout(axis: .horizontal, childView: sview, space: space)
                allocateSubviewLayout(axis: .vertical, childView: sview, space: space)
        }

        public override var tag: Int {
                get {
                        if let core = mCoreView {
                                return MICoreTagToInterfaceTag(coreTag: core.tag)
                        } else {
                                return MINullTagId
                        }
                }
                set(val){
                        if let core = mCoreView {
                                core.tag = MIInterfaceTagToCoreTag(interfaceTag: val)
                        } else {
                                NSLog("[Error] No core view at \(#function)  in \(#file)")
                        }
                }
        }

        #if os(OSX)

        public override func setFrameSize(_ newsize: NSSize) {
                super.setFrameSize(newsize)
                if let core = mCoreView {
                        core.setFrameSize(newsize)
                }
        }

        public override func setFrameOrigin(_ neworigin: NSPoint) {
                super.setFrameOrigin(neworigin)
                if let core = mCoreView {
                        core.setFrameOrigin(neworigin)
                }
        }

        #else

        public override var frame: CGRect {
                get     { return super.frame }
                set(newval) {
                        super.frame = newval
                        if let core = mCoreView {
                                core.frame = newval
                        }
                }
        }

        #endif


        #if os(iOS)
        public func setFrameSize(_ newsize: CGSize) {
                self.frame.size = newsize
                if let core = mCoreView {
                        core.frame.size = newsize
                }
        }
        #else // os(iOS)

        #endif // os(iOS)
        
        open override var intrinsicContentSize: CGSize { get {
                if let core = mCoreView {
                        return core.intrinsicContentSize
                } else {
                        return super.intrinsicContentSize
                }
        }}

        public override func invalidateIntrinsicContentSize() {
                if let core = mCoreView {
                        core.invalidateIntrinsicContentSize()
                }
                super.invalidateIntrinsicContentSize()
        }

        public typealias LayoutPriority    = MICoreView.LayoutPriority
        public typealias LayoutOrientation = MICoreView.LayoutOrientation

        public override func setContentHuggingPriority(_ priority: LayoutPriority , for axis: LayoutOrientation) {
                super.setContentHuggingPriority(priority, for: axis)
                if let core = mCoreView {
                        core.setContentHuggingPriority(priority, for: axis)
                }
        }

        public override func setContentCompressionResistancePriority(_ priority: LayoutPriority, for axis: LayoutOrientation) {
                super.setContentCompressionResistancePriority(priority, for: axis)
                if let core = mCoreView {
                        core.setContentCompressionResistancePriority(priority, for: axis)
                }
        }

        open func accept(visitor vis: MIVisitor) {
                NSLog("[Error] Override this visitor method at \(#file)")
        }
}
