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
        public var menuId:      Int
        public var title:       String

        public init(menuId: Int, title: String) {
                self.menuId = menuId
                self.title  = title
        }
}
