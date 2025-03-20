/*
 * @file MIAttributedString.swift
 * @description Expand NSAttributedString class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

import Foundation

public extension NSAttributedString
{
        /* the result line is NOT contains last newline code */
        static func devideByNewline(source src: NSAttributedString) -> Array<NSAttributedString> {
                var result: Array<NSAttributedString> = []
                var current: Int = 0
                let length = src.length
                for i in 0 ..< length {
                        let range = NSRange(location: i, length: 1)
                        let astr  = src.attributedSubstring(from: range)
                        if astr.string == "\n" {
                                let linelen   = i - current // +1 is removed to suppress copy last newline
                                let linerange = NSRange(location: current, length: linelen)
                                let substr = src.attributedSubstring(from: linerange)
                                result.append(substr)
                                current = i + 1
                        }
                }
                if current < length {
                        let range  = NSRange(location: current, length: length - current)
                        let substr = src.attributedSubstring(from: range)
                        result.append(substr)
                }
                return result
        }
}
