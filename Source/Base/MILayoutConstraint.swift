/**
 * @file MILayoutConstraint
 * @brief  Extend NSLayoutConstraint
 * @par Copyright
 *   Copyright (C)  2025 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

extension NSLayoutConstraint.Attribute
{
        func toString() -> String {
                let result: String
                switch self {
                case .left:                     result = "left"
                case .right:                    result = "right"
                case .top:                      result = "top"
                case .bottom:                   result = "bottom"
                case .leading:                  result = "leading"
                case .trailing:                 result = "trailing"
                case .width:                    result = "width"
                case .height:                   result = "height"
                case .centerX:                  result = "centerX"
                case .centerY:                  result = "centerY"
                case .lastBaseline:             result = "lastBaseline"
                case .firstBaseline:            result = "firstBaseline"
                case .notAnAttribute:           result = "otAnAttribute:"
                #if os(iOS)
                case .leftMargin:               result = "leftMargin"
                case .rightMargin:              result = "rightMargin"
                case .topMargin:                result = "topMargin"
                case .bottomMargin:             result = "bottomMargin"
                case .leadingMargin:            result = "leadingMargin"
                case .trailingMargin:           result = "trailingMargin"
                case .centerXWithinMargins:     result = "enterXWithinMargins"
                case .centerYWithinMargins:     result = "centerYWithinMargins"
                #endif
                @unknown default:
                        NSLog("[Error] Can not happend at \(#file)")
                        result = "?"
                }
                return result
        }
}

extension NSLayoutConstraint.Relation
{
        public func toString() -> String {
                let result: String
                switch self {
                case .equal:                    result = "=="
                case .greaterThanOrEqual:       result = ">="
                case .lessThanOrEqual:          result = "<="
                @unknown default:
                        NSLog("[Error] Can not happend at \(#file)")
                        result = "?"
                }
                return result
        }
}

