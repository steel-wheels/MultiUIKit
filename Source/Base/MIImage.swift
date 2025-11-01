/**
 * @file MIImage.swift
 * @brief  Define MIImage class
 * @par Copyright
 *   Copyright (C) 2021-2025 Steel Wheels Project
 */

#if os(OSX)
import AppKit
#else
import UIKit
#endif
import Foundation

#if os(OSX)
public typealias MIImage        = NSImage
#else
public typealias MIImage        = UIImage
#endif

public extension MIImage
{
        static func load(from url: URL) -> MIImage? {
            #if os(OSX)
            return NSImage(contentsOf: url)
            #else
            return UIImage(contentsOfFile: url.path)
            #endif
        }

        convenience init?(symbolName name: String) {
                #if os(OSX)
                self.init(systemSymbolName: name, accessibilityDescription: nil)
                #else
                self.init(systemName: name, withConfiguration: nil)
                #endif
        }

        #if os(OSX)
        func pngData() -> Data? {
                if let cgimg = self.cgImage(forProposedRect: nil, context: nil, hints: nil) {
                        let repl  = NSBitmapImageRep(cgImage: cgimg)
                        return repl.representation(using: .png, properties: [:])
                } else {
                        return nil
                }
        }
        #endif

        #if os(iOS)
        convenience init?(contentsOf url: URL) {
                self.init(contentsOfFile: url.path)
        }
        #endif

        func expand(targetSize tsize: CGSize) -> MIImage? {
            let thissize = self.size
            let xdiff    = (tsize.width  - thissize.width ) / 2.0
            let ydiff    = (tsize.height - thissize.height) / 2.0
            if xdiff >= 0.0 && ydiff >= 0.0 {
                return expand(xPadding: xdiff, yPadding: ydiff)
            } else {
                return nil
            }
        }

        #if os(OSX)
        func resize(to newsize: NSSize) -> MIImage {
                let resizedImage = MIImage(size: newsize)
                resizedImage.lockFocus()
                self.draw(in: NSRect(origin: .zero, size: newsize),
                        from: NSRect(origin: .zero, size: self.size),
                        operation: .copy,
                        fraction: 1.0)
                resizedImage.unlockFocus()
                return resizedImage
        }
        #else
        func resize(to newsize: CGSize) -> MIImage {
                let renderer = UIGraphicsImageRenderer(size: newsize)
                let resizedImage = renderer.image { _ in
                        self.draw(in: CGRect(origin: .zero, size: newsize))
                }
                return resizedImage
        }
        #endif

        #if os(OSX)
        func expand(xPadding: CGFloat, yPadding: CGFloat) -> NSImage {
            let srcwidth  = self.size.width
            let srcheight = self.size.height
            let newwidth  = srcwidth  + xPadding * 2.0
            let newheight = srcheight + yPadding * 2.0
            let img = NSImage(size: CGSize(width: newwidth, height: newheight))

            img.lockFocus()
                let ctx = NSGraphicsContext.current
                ctx?.imageInterpolation = .high
                self.draw(
                    in:   NSMakeRect(0, 0, newwidth, newheight),
                    from: NSMakeRect(-xPadding, -yPadding, newwidth, newheight),
                    operation: .copy,
                    fraction: 1
                )
            img.unlockFocus()

            return img
        }
        #else
        /* See https://gist.github.com/ppamorim/cc79170422236d027b2b */
        func expand(xPadding: CGFloat, yPadding: CGFloat) -> UIImage {
            let cursize = self.size
            let targetSize = CGSize(width:  cursize.width  + xPadding * 2.0,
                                    height: cursize.height + yPadding * 2.0)
            let targetOrigin = CGPoint(x: xPadding, y: yPadding)

            let format = UIGraphicsImageRendererFormat()
            format.scale = 1
            let renderer = UIGraphicsImageRenderer(size: targetSize, format: format)

            return renderer.image { _ in
                self.draw(in: CGRect(origin: targetOrigin, size: self.size))
            }
        }
        #endif
}


