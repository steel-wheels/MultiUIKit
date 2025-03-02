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
                storage.update(commands: commands)
                mStorage = storage
        }

        private func allocateTextStorage() -> MITextStorage {
                let newstorage: MITextStorage
                #if os(OSX)
                if let txtstorage = mTextView.textStorage {
                        newstorage = MITextStorage(string: txtstorage)
                } else {
                        fatalError("Failed to allocate storage")
                }
                #else
                newstorage = MITextStorage(string: mTextView.textStorage)
                #endif

                let layoutManager = NSLayoutManager()
                #if os(OSX)
                if let container = mTextView.textContainer {
                        layoutManager.addTextContainer(container)
                } else {
                        NSLog("No text container")
                }
                #else
                let container = mTextView.textContainer
                layoutManager.addTextContainer(container)
                #endif
                newstorage.addLayoutManager(layoutManager)
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

        public var font: MIFont? {
                get          { return mTextView.font    }
                set(newfont) { mTextView.font = newfont }
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
}

