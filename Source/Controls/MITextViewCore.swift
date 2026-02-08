/*
 * @file MITextViewCore.swift
 * @description Define MITextViewCore class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

#if os(OSX)
typealias MITextViewDelegate = NSTextViewDelegate
#else
typealias MITextViewDelegate = UITextViewDelegate
#endif

public class MITextViewCore: MICoreView, MITextViewDelegate
{
        #if os(OSX)
        @IBOutlet var mTextView: NSTextView!
        #else
        @IBOutlet var mTextView: UITextView!
        #endif

        private var mStorage:           MITextStorage?  = nil
        private var mCursor:            MITextCursor?   = nil

        open override func setup() {
                super.setup(coreView: mTextView)
                mTextView.delegate  = self
        }

        public func setup(storage strg: MITextStorage, cursor crsr: MITextCursor) {
                strg.setCoreStorage(coreStorage())
                strg.setNotification({
                        (ntype: MITextStorage.EventType) -> Void in
                        self.notifyUpdate(ntype)
                })
                strg.frameSize = mTextView.frame.size
                mStorage = strg
                mCursor  = crsr
        }

        #if os(OSX)
        private func coreStorage() -> NSTextStorage {
                if let strg = mTextView.textStorage {
                        return strg
                } else {
                        fatalError("[Error] No core storage at \(#function) in \(#file)")
                }
        }
        #else
        private func coreStorage() -> NSTextStorage {
                return mTextView.textStorage
        }
        #endif

        public var storage: MITextStorage { get {
                if let storage = mStorage {
                        return storage
                } else {
                        fatalError("Failed to allocate storage")
                }
        }}

        public var cursor: MITextCursor { get {
                if let cursor = mCursor {
                        return cursor
                } else {
                        fatalError("Failed to allocate cursor")
                }
        }}

        public var isEditable: Bool {
                get { return mTextView.isEditable }
                set(newval) { mTextView.isEditable = newval }
        }

        public var insertionPointColor: MIColor {
                get      {
                        #if os(OSX)
                        return mTextView.insertionPointColor
                        #else
                        return mTextView.tintColor
                        #endif
                }
                set(col) {
                        #if os(OSX)
                        mTextView.insertionPointColor = col
                        #else
                        mTextView.tintColor = col
                        #endif
                }
        }

        public var textColor: MIColor? {
                get {
                        let obj = mTextView.typingAttributes[NSAttributedString.Key.foregroundColor]
                        return obj as? MIColor
                }
                set(col){
                        mTextView.typingAttributes[NSAttributedString.Key.foregroundColor] = col
                }
        }

        public override var backgroundColor: MIColor? {
                get      {
                        return mTextView.backgroundColor
                }
                set(col) {
                        mTextView.backgroundColor = col
                        mTextView.typingAttributes[NSAttributedString.Key.backgroundColor] = col
                        super.backgroundColor = col
                }
        }

        #if os(OSX)
        public override func setFrameSize(_ newsize: CGSize) {
                super.setFrameSize(newsize)
                if let storage = mStorage {
                        storage.frameSize = newsize
                }
        }
        #else
        public override var frame: CGRect {
                get     { return super.frame    }
                set(newval) {
                        super.frame = newval
                        if let storage = mStorage {
                                storage.frameSize = newval.size
                        }
                }
        }
        #endif

        public override var intrinsicContentSize: CGSize { get {
                if let csize = storage.contentsSize {
                        return csize
                } else {
                        return super.intrinsicContentSize
                }
        }}

        private func notifyUpdate(_ ntype: MITextStorage.EventType) {
                switch ntype {
                case .textAttribute(let attr):
                        mTextView.font = attr.font
                }
        }
}

