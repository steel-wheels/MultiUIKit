/**
 * @file MITextColor.swift
 * @brief  Define MITextColor class
 * @par Copyright
 *   Copyright (C) 2026 Steel Wheels Project
 */

import Foundation

public enum MITextColor
{
        case black
        case red
        case green
        case yellow
        case blue
        case magenta
        case cyan
        case white

        public var name: String { get {
                let result: String
                switch self {
                case .black:    result = "black"
                case .red:      result = "red"
                case .green:    result = "green"
                case .yellow:   result = "yellow"
                case .blue:     result = "blue"
                case .magenta:  result = "magenta"
                case .cyan:     result = "cyan"
                case .white:    result = "white"
                }
                return result
        }}

        public var value: MIColor { get {
                let result: MIColor
                switch self {
                case .black:    result = MIColor.black
                case .red:      result = MIColor.red
                case .green:    result = MIColor.green
                case .yellow:   result = MIColor.yellow
                case .blue:     result = MIColor.blue
                case .magenta:  result = MIColor.magenta
                case .cyan:     result = MIColor.cyan
                case .white:    result = MIColor.white
                }
                return result
        }}

        public static func decode(color col: MIColor) -> MITextColor {
                #if os(OSX)
                guard let rgb = col.usingColorSpace(.sRGB) else {
                        NSLog("[Error] Failed to makge RGB info at \(#file)")
                        return .black
                }
                let r = rgb.redComponent
                let g = rgb.greenComponent
                let b = rgb.blueComponent
                #else
                guard let comps = col.cgColor.components else {
                        NSLog("[Error] Failed to makge RGB info at \(#file)")
                        return .black
                }
                let r = comps[0]
                let g = comps[1]
                let b = comps[2]
                #endif
                let result: MITextColor
                if r > 0.5 {
                        if g > 0.5 {
                                if b > 0.5 {
                                        /* R:YES, G:YES, B:YES */
                                        result = .white
                                } else {
                                        /* R:YES, G:YES, B:NO */
                                        result = .yellow
                                }
                        } else {
                                if b > 0.5 {
                                        /* R:YES, G:NO, B:YES */
                                        result = .magenta
                                } else {
                                        /* R:YES, G:NO, B:NO */
                                        result = .red
                                }
                        }
                } else {
                        if g > 0.5 {
                                if b > 0.5 {
                                        /* R:NO, G:YES, B:YES */
                                        result = .cyan
                                } else {
                                        /* R:NO, G:YES, B:NO */
                                        result = .green
                                }
                        } else {
                                if b > 0.5 {
                                        /* R:NO, G:NO, B:YES */
                                        result = .blue
                                } else {
                                        /* R:NO, G:NO, B:NO */
                                        result = .black
                                }
                        }
                }
                return result
        }
}
