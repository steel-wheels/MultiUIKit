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

        public enum AlertResult {
                case ok
                case cancel
        }

        public func makeLabeledStack(label lab: String, contents views : Array<MIInterfaceView>) -> MIStack {
                let stack = MIStack()
                let label = MILabel() ; label.title = lab
                if views.count > 1 {
                        stack.axis = .vertical
                        stack.addArrangedSubView(label)
                        for view in views {
                                stack.addArrangedSubView(view)
                        }
                } else { // views.count == 1 or 0
                        stack.axis = .horizontal
                        stack.distribution = .fillProportionally
                        stack.addArrangedSubView(label)
                        for view in views {
                                stack.addArrangedSubView(view)
                        }
                }
                return stack
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

        public func alert(message msg: String, callback cbfunc: @escaping (_ result: AlertResult) -> Void) {
                let alert = NSAlert()
                //alert.messageText       = msg
                alert.informativeText   = msg
                alert.alertStyle        = .critical

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
