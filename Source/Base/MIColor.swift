/*
 * @file MIColor.swift
 * @description Define MIColor class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

#if os(OSX)
public typealias MIColor = NSColor
#else
public typealias MIColor = UIColor
#endif

extension MIColor {
        func toRGBADescription() -> String {
                #if os(OSX)
                let color = self.usingColorSpace(.deviceRGB)!
                return String(format: "{r:%.3f, g:%.3f, b:%.3f, a:%.3f}",
                      color.redComponent,
                      color.greenComponent,
                      color.blueComponent,
                      color.alphaComponent)
                #else
                var r: CGFloat = 0
                var g: CGFloat = 0
                var b: CGFloat = 0
                var a: CGFloat = 0

                self.getRed(&r, green: &g, blue: &b, alpha: &a)
                return String(format: "{r:%.3f, g:%.3f, b:%.3f, a:%.3f}", r, g, b, a)
                #endif
        }
}
