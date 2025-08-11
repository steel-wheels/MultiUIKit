/**
 * @file MIContentSize.swift
 * @brief  Define MIContentSize
 * @par Copyright
 *   Copyright (C) 2021-2025 Steel Wheels Project
 */

#if os(OSX)
import AppKit
#else
import UIKit
#endif
import Foundation

@MainActor public struct MIContentSize
{
        public enum Length {
                case none
                case immediate(CGFloat)
                case ratioToScreen(CGFloat)     // percentage
        }

        static let NO_VALUE: CGFloat = 0.0

        private var mWidth:     CGFloat
        private var mHeight:    CGFloat

        public var width:  CGFloat { get { return mWidth  }}
        public var height: CGFloat { get { return mHeight }}

        public init(width: Length, height: Length) {
                self.mWidth  = MIContentSize.calcWidth(length:  width)
                self.mHeight = MIContentSize.calcHeight(length: height)
        }

        public func adjustSize(size src: CGSize) -> CGSize {
                return CGSize(width: max(mWidth, src.width), height: max(mHeight, src.height))
        }

        static private func calcWidth(length len: Length) -> CGFloat {
                let result: CGFloat
                switch len {
                case .none:
                        result = MIContentSize.NO_VALUE
                case .immediate(let val):
                        result = val
                case .ratioToScreen(let rat):
                        #if os(OSX)
                        if let scrn = NSScreen.main {
                                result = scrn.frame.size.width * rat
                        } else {
                                NSLog("[Error] Screen is not found at \(#function)")
                                result = MIContentSize.NO_VALUE
                        }
                        #else
                        let bounds = UIScreen.main.bounds
                        return bounds.width * rat
                        #endif
                }
                return result
        }

        static private func calcHeight(length len: Length) -> CGFloat {
                let result: CGFloat
                switch len {
                case .none:
                        result = MIContentSize.NO_VALUE
                case .immediate(let val):
                        result = val
                case .ratioToScreen(let rat):
                        #if os(OSX)
                        if let scrn = NSScreen.main {
                                result = scrn.frame.size.height * rat
                        } else {
                                NSLog("[Error] Screen is not found at \(#function)")
                                result = MIContentSize.NO_VALUE
                        }
                        #else
                        let bounds = UIScreen.main.bounds
                        return bounds.height * rat
                        #endif
                }
                return result
        }
}

