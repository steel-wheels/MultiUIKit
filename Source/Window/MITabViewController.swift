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
public typealias MITabViewControllerBase = UITabBarController
#else // os(iOS)
public typealias MITabViewControllerBase = NSTabViewController
#endif // os(iOS)

open class MITabViewController: MITabViewControllerBase
{
        public struct TabController {
                public var title:       String
                public var controller:  MIViewController
                public init(title: String, controller: MIViewController) {
                        self.title = title
                        self.controller = controller
                }
        }

        private var mTabControllers: Array<TabController> = []

        public func addContentView(title ttl: String, controller cont: MIViewController) {
                mTabControllers.append(TabController(title: ttl, controller: cont))
        }

        open override func viewDidLoad() {
                #if os(iOS)
                self.mode = .tabBar
                #else
                self.tabStyle = .segmentedControlOnTop
                #endif

                #if os(iOS)
                var children: Array<MIViewController> = []
                for ctrl in mTabControllers {
                        ctrl.controller.tabBarItem = UITabBarItem(title: ctrl.title, image: nil, tag: children.count)
                        children.append(ctrl.controller)
                }
                super.setViewControllers(children, animated: false)
                super.selectedIndex = 0
                #else
                for ctrl in mTabControllers {
                        let item = NSTabViewItem(viewController: ctrl.controller)
                        item.label = ctrl.title
                        super.addTabViewItem(item)
                }
                super.selectedTabViewItemIndex = 0
                #endif

                super.viewDidLoad()
        }

        /* https://stackoverflow.com/questions/46317061/how-do-i-use-safe-area-layout-programmatically */
        public class func allocateSubviewLayout(controller: MIViewController, view: MIInterfaceView){
                view.translatesAutoresizingMaskIntoConstraints = false

                let guide = controller.view.safeAreaLayoutGuide
                let space: CGFloat = 4.0
                view.leadingAnchor.constraint(
                        equalTo: guide.leadingAnchor, constant: space
                ).isActive = true
                view.trailingAnchor.constraint(
                        equalTo: guide.trailingAnchor, constant: -space
                ).isActive = true
                view.topAnchor.constraint(
                        equalTo: guide.topAnchor, constant: space
                ).isActive = true
                view.heightAnchor.constraint(
                        equalToConstant: 100
                ).isActive = true
        }
}



