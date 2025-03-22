/*
 * @file MITextView.swift
 * @description Define MITextView class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

open class MITextStorage
{
        public typealias NotifyUpdateFunc = (_ : EventType) -> Void

        public enum Command {
                case textColor(MIColor)
                case backgroundColor(MIColor)
                case font(MIFont)
                case moveBackward(Int)
                case moveForward(Int)
                case removeLeft(Int)
                case removeRight(Int)
                case clear
                case insert(String)
        }

        public struct TextAttribute {
                public var font:                MIFont
                public var textColor:           MIColor
                public var backgroundColor:     MIColor

                public init(){
                        font             = MIFont.systemFont(ofSize: 12.0)
                        textColor        = MIColor.black
                        backgroundColor  = MIColor.white
                }
        }

        public enum EventType {
                case textAttribute(TextAttribute)
        }

        private var mStorage:           NSTextStorage?
        private var mCurrentIndex:      Int
        private var mParagraphStyle:    NSMutableParagraphStyle
        private var mTextAtrribute:     TextAttribute
        private var mFrameSize:         CGSize
        private var mContentsSize:      CGSize?
        private var mNotifyUpdate:      NotifyUpdateFunc?

        public init(){
                mStorage               = nil
                mCurrentIndex          = 0
                mParagraphStyle        = NSMutableParagraphStyle()
                mTextAtrribute         = TextAttribute()
                mFrameSize             = CGSize.zero
                mContentsSize          = nil
                mNotifyUpdate          = nil

                /* init style */
                mParagraphStyle.headIndent              = 0.0
                mParagraphStyle.firstLineHeadIndent     = 0.0
                mParagraphStyle.tailIndent              = 0.0

                updateParagraphStyle(fontSize: mTextAtrribute.font.pointSize)
        }

        private func updateParagraphStyle(fontSize sz: CGFloat) {
                mParagraphStyle.lineHeightMultiple      =  1.0
                mParagraphStyle.maximumLineHeight       =  sz
                mParagraphStyle.minimumLineHeight       =  0.0
                mParagraphStyle.lineSpacing             =  2.0
                mParagraphStyle.paragraphSpacing        =  0.0
                mParagraphStyle.paragraphSpacingBefore  =  2.0
        }

        public func setCoreStorage(_ strg: NSTextStorage) {
                mStorage = strg
        }

        public func setNotification(_ notif: @escaping NotifyUpdateFunc) {
                mNotifyUpdate = notif
        }

        open var frameSize: CGSize {
                get { return mFrameSize }
                set(newval){ mFrameSize = newval }
        }

        public var contentsSize: CGSize? {
                get { return mContentsSize }
                set(newval){ mContentsSize = newval }
        }

        public var fontSize: CGSize { get {
                let astr  = allocate(" ")
                let fsize = astr.size()
                return CGSize(width:  fsize.width,
                              height: fsize.height + mParagraphStyle.lineSpacing)
        }}

        public var lineSpacing: CGFloat { get {
                return mParagraphStyle.lineSpacing
        }}

        public var currentIndex: Int { get {
                return mCurrentIndex
        }}

        public var length: Int { get {
                if let storage = mStorage {
                        return storage.length
                } else {
                        NSLog("[Error] No core storage at \(#function) in \(#file)")
                        return 0
                }
        }}

        public func addLayoutManager(_ manager: NSLayoutManager) {
                if let storage = mStorage {
                        storage.addLayoutManager(manager)
                } else {
                        NSLog("[Error] No core storage at \(#function) in \(#file)")
                }
        }

        public func execute(commands cmds: Array<Command>) {
                guard let strg = mStorage else {
                        NSLog("[Error] No core storage")
                        return
                }
                strg.beginEditing()
                for cmd in cmds {
                        execute(command: cmd, storage: strg)
                }
                strg.endEditing()
        }

        private func execute(command cmd: Command, storage strg: NSTextStorage) {
                switch cmd {
                case .font(let font):
                        mTextAtrribute.font = font
                        updateParagraphStyle(fontSize: font.pointSize)
                case .textColor(let col):
                        mTextAtrribute.textColor       = col
                case .backgroundColor(let col):
                        mTextAtrribute.backgroundColor = col
                case .moveBackward(let off):
                        mCurrentIndex = max(0, mCurrentIndex - off)
                case .moveForward(let off):
                        mCurrentIndex = min(strg.length - 1, mCurrentIndex + off)
                case .removeLeft(let off):
                        let len   = min(strg.length, off)
                        let loc   = min(0, mCurrentIndex - len)
                        let range = NSRange(location: loc, length: len)
                        strg.replaceCharacters(in: range, with: "")
                        mCurrentIndex -= len
                case .removeRight(let off):
                        let len  = min(strg.length - mCurrentIndex, off)
                        let loc  = mCurrentIndex
                        let range = NSRange(location: loc, length: len)
                        strg.replaceCharacters(in: range, with: "")
                        // current index is not changed
                case .clear:
                        let range  = NSRange(location: 0, length: strg.length)
                        strg.replaceCharacters(in: range, with: "")
                case .insert(let str):
                        let astr = allocate(str)
                        strg.insert(astr, at: mCurrentIndex)
                        mCurrentIndex += astr.length
                }
                /* callback */
                if let notify = mNotifyUpdate {
                        notify(.textAttribute(mTextAtrribute))
                }
        }

        private func allocate(_ str: String) -> NSAttributedString {
                let attrs: Dictionary<NSAttributedString.Key, Any> = [
                        NSAttributedString.Key.paragraphStyle:  mParagraphStyle,
                        NSAttributedString.Key.font:            mTextAtrribute.font,
                        NSAttributedString.Key.foregroundColor: mTextAtrribute.textColor,
                        NSAttributedString.Key.backgroundColor: mTextAtrribute.backgroundColor
                ]
                return NSAttributedString(string: str, attributes: attrs)
        }
}
