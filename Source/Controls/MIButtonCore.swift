/*
 * @file MIButtonCore.swift
 * @description Define MIButtonCore class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

public class MIButtonCore: MICoreView
{
        public typealias ButtonPressedCallback = () -> Void

        private var mButtonPressedCallback: ButtonPressedCallback? = nil

#if os(OSX)
        @IBOutlet weak var mButton: NSButton!

        @IBAction func action(_ sender: NSButton) {
                pressed()
        }
#else
        @IBOutlet weak var mButton: UIButton!

        @IBAction func action(_ sender: UIButton) {
                pressed()
        }
#endif

        open override func setup() {
                super.setup(coreView: mButton)

                #if os(iOS)
                var config = UIButton.Configuration.plain()
                config.title = "Button"
                config.baseForegroundColor = .black
                config.imagePlacement = .top
                config.titlePadding = 12
                mButton.configuration = config
                #else
                mButton.imagePosition = .imageAbove
                #endif
        }

        public func setButtonPressedCallback(_ cbfunc: @escaping ButtonPressedCallback){
                mButtonPressedCallback = cbfunc
        }

        private func pressed() {
                if let callback = mButtonPressedCallback {
                        callback()
                }
        }

        public var title: String {
                get {
                        #if os(iOS)
                        if let config = mButton.configuration {
                                return config.title ?? ""
                        } else {
                                return ""
                        }
                        #else   // os(iOS)
                                return mButton.title
                        #endif // os(iOS)
                }
                set(value){
                        #if os(iOS)
                        if var config = mButton.configuration {
                                config.title = value
                                mButton.configuration = config
                        } else {
                                NSLog("[Error] Failed to set title at \(#function) in \(#file)")
                        }
                        #else // os(iOS)
                                mButton.title = value
                        #endif
                }
        }

        public func setImage(_ img: MIImage) {
                #if os(iOS)
                mButton.setImage(img, for: .normal)
                #else
                mButton.image = img
                #endif
        }

        public var isEnabled: Bool {
                get        { return mButton.isEnabled }
                set(value) { mButton.isEnabled = value }
        }

        public func buttonFrame() -> CGRect {
                let frame    = mButton.frame
                let orgx     = frame.origin.x
                let orgy     = frame.origin.y
                let width    = frame.width
                let height   = frame.height
                let cellsize = mButton.sizeThatFits(frame.size)
                let newx = orgx + (width  - cellsize.width)  / 2.0
                let newy = orgy + (height - cellsize.height) / 2.0
                return CGRect(x: newx, y: newy, width: cellsize.width, height: cellsize.height)
        }
}
