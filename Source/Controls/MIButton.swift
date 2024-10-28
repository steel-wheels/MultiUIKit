/*
 * @file MIButton.swift
 * @description Define MIButton class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)


public class MIButton: MIInterfaceView
{
        open override func setup(frame frm: CGRect) {
                super.setup(nibName: "MIButtonCore", frameSize: frm.size)
        }

        private func coreButtonView() -> MIButtonCore {
                if let core: MIButtonCore = super.coreView() {
                        return core
                } else {
                        fatalError("Failed to get core view")
                }
        }

        public var title: String {
                get      { return coreButtonView().title        }
                set(val) { coreButtonView().title = val         }
        }
}



