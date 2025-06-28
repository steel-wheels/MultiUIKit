/*
 * @file MIIconView.swift
 * @description Define MIIconView class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

/* MIIconView extend MIImageView to support draggin
 * Reference:
 *    Drag and Drop Tutorial for macOS
 *    https://srcw.net/wiki/?Drag+and+Drop+Tutorial+for+macOS#iba71ca8
 */
public class MIIconView: MIImageView, NSDraggingSource, NSPasteboardItemDataProvider
{
        open override func mouseDown(with event: NSEvent) {
                if let img = self.image {
                        let pasteboardItem = NSPasteboardItem()
                        pasteboardItem.setDataProvider(self, forTypes: [.png])

                        let draggingItem = NSDraggingItem(pasteboardWriter: pasteboardItem)
                        draggingItem.setDraggingFrame(self.bounds, contents: img)

                        beginDraggingSession(with: [draggingItem], event: event, source: self)
                } else {
                        super.mouseDown(with: event)
                }
        }

        public func draggingSession(_ session: NSDraggingSession, sourceOperationMaskFor context: NSDraggingContext) -> NSDragOperation {
                return.generic
        }

        public func pasteboard(_ pasteboard: NSPasteboard?, item: NSPasteboardItem, provideDataForType type: NSPasteboard.PasteboardType) {
                NSLog("paste board at \(#function)")
        }
}

