/*
 * @file MIPopupMenuCore.swift
 * @description Define MIStackCore class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

public class MIPopupMenuCore: MICoreView
{
        public typealias CallbackFunction = (_ menuId: Int) -> Void

        public struct MenuItem {
                public var menuId:      Int
                public var title:       String

                public init(menuId: Int, title: String) {
                        self.menuId = menuId
                        self.title  = title
                }
        }

        #if os(iOS)
        @IBOutlet weak var mPopupButton: UIButton!
        #else
        @IBOutlet weak var mPopupButton: NSPopUpButton!

        @IBAction func mAction(_ sender: Any) {
                if let button = sender as? NSPopUpButton {
                        if let selitem = button.selectedItem {
                                self.receiveEvent(title: selitem.title)
                        }
                }
        }
        #endif

        private var mCallbackFunction:  CallbackFunction? = nil
        private var mMenuItems:         Dictionary<String, Int> = [:]

        open override func setup() {
                super.setup(coreView: mPopupButton)
                #if os(iOS)
                mPopupButton.showsMenuAsPrimaryAction = true
                #else
                mPopupButton.removeAllItems()
                #endif
        }

        public func setCallback(_ cbfunc: @escaping CallbackFunction){
                mCallbackFunction = cbfunc
        }

        public func setMenuItems( items: Array<MenuItem>) {
                for item in items {
                        mMenuItems[item.title] = item.menuId
                }

                #if os(iOS)
                var actions: Array<UIAction> = []
                for item in items {
                        actions.append(UIAction(title: item.title, image: nil) {
                                action in self.receiveEvent(title: item.title)
                        })
                }
                mPopupButton.menu = UIMenu(children: actions)
                #else
                for item in items {
                        mPopupButton.addItem(withTitle: item.title)
                }
                #endif
        }

        private func selectedTitle() -> String? {
                #if os(iOS)
                if let menu = mPopupButton.menu {
                        let elms = menu.selectedElements
                        if elms.count > 0 {
                                return elms[0].title
                        }
                }
                #else
                if let item = mPopupButton.selectedItem {
                        return item.title
                }
                #endif
                return nil
        }

        public func selectedItem() -> Int? {
                if let title = selectedTitle() {
                        return mMenuItems[title]
                } else {
                        return nil
                }
        }

        private func receiveEvent(title ttl: String) {
                if let cbfunc = mCallbackFunction, let mid = mMenuItems[ttl] {
                        cbfunc(mid)
                }
        }
}

