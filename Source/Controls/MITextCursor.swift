/*
 * @file MITextCursor.swift
 * @description Define MITextCursor class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

public class MITextCursor
{
        public var visible:             Bool
        public var blink:               Bool
        public var normalAttribute:     MITextAttribute

        public init() {
                self.visible            = false
                self.blink              = false
                self.normalAttribute    = MITextAttribute()
        }

        public var reversedAttribute: MITextAttribute { get {
                let font = normalAttribute.font
                let tcol = normalAttribute.backgroundColor
                let bcol = normalAttribute.textColor
                return MITextAttribute(font: font, textColor: tcol, backgroundColor: bcol)
        }}

        /*
        public var isShown: Bool {
                let result: Bool
                switch mState {
                case .hidden:   result = false
                case .shown(_): result = true
                }
                return result
        }*/
}

