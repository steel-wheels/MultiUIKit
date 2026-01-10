/*
 * @file MIFont.swift
 * @description Define MIFont class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

#if os(OSX)
public typealias MIFont = NSFont
#else
public typealias MIFont = UIFont
#endif

public extension MIFont
{
        static func terminalFont(size sz: CGFloat) -> MIFont {
                if let fnt = MIFont(name: "Menlo", size: sz) {
                        return fnt
                } else if let fnt = MIFont(name: "Monaco", size: sz) {
                        return fnt
                } else {
                        fatalError("No terminal font")
                }
        }
}
