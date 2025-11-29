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
                let x = String(format: "%.2f", self.origin.x)
                let y = String(format: "%.2f", self.origin.y)
                let w = String(format: "%.2f", self.size.width)
                let h = String(format: "%.2f", self.size.height)
                return "{x:\(x), y:\(y), width:\(w), height: \(h)}"
        }}
}
