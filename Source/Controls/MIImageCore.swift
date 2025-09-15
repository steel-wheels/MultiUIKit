/*
 * @file MILabelCore.swift
 * @description Define MILabelCore class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

public class MIImageCore: MICoreView
{
        #if os(OSX)
        @IBOutlet weak var mImageView: NSImageView!
        #else
        @IBOutlet weak var mImageView: UIImageView!
        #endif

        open override func setup() {
                super.setup(coreView: mImageView)
                /*
                 * Cocoa NSView subview blocking drag/drop
                 * https://stackoverflow.com/questions/5892464/cocoa-nsview-subview-blocking-drag-drop
                 */
                #if os(OSX)
                mImageView.unregisterDraggedTypes()
                #endif
        }

        public var image: MIImage? {
                get      { return mImageView.image      }
                set(img) {
                        mImageView.image = img

                        let csize: MIContentSize
                        if let rimg = img {
                                let width:  MIContentSize.Length = .immediate(rimg.size.width)
                                let height: MIContentSize.Length = .immediate(rimg.size.height)
                                csize = MIContentSize(width: width, height: height)
                        } else {
                                let width:  MIContentSize.Length = .immediate(0.0)
                                let height: MIContentSize.Length = .immediate(0.0)
                                csize = MIContentSize(width: width, height: height)
                        }
                        super.set(contentSize: csize)
                        super.requireDisplay()
                }
        }
}

