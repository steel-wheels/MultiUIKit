/*
 * @file MITextAttribute.swift
 * @description Define MITextAttribute class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

public class MITextAttribute
{
        public typealias Key = NSAttributedString.Key

        private var mAttributes: Dictionary<Key, NSObject>

        public init(){
                mAttributes             = [:]
        }

        public init(font fnt: MIFont, textColor tcol: MIColor, backgroundColor bcol: MIColor) {
                mAttributes             = [:]
                self.font               = fnt
                self.backgroundColor    = bcol
                self.textColor          = tcol
        }

        public var attributes: Dictionary<Key, NSObject> { get {
                return mAttributes
        }}

        public func clone() -> MITextAttribute {
                return MITextAttribute(font: self.font,
                                       textColor: self.textColor,
                                       backgroundColor: self.backgroundColor)
        }

        public var font: MIFont {
                get {
                        if let fnt = mAttributes[Key.font] as? MIFont {
                                return fnt
                        } else {
                                return MIFont.systemFont(ofSize: 12.0)
                        }
                }
                set(val){
                        mAttributes[Key.font] = val
                }
        }

        public var textColor: MIColor {
                get {
                        if let col = mAttributes[Key.foregroundColor] as? MIColor {
                                return col
                        } else {
                                return MIColor.black
                        }
                }
                set(val){
                        mAttributes[Key.foregroundColor] = val
                }
        }

        public var backgroundColor: MIColor {
                get {
                        if let col = mAttributes[Key.backgroundColor] as? MIColor {
                                return col
                        } else {
                                return MIColor.white
                        }
                }
                set(val) {      mAttributes[Key.backgroundColor] = val                  }
        }

        public var description: String { get {
                return    "{" + "font:" + self.font.fontName + ", "
                              + "text:" + self.textColor.toRGBADescription() + ", "
                              + "background:" + self.backgroundColor.toRGBADescription()
                        + "}"
        }}

        public static func fromAttribute(_ attrs: Dictionary<Key, Any> ) -> MITextAttribute {
                guard let font = attrs[Key.font] as? MIFont,
                      let fcol = attrs[Key.foregroundColor] as? MIColor,
                      let bcol = attrs[Key.backgroundColor] as? MIColor
                else {
                        NSLog("[Error] Failed to decode at \(#file)")
                        return MITextAttribute()
                }
                return MITextAttribute(font: font, textColor: fcol, backgroundColor: bcol)
        }
}

public class MITextAttributes
{
        private var mAttributes: Array<MITextAttribute>

        public init() {
                mAttributes = [ MITextAttribute() ]
        }

        public var current:  MITextAttribute { get {
                if let attr = mAttributes.last {
                        return attr
                } else {
                        NSLog("[Error] Empty attribute at \(#file)")
                        return MITextAttribute()
                }
        }}

        public func push(attribute attr: MITextAttribute) {
                mAttributes.append(attr)
        }

        public func pop() {
                mAttributes.removeLast()
        }
}
