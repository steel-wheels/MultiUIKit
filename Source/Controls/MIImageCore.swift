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
                        super.requireDisplay()
                }
        }

        public func imageFrame() -> CGRect {
                let frame  = mImageView.frame
                let orgx   = frame.origin.x
                let orgy   = frame.origin.y
                let width  = frame.size.width
                let height = frame.size.height

                guard let img = mImageView.image else {
                        return CGRect(x: orgx + (width  / 2.0),
                                      y: orgy + (height / 2.0),
                                      width: 0.0, height: 0.0)
                }
                let imgsize = img.size

                let halign: MIHorizontalAlignment
                let valign: MIVerticalAlignment

                #if os(OSX)
                switch mImageView.imageAlignment {
                case .alignTopLeft:
                        halign = .left
                        valign = .top
                case .alignTop:
                        halign  = .middle
                        valign  = .top
                case .alignTopRight:
                        halign  = .right
                        valign  = .top
                case .alignLeft:
                        halign = .left
                        valign = .center
                case .alignCenter:
                        halign = .middle
                        valign = .center
                case .alignRight:
                        halign = .right
                        valign = .center
                case .alignBottomLeft:
                        halign = .left
                        valign = .bottom
                case .alignBottom:
                        halign = .middle
                        valign = .bottom
                case .alignBottomRight:
                        halign = .right
                        valign = .bottom
                @unknown default:
                        NSLog("[Error] Can not happen at \(#file)")
                        halign = .middle
                        valign = .center
                }
                #else
                switch mImageView.contentMode {
                case .scaleToFill, .scaleAspectFit, .scaleAspectFill, .redraw, .center:
                        halign = .middle
                        valign = .center
                case .top:
                        halign = .middle
                        valign = .top
                case .bottom:
                        halign = .middle
                        valign = .bottom
                case .left:
                        halign = .left
                        valign = .center
                case .right:
                        halign = .right
                        valign = .center
                case .topLeft:
                        halign = .left
                        valign = .top
                case .topRight:
                        halign = .right
                        valign = .top
                case .bottomLeft:
                        halign = .left
                        valign = .bottom
                case .bottomRight:
                        halign = .right
                        valign = .bottom
                @unknown default:
                        NSLog("[Error] Can not happen at \(#file)")
                        halign = .middle
                        valign = .center
                }
                #endif // OS(OSX)

                let newx: CGFloat
                switch halign {
                case .left:     newx = orgx
                case .middle:   newx = orgx + (width - imgsize.width) / 2.0
                case .right:    newx = orgx + (width - imgsize.width)
                }

                let newy: CGFloat
                switch valign {
                case .top:      newy = orgy + (height - imgsize.height)
                case .center:   newy = orgy + (height - imgsize.height) / 2.0
                case .bottom:   newy = orgy
                }

                return CGRect(origin: CGPoint(x: newx, y: newy), size: imgsize)
        }
}
