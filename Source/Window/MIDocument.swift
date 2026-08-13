/*
 * @file MIDocument.swift
 * @description Extend NSDocument class
 * @par Copyright
 *   Copyright (C) 2026 Steel Wheels Project
 */

#if os(OSX)

import AppKit
import Foundation

extension NSDocument
{
        public static var frontDocument: NSDocument? { get {
                for window in NSApp.orderedWindows {
                    if let doc = window.windowController?.document as? NSDocument {
                        return doc
                    }
                }
                return nil
        }}
}

#endif // os(OSX)

