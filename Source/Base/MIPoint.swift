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
                let x = self.x
                let y = self.y
                return "{x:\(x), y:\(y)}"
        }}
}

