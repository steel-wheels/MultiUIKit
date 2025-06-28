/*
 * @file MIDropViewCore.swift
 * @description Define MIDropViewCore class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

public class MIDropViewCore: MICoreView
{
        #if os(OSX)
        @IBOutlet weak var mStack: MIStack!
        #else
        @IBOutlet weak var mStack: MIStack!
        #endif

        open override func setup() {
                super.setup(coreView: mStack)
        }

        public var contentsView: MIStack { get {
                return mStack
        }}
}

