/*
 * @file MIViewController.swift
 * @description Define MIViewController class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

#if os(iOS)
public typealias MIViewControllerBase = UIViewController
#else
public typealias MIViewControllerBase = NSViewController
#endif

open class MIViewController: MIViewControllerBase
{

}
