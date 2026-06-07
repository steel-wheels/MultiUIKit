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
        public typealias KeyEventReceiver = NSTextViewWrapper.KeyEventReceiver
        #endif
        public typealias CommandResponceReceiver = (_ : MITextEditResponce) -> Void

        #if os(OSX)
        @IBOutlet weak var mTextView: NSTextViewWrapper!
        @IBOutlet weak var mScrollView: NSScrollView!
        #else
        @IBOutlet var mTextView: UITextView!
        #endif

        private var mCursor =           MITextCursor()
        private var mResponceReceiver:  CommandResponceReceiver? = nil
        private var mStorage:           MITextStorage?  = nil
        
        open override func setup() {
                #if os(OSX)
                super.setup(coreView: mScrollView)
                #else
                super.setup(coreView: mTextView)
                #endif
                mTextView.delegate  = self
        }

        #if os(OSX)
        public func set(keyEventReceiver receiver: @escaping KeyEventReceiver) {
                mTextView.set(keyEventReceiver: receiver)
        }
        #endif

        public func set(commandRespoceReceivier receiver: @escaping CommandResponceReceiver) {
                mResponceReceiver = receiver
        }

        public func commandResponceReceiver() -> CommandResponceReceiver? {
                return mResponceReceiver
        }

        public var storage: MITextStorage { get {
                if let storage = mStorage {
                        return storage
                } else {
                        let newstrg = MITextStorage()
                        newstrg.setCoreStorage(self.storageCore)
                        mStorage = newstrg
                        return newstrg

                }
        }}

        private var storageCore: NSTextStorage {
                #if os(OSX)
                if let strg = mTextView.textStorage {
                        return strg
                } else {
                        fatalError("[Error] No core storage at \(#function) in \(#file)")
                }
                #else
                return mTextView.textStorage
                #endif
        }

        public var cursor: MITextCursor { get {
                return mCursor
        }}

        public var cursorPoint: MITextPoint { get {
                return storage.cursorPoint
        }}

        public var isEditable: Bool {
                get { return mTextView.isEditable }
                set(newval) { mTextView.isEditable = newval }
        }

        #if os(OSX)
        public func visibleTerminalSize() -> MITextSize {
                let fsize  = storage.fontSize
                let tsize  = mScrollView.frame.size
                let width  = Int(tsize.width  / fsize.width)
                let height = Int(tsize.height / fsize.height)
                return MITextSize(width: width, height: height)

        }
        #else
        public func visibleTerminalSize() -> MITextSize {
                let fsize = storage.fontSize
                let tsize = mTextView.frame.size
                let width  = Int(tsize.width  / fsize.width)
                let height = Int(tsize.height / fsize.height)
                return MITextSize(width: width, height: height)
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
        public override func setFrameSize(_ newsize: NSSize) {
                super.setFrameSize(newsize)
                let cursize = self.frame.size
                guard cursize.width != newsize.width || cursize.height != newsize.height else {
                        return
                }
                if let receiver = mResponceReceiver, let strg = mStorage {
                        let fsize = strg.fontSize
                        let cols  = Int(newsize.width  / fsize.width)
                        let rows  = Int(newsize.height / fsize.height)
                        receiver(.returnConsoleSize(cols, rows))
                }
        }
        #endif

        public func scrollToLast() {
                let end   = self.storage.validLength
                let range = NSRange(location: end, length: 0)
                mTextView.scrollRangeToVisible(range)
        }
}

