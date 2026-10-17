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

extension MIColor
{
        #if os(iOS)
        public var redComponent: CGFloat { get {
                let (r, _, _, _) = self.components
                return r
        }}

        public var greenComponent: CGFloat { get {
                let (_, g, _, _) = self.components
                return g
        }}

        public var blueComponent: CGFloat { get {
                let (_, _, b, _) = self.components
                return b
        }}

        public var alphaComponent: CGFloat { get {
                let (_, _, _, a) = self.components
                return a
        }}

        private var components: (CGFloat, CGFloat, CGFloat, CGFloat) { get {
                var r: CGFloat = 0
                var g: CGFloat = 0
                var b: CGFloat = 0
                var a: CGFloat = 0
                self.getRed(&r, green: &g, blue: &b, alpha: &a)
                return (r, g, b, a)
        }}
        #endif

        func toRGBADescription() -> String {
                #if os(OSX)
                let color = self.usingColorSpace(.deviceRGB)!
                return String(format: "{r:%.3f, g:%.3f, b:%.3f, a:%.3f}",
                      color.redComponent,
                      color.greenComponent,
                      color.blueComponent,
                      color.alphaComponent)
                #else
                let (r, g, b, a) = self.components
                return String(format: "{r:%.3f, g:%.3f, b:%.3f, a:%.3f}", r, g, b, a)
                #endif
        }
}

extension CGColor
{
        public static let red   = CGColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        public static let green = CGColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
        public static let blue  = CGColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)

        public var grbComponents: (CGFloat, CGFloat, CGFloat, CGFloat) {
                if let cspace = self.colorSpace {
                        switch cspace.model {
                        case .rgb:
                                if let comp = self.components {
                                        return (comp[0], comp[1], comp[2], comp[3])
                                }

                        case .monochrome:
                                if let comp = self.components {
                                        return (comp[0], comp[0], comp[0], comp[1])
                                }
                        default:
                                break
                        }
                }
                NSLog("[Error] Failed to get color components")
                return (0.0, 0.0, 0.0, 0.0)
        }
}
