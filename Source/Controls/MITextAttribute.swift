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

        public var font:                MIFont
        public var textColor:           MIColor
        public var backgroundColor:     MIColor

        public init(){
                font             = MIFont.systemFont(ofSize: 12.0)
                textColor        = .black
                backgroundColor  = .white
        }

        public init(font fnt: MIFont, textColor tcol: MIColor, backgroundColor bcol: MIColor) {
                self.font               = fnt
                self.textColor          = tcol
                self.backgroundColor    = bcol
        }

        public var description: String { get {
                return    "{" + "font:" + font.fontName + ", "
                              + "text:" + self.textColor.toRGBADescription() + ", "
                              + "background:" + self.backgroundColor.toRGBADescription()
                        + "}"
        }}

        public func clone() -> MITextAttribute {
                return MITextAttribute(font: self.font,
                                       textColor: self.textColor,
                                       backgroundColor: self.backgroundColor)
        }

        public var attributes: Dictionary<Key, NSObject> { get {
                let attrs: Dictionary<Key, NSObject> = [
                        Key.font:            self.font,
                        Key.foregroundColor: self.textColor,
                        Key.backgroundColor: self.backgroundColor
                ]
                return attrs
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
