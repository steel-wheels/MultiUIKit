/*
 * @file MIStack.swift
 * @description Define MIStack class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)


open class MIStack: MIInterfaceView
{
        open override func setup(frame frm: CGRect) {
                super.setup(nibName: "MIStackCore", frameSize: frm.size)
        }

        private func coreStackView() -> MIStackCore {
                if let core: MIStackCore = super.coreView() {
                        return core
                } else {
                        fatalError("Failed to get core view")
                }
        }

        public var axis: MIStackCore.Axis {
                get {           return coreStackView().axis     }
                set(value){     coreStackView().axis = value    }
        }

        public var distribution: MIStackCore.Distribution {
                get         { return coreStackView().distribution   }
                set(newval) { coreStackView().distribution = newval }
        }

        public func addArrangedSubView(_ view: MIInterfaceView) {
                coreStackView().addArrangedSubView(view)
        }

        public func insertArrangedSubView(_ view: MIInterfaceView, at index: Int) {
                coreStackView().insertArrangedSubView(view, at: index)
        }

        public var arrangedSubviews: Array<MIInterfaceView> { get {
                return coreStackView().arrangedSubviews
        }}

        public func removeAllSubviews() {
                coreStackView().removeAllSubviews()
        }

        /*
         * support drop operation
         */
        public typealias DroppedCallback = (_ stack: MIStack, _ point: CGPoint, _ symbol: MISymbol) -> Void

        private var mDroppedCallback: DroppedCallback? = nil

        public func set(droppedCallback cbfunc: @escaping DroppedCallback) {
                mDroppedCallback = cbfunc
                #if os(OSX)
                registerForDraggedTypes(Array(acceptableTypes))
                #endif // os(OSX)
        }

#if os(OSX)
        private var acceptableTypes: Set<NSPasteboard.PasteboardType> { return [ .fileURL, .png ] }

        private let filteringOptions = [ NSPasteboard.ReadingOptionKey.urlReadingContentsConformToTypes:NSImage.imageTypes
        ]

        private func shouldAllowDrag(_ draggingInfo: NSDraggingInfo) -> Bool {
                guard let _ = mDroppedCallback else {
                        return false
                }

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

                guard let cbfunc = mDroppedCallback else {
                        NSLog("[Error] No callback function at \(#file)")
                        return false
                }

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
                                        break // ignore
                                case .fileURL, .URL:
                                        if let data = pasteboarditem.data(forType: type) {
                                                let url = NSURL(dataRepresentation: data, relativeTo: nil) as URL
                                                NSLog("performDragOperation: (url) get data: \(url.path)")
                                                if let sym = MISymbol.decode(fromURL: url) {
                                                        cbfunc(self, point, sym)
                                                        result = true
                                                } else {
                                                        NSLog("[Error] Failed to decode symbol at \(#file)")
                                                }
                                        }
                                default:
                                        NSLog("[Error] performDragOperation: Others")
                                }
                        }
                }
                return result
        }
#endif
}




