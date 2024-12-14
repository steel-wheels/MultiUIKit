/*
 * @file MIViewController.swift
 * @description Define MIViewController class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

#if os(iOS)
public typealias MIViewControllerBase = UIViewController
#else
public typealias MIViewControllerBase = NSViewController
#endif

open class MIViewController: MIViewControllerBase
{
        public func open(URL url: URL) {
                #if os(iOS)
                UIApplication.shared.open(url, options: [:])
                #else
                NSWorkspace.shared.open(url)
                #endif
        }

        public enum AlertStyle {
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

        public enum AlertResult {
                case ok
                case cancel
        }

        #if os(iOS)

        public func alert(message msg: String, callback cbfunc: @escaping (_ result: AlertResult) -> Void) {
                let alert: UIAlertController = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)

                let cancelact = UIAlertAction(title: "Cancel", style: .cancel, handler: {
                        (action: UIAlertAction) -> Void in
                        cbfunc(.cancel)
                })
                alert.addAction(cancelact)

                let okact = UIAlertAction(title: "OK", style: .default, handler: {
                        (action: UIAlertAction) -> Void in
                        cbfunc(.ok)
                })
                alert.addAction(okact)

                self.present(alert, animated: true, completion: nil)
        }

        #else // if os(iOS)

        public func alert(style styl: AlertStyle, message msg: String, information info: String, callback cbfunc: @escaping (_ result: AlertResult) -> Void) {
                let alert = NSAlert()
                alert.messageText       = msg
                alert.informativeText   = info
                alert.alertStyle        = styl.encode()

                alert.addButton(withTitle: "OK")        // button 0
                alert.addButton(withTitle: "Cancel")    // button 1

                let buttons = alert.buttons
                if buttons.count >= 2 {
                        buttons[0].keyEquivalent = ""          //
                        buttons[1].keyEquivalent = "\r"        // enter key
                } else {
                        NSLog("[Error] Can not happend at \(#file)")
                }

                switch alert.runModal() {
                case .alertFirstButtonReturn:   cbfunc(.ok)
                case .alertSecondButtonReturn:  cbfunc(.cancel)
                default:
                        NSLog("[Error] Can not happend at \(#file)")
                        cbfunc(.cancel)
                }
        }

        #endif // os(iOS)
}
