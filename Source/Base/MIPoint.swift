/**
 * @file MIPointswift
 * @brief  Extend CGPoint
 * @par Copyright
 *   Copyright (C) 2021-2025 Steel Wheels Project
 */

import Foundation

public extension CGPoint
{
        var description: String { get {
                let x = String(format: "%.2f", self.x)
                let y = String(format: "%.2f", self.y)
                return "{x:\(x), y:\(y)}"
        }}
}

