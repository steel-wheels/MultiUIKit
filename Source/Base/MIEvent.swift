/*
 * @file MIEvent.swift
 * @description Define event types
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

#if os(OSX)
public typealias MIEvent = NSEvent
#else
public typealias MIEvent = UIEvent
#endif

