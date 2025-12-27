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

open class MIDropView: MIInterfaceView
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
                //NSLog("shouldAllowDrag: \(canAccept)")
                return canAccept
        }

        public var isReceivingDrag = false {
                didSet {
                        requireDisplay()
                }
        }

        public override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
                let allow = shouldAllowDrag(sender)
                return allow
        }

        public override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
                super.draggingEntered(sender)

                let allow = shouldAllowDrag(sender)
                isReceivingDrag = allow
                NSLog("draggingEntered: \(isReceivingDrag)")
                return allow ? .copy : NSDragOperation()
        }

        private var mHighlightedView: MIInterfaceView? = nil

        public override func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation {
                let result = super.draggingUpdated(sender)

                let locationInWindow = sender.draggingLocation
                let locationInRoot   = convert(locationInWindow, from: nil)

                /* check the mouse on this view */
                if let mview = parentStack(of: hitTest(locationInRoot)) {
                        NSLog("draggingUpdated \(mview)")
                        if mHighlightedView != mview {
                                mHighlightedView?.isHighlighted = false
                                mview.isHighlighted = true
                                mHighlightedView = mview
                        }
                } else {
                        NSLog("draggingUpdated nil")
                        mHighlightedView?.isHighlighted = false
                        mHighlightedView = nil
                }

                return result
        }

        private func parentStack(of viewp: NSView?) -> MIStack? {
                guard let view = viewp else {
                        return nil
                }
                if let stack = view as? MIStack {
                        return stack
                }
                if let parent = view.superview {
                        return parentStack(of: parent)
                } else {
                        return nil
                }
        }

        public override func draggingExited(_ sender: NSDraggingInfo?) {
                super.draggingExited(sender)
                NSLog("draggingExited")
                isReceivingDrag = false
        }

        public override func performDragOperation(_ draggingInfo: NSDraggingInfo) -> Bool {
                let pasteBoard = draggingInfo.draggingPasteboard
                let point = convert(draggingInfo.draggingLocation, from: nil)

                //NSLog("performDragOperation: start")

                guard let pasteboardItems = pasteBoard.pasteboardItems else {
                        NSLog("[Error] No pasteboard item at \(#file)")
                        return false
                }

                var result = false
                //NSLog("performDragOperation: item num: \(pasteboardItems.count)")
                for pasteboarditem in pasteboardItems {
                        for type in pasteboarditem.types {
                                switch type {
                                case .png:
                                        if let data = pasteboarditem.data(forType: type) {
                                                //NSLog("performDragOperation: get data")
                                                if let image = NSImage(data: data) {
                                                        didDropped(point: point, image: image)
                                                        result = true
                                                } else {
                                                        NSLog("[Error] Failed to get image at \(#function)")
                                                }
                                        }
                                case .fileURL, .URL:
                                        if let data = pasteboarditem.data(forType: type) {
                                                let url = NSURL(dataRepresentation: data, relativeTo: nil) as URL
                                                didDropped(point: point, URL: url)
                                                result = true
                                        }
                                default:
                                        NSLog("[Error] performDragOperation: Others")
                                }
                        }
                }
                return result
        }

        open func didDropped(point pt: CGPoint, image img: NSImage) {
        }

        open func didDropped(point pt: CGPoint, URL url: URL) {
                if let sym = MISymbol.decode(fromURL: url) {
                        didDropped(point: pt, symbol: sym)
                        isReceivingDrag = false
                        NSLog("didDropped: \(isReceivingDrag)")
                } else {
                        NSLog("didDropped Point:\(pt.x):\(pt.y) URL:\(url.path) at \(#file)")
                }
        }

        open func didDropped(point pt: CGPoint, symbol sym: MISymbol) {
                NSLog("didDropped Point:\(pt.x):\(pt.y) Symbol:\(sym.name) at \(#file)")
        }

        #endif

        public override func accept(visitor vis: MIVisitor) {
                vis.visit(dropView: self)
        }
}
