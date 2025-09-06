/*
 * @file MIFileSelectorCore.swift
 * @description Define MIFileSelectorCore class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

public class MIFileSelectorCore: MICoreView
{
#if os(OSX)
        @IBOutlet weak var mStack: MIStack!
#else
        @IBOutlet weak var mStack: MIStack!
#endif
        private var mButton:    MIButton?       = nil
        private var mLabel:     MILabel?        = nil

        private var mCurrentURL: URL?           = nil

        open override func setup() {
                super.setup(coreView: mStack)

                mStack.axis = .horizontal
                mStack.distribution = .fillProportionally

                let button = MIButton()
                button.setButtonPressedCallback({
                        () -> Void in self.buttonPressed()
                })
                mStack.addArrangedSubView(button)
                mButton = button

                let label = MILabel()
                mStack.addArrangedSubView(label)
                mLabel = label

                button.title = "Select"
                button.setContentExpansionPriority(.low, for: .horizontal)
                label.setContentExpansionPriority(.high, for: .horizontal)
        }

        public var contentsView: MIStack { get {
                return mStack
        }}

        public var url: URL {
                get {
                        if let cur = mCurrentURL {
                                return cur
                        } else {
                                NSLog("[Error] No valid url at \(#file)")
                                return URL(fileURLWithPath: "/dev/null")
                        }
                }
                set(newval) {
                        mCurrentURL = newval
                        if let label = mLabel {
                                label.title = newval.lastPathComponent
                        } else {
                                NSLog("[Error] No valid field at \(#file)")
                        }
                }
        }

        private func buttonPressed() {

        }
}
