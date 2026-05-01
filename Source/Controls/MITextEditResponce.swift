/*
 * @file MITextEditResponce.swift
 * @description Define MITextEditResponce class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

public enum MITextEditResponce
{
        case returnCursorPosition(Int, Int)     // column num, row num
        case returnConsoleSize(Int, Int)        // column num, row num

        public var description: String { get {
                let result: String
                switch self {
                case .returnCursorPosition(let row, let col):
                        result = "receiveCursorPosition(\(row), \(col))"
                case .returnConsoleSize(let width, let height):
                        result = "receiveConsoleSize(\(width), \(height))"
                }
                return result
        }}
}

