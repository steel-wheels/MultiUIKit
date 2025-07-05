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
                NSLog("Must be override: Should translate at \(#function)")
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
                NSLog("Must be override: Should translate at \(#function)")
                return true
        }
}
#endif

public extension MITabViewController
{
        func showTabBar(visible vis: Bool){
                #if os(OSX)
                let style: NSTabViewController.TabStyle
                if vis {
                        style = .segmentedControlOnTop
                } else {
                        style = .unspecified
                }
                self.tabStyle = style
                #else
                self.tabBar.isHidden = !vis
                #endif
        }

        func switchView(index idx: Int){
                #if os(OSX)
                        self.selectedTabViewItemIndex = idx
                #else
                        self.selectedIndex = idx
                #endif
        }

        func currentViewController() -> MIViewController? {
                #if os(OSX)
                        let idx = self.selectedTabViewItemIndex
                        if 0 <= idx && idx < self.tabViewItems.count {
                                let item = self.tabViewItems[idx]
                                if let view = item.viewController as? MIViewController {
                                        return view
                                } else {
                                        NSLog("[Error] Unknown view controller at \(#function)")
                                }
                        }
                        return nil
                #else
                        if let view = super.selectedViewController as? MIViewController {
                                return view
                        } else {
                                return nil
                        }
                #endif
        }

        private func viewIndexToIdentifer(index idx: Int) -> String {
                return "view[\(idx)]"
        }

        func pushViewController(viewController view: MIViewController) {
                /* The current view become background view */
                if let sview = currentViewController() {
                        sview.viewWillBecomeBackground()
                }
                #if os(OSX)
                        /* Add new item */
                        let idx   = self.tabViewItems.count
                        let ident = viewIndexToIdentifer(index: idx)
                        let item  = NSTabViewItem(identifier: ident)
                        item.viewController = view
                        self.addTabViewItem(item)
                #else
                        let newctrls: Array<UIViewController>
                        let idx: Int
                        if let orgctrls = self.viewControllers {
                                var ctrls = orgctrls
                                idx          = orgctrls.count
                                ctrls.append(view)
                                newctrls = ctrls
                        } else {
                                newctrls = [view]
                                idx      = 0
                        }
                        self.setViewControllers(newctrls, animated: false)
                #endif
                /* Switch to new view */
                switchView(index: idx)
                /* The new view become foreground view */
                if let sview = currentViewController() {
                        sview.viewWillBecomeForeground()
                }
        }

        func removeTabViewItem(index idx: Int) {
                #if os(OSX)
                        self.removeTabViewItem(self.tabViewItems[idx])
                #else
                        if let orgctrls = self.viewControllers {
                                var newctrls: Array<UIViewController> = []
                                for i in 0..<idx {
                                        newctrls.append(orgctrls[i])
                                }
                                self.setViewControllers(newctrls, animated: false)
                        }
                #endif
        }
}
