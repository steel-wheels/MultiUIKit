/*
 * @file MIDropViewn.swift
 * @description Define MIDropView class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)


/*
 * Reference:
 *   Drag and Drop Tutorial for macOS
 *   https://www.kodeco.com/1016-drag-and-drop-tutorial-for-macos
 */

public class MIDropView: MIInterfaceView
{
        #if os(OSX)
        var acceptableTypes: Set<NSPasteboard.PasteboardType> { return [ .fileURL, .png ] }
        #endif // os(OSX)

        open override func setup(frame frm: CGRect) {
                super.setup(nibName: "MIDropViewCore", frameSize: frm.size)
                #if os(OSX)
                registerForDraggedTypes(Array(acceptableTypes))
                #endif // os(OSX)
        }

        private func dropCoreView() -> MIDropViewCore {
                if let core: MIDropViewCore = super.coreView() {
                        return core
                } else {
                        fatalError("Failed to get core view")
                }
        }

        public var contentsView: MIStack { get {
                return dropCoreView().contentsView
        }}

        #if os(OSX)
        let filteringOptions = [NSPasteboard.ReadingOptionKey.urlReadingContentsConformToTypes:NSImage.imageTypes]

        private func shouldAllowDrag(_ draggingInfo: NSDraggingInfo) -> Bool {
                let canAccept: Bool
                let pasteBoard = draggingInfo.draggingPasteboard
                if pasteBoard.canReadObject(forClasses: [NSImage.self], options: filteringOptions) {
                        canAccept = true
                } else {
                        canAccept = false
                }
                NSLog("shouldAllowDrag: \(canAccept)")
                return canAccept
        }

        public var isReceivingDrag = false {
                didSet {
                        needsDisplay = true
                }
        }

        public override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
                let allow = shouldAllowDrag(sender)
                return allow
        }

        public override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
                let allow = shouldAllowDrag(sender)
                isReceivingDrag = allow
                return allow ? .copy : NSDragOperation()
        }

        public override func draggingExited(_ sender: NSDraggingInfo?) {
                isReceivingDrag = false
        }

        public override func draw(_ dirtyRect: NSRect) {
                super.draw(dirtyRect)
                if isReceivingDrag {
                        NSColor.selectedControlColor.set()

                        let path = NSBezierPath(rect:bounds)
                        path.lineWidth = 2.0 // Appearance.lineWidth
                        path.stroke()
                }
        }

        public override func performDragOperation(_ draggingInfo: NSDraggingInfo) -> Bool {
                isReceivingDrag = false
                let pasteBoard = draggingInfo.draggingPasteboard
                let point = convert(draggingInfo.draggingLocation, from: nil)

                //NSLog("performDragOperation: start")

                var result = false
                if let pasteboardItems = pasteBoard.pasteboardItems {
                        //NSLog("performDragOperation: item num: \(pasteboardItems.count)")
                        for pasteboarditem in pasteboardItems {
                                for type in pasteboarditem.types {
                                        switch type {
                                        case .png:
                                                //NSLog("performDragOperation: png data")
                                                if let data = pasteboarditem.data(forType: type) {
                                                        //NSLog("performDragOperation: get data")
                                                        if let image = NSImage(data: data) {
                                                                NSLog("performDragOperation: result: image")
                                                                result = true
                                                        } else {
                                                                NSLog("[Error] Failed to get image at \(#function)")
                                                        }
                                                }
                                        case .fileURL, .URL:
                                                //NSLog("performDragOperation: URL")
                                                if let data = pasteboarditem.data(forType: type) {
                                                        //NSLog("performDragOperation: get url")
                                                        let url = NSURL(dataRepresentation: data, relativeTo: nil) as URL
                                                        NSLog("performDragOperation: result: url \(url.path)")
                                                        result = true
                                                }
                                        default:
                                                NSLog("[Error] performDragOperation: Others")
                                        }
                                }
                        }
                }

                NSLog("performDragOperation: \(result)")

                return result
        }

        #endif
}
