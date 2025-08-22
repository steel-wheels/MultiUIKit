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
        private var mSymbol: MISymbol? = nil

        public override func set(symbol sym: MISymbol, size sz: MISymbolSize){
                super.set(symbol: sym, size: sz)
                mSymbol = sym
        }

        open override func mouseDown(with event: NSEvent) {
                if let img = self.image {
                        let pasteboardItem = NSPasteboardItem()
                        pasteboardItem.setDataProvider(self, forTypes: [.png, .fileURL])

                        let draggingItem = NSDraggingItem(pasteboardWriter: pasteboardItem)
                        let imgframe     = CGRect(origin: CGPoint.zero, size: img.size)
                        draggingItem.setDraggingFrame(imgframe, contents: img)

                        beginDraggingSession(with: [draggingItem], event: event, source: self)
                } else {
                        super.mouseDown(with: event)
                }
        }

        public func draggingSession(_ session: NSDraggingSession, sourceOperationMaskFor context: NSDraggingContext) -> NSDragOperation {
                return.generic
        }

        public func pasteboard(_ pasteboard: NSPasteboard?, item: NSPasteboardItem, provideDataForType type: NSPasteboard.PasteboardType) {
                guard let pboard = pasteboard else {
                        NSLog("[Error: pasteboard.setData: no board")
                        return
                }
                switch type {
                case .png:
                        if let img = super.image {
                                //NSLog("pasteboard.setData: image")
                                pboard.setData(img.pngData(), forType: .png)
                        } else {
                                NSLog("[Error] Not image at \(#function)")
                        }
                case .fileURL, .URL:
                        if let sym = mSymbol {
                                //NSLog("pasteboard.setData: fileURL")
                                let url = sym.encodeToURL() as NSURL
                                pboard.setData(url.dataRepresentation, forType: .fileURL)
                        } else {
                                NSLog("[Error] Not fileurl at \(#function)")
                        }
                default:
                        NSLog("[Error] Unsupported type")
                }
        }
}

