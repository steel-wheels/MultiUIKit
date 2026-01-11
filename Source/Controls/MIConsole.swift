/*
 * @file MIConsole.swift
 * @description Define MIConsole class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

@objc open class MIConsole: NSObject
{
        private var mTextStorage: MITextStorage

        public init(storage strg: MITextStorage){
                mTextStorage = strg
        }

        public func print(string str: String){
                mTextStorage.insert(string: str)
        }
}
