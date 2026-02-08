/*
 * @file MITextCursor.swift
 * @description Define MITextCursor class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

public class MITextCursor
{
        public enum State {
                case hidden
                case shown(Bool)        // true: Blink ON, false: Blimk off
        }

        private var mState:     State

        public init() {
                mState = .hidden
        }

        public var isShown: Bool {
                let result: Bool
                switch mState {
                case .hidden:   result = false
                case .shown(_): result = true
                }
                return result
        }
}

