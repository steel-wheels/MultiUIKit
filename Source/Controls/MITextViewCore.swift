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
        @IBOutlet var mTextView: NSTextViewWrapper!
        #else
        @IBOutlet var mTextView: UITextView!
        #endif
        private var mStorage:   MITextStorage? = nil

        open override func setup() {
                super.setup(coreView: mTextView)
                mTextView.delegate  = self

                /*
                 * Call rawBlockCursor instead of drawInsertionPoint to draw cursor
                 */
                #if os(OSX)
                mTextView.drawBlockCursorFunc = {
                        (rect: NSRect, color: NSColor, flag: Bool) -> Void in
                        self.drawBlockCursor(in: rect, color: color, turnedOn: flag)
                }
                #endif
        }

        public func setup(storage strg: MITextStorage) {
                strg.setCoreStorage(coreStorage())
                strg.setNotification({
                        (ntype: MITextStorage.EventType) -> Void in
                        self.notifyUpdate(ntype)
                })
                strg.frameSize = mTextView.frame.size
                mStorage = strg
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

        public var textStorage: MITextStorage { get {
                if let storage = mStorage {
                        return storage
                } else {
                        fatalError("Failed to allocate storage")
                }
        }}

        public var isEditable: Bool {
                get { return mTextView.isEditable }
                set(newval) { mTextView.isEditable = newval }
        }

        #if os(OSX)
        public var cursorMode: NSTextViewWrapper.CursorMode {
                get       { return mTextView.cursorMode }
                set(mode) { mTextView.cursorMode = mode }
        }
        #endif

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
                if let csize = textStorage.contentsSize {
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

        open func drawBlockCursor(in rect: CGRect, color: MIColor, turnedOn flag: Bool) {
                NSLog("drawBlockCursor")
        }
}

