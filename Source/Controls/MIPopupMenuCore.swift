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
        public typealias CallbackFunction = (_ value: MIMenuItem.Value) -> Void

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
        private var mMenuItems:         Dictionary<String, MIMenuItem.Value> = [:]

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

        public func setMenuItems( items: Array<MIMenuItem>) {
                for item in items {
                        mMenuItems[item.title] = item.value
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
                mPopupButton.removeAllItems()
                for item in items {
                        mPopupButton.addItem(withTitle: item.title)
                }
                #endif
                mPopupButton.invalidateIntrinsicContentSize()
                mPopupButton.requireLayout()
        }

        public var numberOfItems: Int { get {
                #if os(iOS)
                if let menu = mPopupButton.menu {
                        return menu.children.count
                } else {
                        return 0
                }
                #else
                return mPopupButton.numberOfItems
                #endif
        }}

        public func setEnable(_ enable: Bool) {
                mPopupButton.isEnabled = enable
        }

        public func selectedTitle() -> String? {
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

        public func selectedValue() -> MIMenuItem.Value? {
                if let title = selectedTitle() {
                        return mMenuItems[title]
                } else {
                        return nil
                }
        }

        public func selectByTitle(_ title: String) -> Bool {
                #if os(iOS)
                if let menu = mPopupButton.menu {
                        for item in menu.children {
                                if let act = item as? UIAction {
                                        if act.title == title {
                                                act.state = .on
                                        } else {
                                                act.state = .off
                                        }
                                }
                        }
                }
                #else
                for item in mPopupButton.itemArray {
                        if item .title == title {
                                mPopupButton.select(item)
                                return true
                        }
                }
                #endif
                return false
        }

        public func selectByValue(_ value: MIMenuItem.Value) -> Bool {
                for (title, ival) in mMenuItems {
                        if MIMenuItem.Value.isSame(value, ival) {
                                if selectByTitle(title) {
                                        return true
                                }
                        }
                }
                return false
        }

        private func receiveEvent(title ttl: String) {
                if let cbfunc = mCallbackFunction, let mid = mMenuItems[ttl] {
                        cbfunc(mid)
                }
        }
}

