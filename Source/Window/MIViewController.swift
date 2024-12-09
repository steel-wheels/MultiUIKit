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

        #if os(iOS)

        public func alert(message msg: String, callback cbfunc: @escaping (_ result: MIAlert.Result) -> Void) {
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

        #endif
}
