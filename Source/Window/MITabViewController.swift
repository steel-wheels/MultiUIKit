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

open class MITabViewController: UITabBarController
{
        public struct ContentView {
                public var title:       String
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

                self.mode = .tabBar

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
        }

        /* https://stackoverflow.com/questions/46317061/how-do-i-use-safe-area-layout-programmatically */
        private func allocateSubviewLayout(controller: UIViewController, view: MIInterfaceView){
                view.translatesAutoresizingMaskIntoConstraints = false

                let guide = controller.view.safeAreaLayoutGuide
                view.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
                view.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
                view.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
                view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        }
}

#else   // os(iOS)
#endif  // os(iOS)
