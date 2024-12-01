/*
 * @file MIPopupMenu.swift
 * @description Define MIPopupMenu class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)


public class MIPopupMenu: MIInterfaceView
{
        public typealias CallbackFunction = MIPopupMenuCore.CallbackFunction
        public typealias MenuItem         = MIMenuItem

        open override func setup(frame frm: CGRect) {
                super.setup(nibName: "MIPopupMenuCore", frameSize: frm.size)
        }

        private func corePopupMenu() -> MIPopupMenuCore {
                if let core: MIPopupMenuCore = super.coreView() {
                        return core
                } else {
                        fatalError("Failed to get core view")
                }
        }

        public func setCallback(_ cbfunc: @escaping CallbackFunction){
                corePopupMenu().setCallback(cbfunc)
        }

        public func setEnable(_ enable: Bool) {
                corePopupMenu().setEnable(enable)
        }

        public func setMenuItems( items: Array<MenuItem>) {
                corePopupMenu().setMenuItems(items: items)
        }

        public func selectedTitle() -> String? {
                return corePopupMenu().selectedTitle()
        }

        public func selectedItem() -> Int? {
                return corePopupMenu().selectedItem()
        }
}


