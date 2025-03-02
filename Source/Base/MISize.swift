/**
 * @file MISize.swift
 * @brief  Extend CGSize
 * @par Copyright
 *   Copyright (C) 2021-2025 Steel Wheels Project
 */

#if os(OSX)
import AppKit
#else
import UIKit
#endif
import Foundation

public extension CGSize
{
        static func isSame(_ s0: CGSize, _ s1: CGSize) -> Bool {
            return (s0.width == s1.width) && (s0.height == s1.height)
        }

        static func maxSize(_ s0: CGSize, _ s1: CGSize) -> CGSize {
                let width  = max(s0.width,  s1.width)
                let height = max(s0.height, s1.height)
                return CGSize(width: width, height: height)
        }

        static func minSize(_ s0: CGSize, _ s1: CGSize) -> CGSize {
                let width  = max(min(s0.width,  s1.width),  0.0)
                let height = max(min(s0.height, s1.height), 0.0)
                return CGSize(width: width, height: height)
        }

        var description: String { get {
                let wstr = NSString(format: "%.2lf", self.width)
                let hstr = NSString(format: "%.2lf", self.height)
                return "{width:\(wstr), height:\(hstr)}"
        }}

        func resizeWithKeepingAscpect(inWidth dstwidth: CGFloat) -> CGSize {
                guard dstwidth > 0.0 && self.width > 0.0 && self.height > 0.0 else {
                        NSLog("[Error] Invalid size at \(#function) in \(#file)")
                        return self
                }
                let ratio = self.width / self.height
                let newwidth  = dstwidth
                let newheight = dstwidth / ratio
                return CGSize(width: newwidth, height: newheight)
        }

        func resizeWithKeepingAscpect(inSize dst: CGSize) -> CGSize {
                guard dst.width > 0.0 && dst.height > 0.0 else {
                        NSLog("[Error] Invalid size at \(#function) in \(#file)")
                        return self
                }
                let reswidth, resheight: CGFloat
                let ratio = self.width / self.height
                if ratio >= 1.0 {
                        /* width >= height */
                        reswidth  = dst.width
                        resheight = dst.width / ratio
                } else {
                        /* width < height */
                        reswidth  = dst.height * ratio
                        resheight = dst.height
                }
                return CGSize(width: reswidth, height: resheight)
        }
}
