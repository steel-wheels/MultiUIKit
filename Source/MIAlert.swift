/*
 * @file MIAlert.swift
 * @description Define MIAlert class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

@MainActor public class MIAlert
{
        public enum Style {
                case critical
                case warning
                case informartional

                #if os(iOS)
                #else  // os(iOS)
                public func encode() -> NSAlert.Style {
                        let result: NSAlert.Style
                        switch self {
                        case .critical:       result = .critical
                        case .warning:        result = .warning
                        case .informartional: result = .informational
                        }
                        return result
                }
                #endif // os(iOS)
        }

        public enum Result {
                case ok
                case cancel
        }

#if os(iOS)

#else // os(iOS)

        public static func open(style styl: Style, message msg: String, information info: String) -> Result {
                let alert = NSAlert()
                alert.messageText       = msg
                alert.informativeText   = info
                alert.alertStyle        = styl.encode()

                alert.addButton(withTitle: "OK")        // button 0
                alert.addButton(withTitle: "Cancel")    // button 1

                let buttons = alert.buttons
                //buttons[0].keyEquivalent = "\u{1b}"    // esc key
                buttons[1].keyEquivalent = "\r"        // enter key

                var result: Result = .cancel
                switch alert.runModal() {
                case .alertFirstButtonReturn:   result = .ok
                case .alertSecondButtonReturn:  result = .cancel
                default: break
                }
                return result
        }
#endif

}

