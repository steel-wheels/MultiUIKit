/*
 * @file MISegmentedControl.swift
 * @description Define MISegmentedControl class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

public class MISegmentedControl: MIInterfaceView
{
        public typealias CallbackFunction = MISegmentedControlCore.CallbackFunction

        open override func setup(frame frm: CGRect) {
                super.setup(nibName: "MISegmentedControlCore", frameSize: frm.size)
        }

        private func coreSegmentedControl() -> MISegmentedControlCore {
                if let core: MISegmentedControlCore = super.coreView() {
                        return core
                } else {
                        fatalError("Failed to get core view")
                }
        }

        public func setCallback(_ cbfunc: @escaping CallbackFunction){
                coreSegmentedControl().setCallback(cbfunc)
        }

        public func setMenuItems( items: Array<MIMenuItem>) {
                coreSegmentedControl().setMenuItems(items: items)
        }
}

