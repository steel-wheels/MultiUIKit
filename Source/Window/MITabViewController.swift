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
        public struct ContentView {
                public var title:    String
                public var view:     MIStack

                public init(title: String, view: MIStack) {
                        self.title = title
                        self.view  = view
                }
        }

        private var mContentViews: Array<ContentView> = []

        public func addContentView(title ttl: String, contentView cont: MIStack) {
                mContentViews.append(ContentView(title: ttl, view: cont))
        }

        open override func viewDidLoad() {
                super.viewDidLoad()

                #if os(iOS)
                self.mode = .tabBar
                #else
                self.tabStyle = .segmentedControlOnTop
                #endif

                #if os(iOS)
                var children: Array<MIViewController> = []
                for content in mContentViews {
                        let child  = MIViewController()
                        child.view.addSubview(content.view)
                        child.tabBarItem = UITabBarItem(title: content.title, image: nil, tag: children.count)
                        allocateSubviewLayout(controller: child, view: content.view)
                        children.append(child)
                }
                super.setViewControllers(children, animated: false)
                super.selectedIndex = 0
                #else
                for content in mContentViews {
                        let child  = MIViewController()
                        child.view.addSubview(content.view)
                        allocateSubviewLayout(controller: child, view: content.view)

                        let item = NSTabViewItem(viewController: child)
                        item.label = content.title

                        super.addTabViewItem(item)
                }
                super.selectedTabViewItemIndex = 0
                #endif
        }

        /* https://stackoverflow.com/questions/46317061/how-do-i-use-safe-area-layout-programmatically */
        private func allocateSubviewLayout(controller: MIViewController, view: MIInterfaceView){
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



