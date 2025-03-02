/*
 * @file MIColor.swift
 * @description Define MIColor class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

#if os(OSX)
public typealias MIColor = NSColor
#else
public typealias MIColor = UIColor
#endif

