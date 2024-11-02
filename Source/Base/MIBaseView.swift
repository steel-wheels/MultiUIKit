/*
 * @file MIBaseView.swift
 * @description Define MIBaseView class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

public extension MIBaseView {
        func activateAutolayout() {
                self.translatesAutoresizingMaskIntoConstraints = false
                self.autoresizesSubviews = true
        }

        func requireLayout() {
                #if os(OSX)
                        self.needsLayout = true
                #else
                        self.setNeedsLayout()
                #endif
        }

        func requireDisplay() {
                #if os(OSX)
                        self.needsDisplay = true
                #else
                        self.setNeedsDisplay()
                #endif
        }
}

