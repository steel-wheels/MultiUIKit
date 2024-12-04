/*
 * @file MIWindow.swift
 * @description Define MIWindow class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)

import AppKit

open class MIWindow: NSWindow, NSWindowDelegate
{
        public typealias WindowWillCloseFunc = () -> Void

        private var mWindiwWillCloseCallback: WindowWillCloseFunc? = nil

        public struct WindowConfig {
                public var size:        NSSize
                public var title:       String?
                public var closeable:   Bool
                public var resizable:   Bool

                public init(size: NSSize, title: String?, closeable: Bool, resizable: Bool) {
                        self.size      = size
                        self.title     = title
                        self.closeable = closeable
                        self.resizable = resizable
                }

                public var hasTitle: Bool { get {
                        return title != nil
                }}
        }

        public static func open(viewController controller: MIViewController, condfig conf: WindowConfig) -> MIWindow {
                let rect = NSRect(origin: CGPoint.zero, size: conf.size)
                var style: NSWindow.StyleMask = []
                if conf.hasTitle  { style.insert(.titled)       }
                if conf.closeable { style.insert(.closable)     }
                if conf.resizable { style.insert(.resizable)    }

                let newwindow = MIWindow(contentRect: rect, styleMask: style, backing: .buffered, defer: false)
                if let title = conf.title {
                        newwindow.title = title
                }
                newwindow.delegate = newwindow
                newwindow.contentViewController = controller
                newwindow.contentView = controller.view
                newwindow.center()
                newwindow.orderFrontRegardless()
                newwindow.isReleasedWhenClosed = false

                return newwindow
        }

        public func setCallback(windowWillClose cbfunc: @escaping WindowWillCloseFunc) {
                mWindiwWillCloseCallback = cbfunc
        }

        /* NSWindowDelegate */
        public func windowWillClose(_ notification: Notification) {
                if let cbfunc = mWindiwWillCloseCallback {
                        cbfunc()
                }
        }
}

#endif // os(OSX)

