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
}

