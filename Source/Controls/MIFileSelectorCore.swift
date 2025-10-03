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
        public enum FileType {
                case image
        }

        public typealias CallbackFunction = (_ url: URL) -> Void

#if os(OSX)
        @IBOutlet weak var mStack: MIStack!
#else
        @IBOutlet weak var mStack: MIStack!
#endif
        private var mButton:    MIButton?               = nil
        private var mLabel:     MILabel?                = nil
        private var mFileType:  FileType                = .image
        private var mCallback:  CallbackFunction?       = nil

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

        public var fileType: FileType {
                get        { return mFileType }
                set(ftype) { mFileType = ftype }
        }

        public func setCallback(_ cbfunc: @escaping CallbackFunction){
                mCallback = cbfunc
        }

        public var url: URL? {
                get         { return mCurrentURL   }
                set(newval) { mCurrentURL = newval }
        }

        private func buttonPressed() {
                let target:     String
                let extensions: Array<String>
                switch mFileType {
                case .image:
                        target     = "image"
                        extensions = ["png", "jpg", "jpeg"]
                }
                #if os(OSX)
                MIPanel.openPanel(title: "Select \(target)", type: .file, fileExtensions: extensions, callback: {
                        (_ urlp: URL?) -> Void in
                        if let label = self.mLabel {
                                if let url = urlp {
                                        label.title = url.path
                                        /* update path */
                                        self.mCurrentURL = url
                                        if let cbfunc = self.mCallback {
                                                cbfunc(url)
                                        }
                                } else {
                                        label.title = ""
                                }
                        }
                })
                #endif // os(OSX)
        }
}
