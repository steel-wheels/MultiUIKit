/*
 * @file MIType.swift
 * @description Define public typealiases
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

#if os(OSX)
public typealias MIBaseView = NSView
#else  // os(OSX)
public typealias MIBaseView = UIView
#endif // os(OSX)

public struct MIMenuItem {
        public enum Value {
                case none
                case intValue(Int)
                case stringValue(String)

                public func toString() -> String {
                        let result: String
                        switch self {
                        case .none:                     result = "<none>"
                        case .intValue(let ival):       result = "\(ival)"
                        case .stringValue(let sval):    result = sval
                        }
                        return result
                }
        }

        public var title:       String
        public var value:       Value

        public init(title: String, value: Value) {
                self.title  = title
                self.value  = value
        }
}
