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
        private var mStorage:   MITextStorage? = nil

        open override func setup() {
                super.setup(coreView: mTextView)
                mTextView.delegate  = self

                let storage  = allocateTextStorage()

                var commands: Array<MITextStorage.Command> = []
                if let color = mTextView.textColor {
                        commands.append(.textColor(color))
                }
                #if os(OSX)
                commands.append(.backgroundColor(mTextView.backgroundColor))
                #else
                if let color = mTextView.backgroundColor {
                        commands.append(.backgroundColor(color))
                }
                #endif
                storage.execute(commands: commands)
                storage.frameSize = mTextView.frame.size
                mStorage = storage
        }

        private func allocateTextStorage() -> MITextStorage {
                let newstorage: MITextStorage
                #if os(OSX)
                if let txtstorage = mTextView.textStorage {
                        newstorage = MITextStorage(string: txtstorage, notification: {
                                (attr: MITextStorage.TextAttribute) -> Void in
                                self.notifyUpdate(attr)
                        })
                } else {
                        fatalError("Failed to allocate storage")
                }
                #else
                newstorage = MITextStorage(string: mTextView.textStorage, notification: {
                        (attr: MITextStorage.TextAttribute) -> Void in
                        self.notifyUpdate(attr)
                })
                #endif
                return newstorage
        }

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

        public var textColor: MIColor? {
                get         { return mTextView.textColor }
                set(newcol) { mTextView.textColor = newcol }
        }

        public var textBackgroundColor: MIColor? {
                get {
                        return mTextView.backgroundColor
                }
                set(newcolp) {
                        if let newcol = newcolp {
                                mTextView.backgroundColor = newcol
                        }
                }
        }

        public override func setFrameSize(_ newsize: CGSize) {
                super.setFrameSize(newsize)
                if let storage = mStorage {
                        storage.frameSize = newsize
                }
        }

        public override var intrinsicContentSize: CGSize { get {
                if let csize = textStorage.contentsSize {
                        return csize
                } else {
                        return super.intrinsicContentSize
                }
        }}

        private func notifyUpdate(_ attr: MITextStorage.TextAttribute) {
                mTextView.font = attr.font
        }
}

