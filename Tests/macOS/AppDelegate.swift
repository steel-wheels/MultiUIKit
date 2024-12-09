//
//  AppDelegate.swift
//  UnitTest_macOS
//
//  Created by Tomoo Hamada on 2024/10/20.
//

import MultiUIKit
import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate
{
        private var mPreferenceWindow: MIWindow? = nil
        private var mDidPreferenceWindowOpended  = false

        func applicationDidFinishLaunching(_ aNotification: Notification) {
                // Insert code here to initialize your application
        }

        func applicationWillTerminate(_ aNotification: Notification) {
                // Insert code here to tear down your application
        }

        func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
                return true
        }

        @IBAction func openSettingWindow(_ sender: NSMenuItem) {
                if mDidPreferenceWindowOpended {
                        NSLog("the preference window has been opened")
                        return
                }

                let controller = PreferenceViewController()

                let config = MIWindow.WindowConfig(size: NSSize(width: 640, height: 480), title: "Preference", closeable: true, resizable: false)
                let window = MIWindow.open(viewController: controller, condfig: config)
                window.setCallback(windowWillClose: {
                        () -> Void in
                        NSLog("the preference window will be closed")
                        self.mDidPreferenceWindowOpended = false
                })
                mPreferenceWindow = window
                mDidPreferenceWindowOpended = true
        }
}

