/*
 * @file NSTextViewWrapper.swift
 * @description Define NSTextViewWrapper class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

import  AppKit

import Cocoa

public class NSTextViewWrapper: NSTextView
{
        public enum CursorMode {
                case InsertionPointer
                case BlockCursor
        }

        public typealias DrawBlockCursorFunc = (NSRect, NSColor, Bool) -> Void

        public var cursorMode:          CursorMode              = .InsertionPointer
        public var drawBlockCursorFunc: DrawBlockCursorFunc?    = nil

        open override func drawInsertionPoint(in rect: NSRect, color: NSColor, turnedOn flag: Bool) {
                switch cursorMode {
                case .InsertionPointer:
                        super.drawInsertionPoint(in: rect, color: color, turnedOn: flag)
                case .BlockCursor:
                        if let dfunc = drawBlockCursorFunc {
                                dfunc(rect, color, flag)
                        } else {
                                super.drawInsertionPoint(in: rect, color: color, turnedOn: flag)
                        }
                }
        }
}
