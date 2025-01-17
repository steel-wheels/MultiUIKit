/*
 * @file MITabViewController.swift
 * @description Define MITabViewController class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

#if os(iOS)
open class MITabViewController: UITabBarController, UITabBarControllerDelegate
{
        open override func viewDidLoad() {
                self.delegate = self
        }

        public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
                let result: Bool
                if let curctrl = selectedViewController {
                        if curctrl != viewController {
                                result = shouldTransition(from: curctrl, to: viewController)
                        } else {
                                result = true
                        }
                } else {
                        NSLog("Failed to should translate at \(#function)")
                        result = true
                }
                return result
        }

        open func shouldTransition(from fvc: MIViewControllerBase, to tvc: MIViewControllerBase) -> Bool {
                NSLog("Should translate at \(#function)")
                return true
        }
}
#else
open class MITabViewController: NSTabViewController
{
        public func selectedViewController() -> NSViewController? {
                let idx = selectedTabViewItemIndex
                if idx < self.tabViewItems.count {
                        return self.tabViewItems[idx].viewController
                } else {
                        return nil
                }
        }

        public override func tabView(_ tabview: NSTabView, shouldSelect: NSTabViewItem?) -> Bool {
                let result: Bool
                if let curctrl = selectedViewController(), let nextitem = shouldSelect {
                        if let nextctrl = nextitem.viewController {
                                if curctrl != nextctrl {
                                        result = shouldTransition(from: curctrl, to: nextctrl)
                                } else {
                                        result = true
                                }
                        } else {
                                NSLog("Failed to shoukld translate at \(#function)")
                                result = true
                        }
                } else {
                        NSLog("Failed to should translate at \(#function)")
                        result = true
                }
                return result
        }

        open func shouldTransition(from fvc: MIViewControllerBase, to tvc: MIViewControllerBase) -> Bool {
                NSLog("Should translate at \(#function)")
                return true
        }
}
#endif

