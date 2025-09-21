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
public typealias MIResponder                = NSResponder
#else
public typealias MIResponder                = UIResponder
#endif

public enum MIHorizontalAlignment {
        case left
        case middle
        case right
}

public enum MIVerticalAlignment {
        case top
        case center
        case bottom
}

public struct MIAlignment
{
        public var horizonralAlignment: MIHorizontalAlignment
        public var verticalAlignment:   MIVerticalAlignment

        public init(horizontal h: MIHorizontalAlignment, vertical v: MIVerticalAlignment){
                self.horizonralAlignment = h
                self.verticalAlignment   = v
        }
}

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

                public static func isSame(_ s0: MIMenuItem.Value, _ s1: MIMenuItem.Value) -> Bool {
                        let result: Bool
                        switch s0 {
                        case .none:
                                switch s1 {
                                case .none:                     result = true
                                case .intValue(_):              result = false
                                case .stringValue(_):           result = false
                                }
                        case .intValue(let i0):
                                switch s1 {
                                case .none:                     result = false
                                case .intValue(let i1):         result = (i0 == i1)
                                case .stringValue(_):           result = false
                                }
                        case .stringValue(let s0):
                                switch s1 {
                                case .none:                     result = false
                                case .intValue(_):              result = false
                                case .stringValue(let s1):      result = (s0 == s1)
                                }
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
