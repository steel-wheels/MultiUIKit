/*
 * @file NSTextViewWrapper.swift
 * @description Define MITextViewWrapper class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

import  AppKit

public class NSTextViewWrapper: NSTextView
{
        public typealias KeyEventReceiver = (_ down: Bool, _ event: NSEvent) -> Bool

        private var mKeyEventReceiver: KeyEventReceiver? = nil

        public func set(keyEventReceiver receiver: @escaping KeyEventReceiver) {
                mKeyEventReceiver = receiver
        }

        public override func keyDown(with event: NSEvent) {
                if let receiver = mKeyEventReceiver {
                        if !receiver(true, event) {
                                super.keyDown(with: event)
                        }
                } else {
                        super.keyDown(with: event)
                }
        }

        public override func keyUp(with event: NSEvent) {
                if let receiver = mKeyEventReceiver {
                        if !receiver(false, event) {
                                super.keyUp(with: event)
                        }
                } else {
                        super.keyUp(with: event)
                }
        }
}

