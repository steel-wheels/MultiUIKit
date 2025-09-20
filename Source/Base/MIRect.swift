/**
 * @file MIRect.swift
 * @brief  Extend CGRect
 * @par Copyright
 *   Copyright (C) 2021-2025 Steel Wheels Project
 */

import Foundation

public extension CGRect
{
        var description: String { get {
                let x = self.origin.x
                let y = self.origin.y
                let w = self.size.width
                let h = self.size.height
                return "{x:\(x), y:\(y), width:\(w), height: \(h)}"
        }}
}
