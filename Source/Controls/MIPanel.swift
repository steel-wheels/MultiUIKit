/*
 * @file MIPanel.swift
 * @description Define MIPanel class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)
import UniformTypeIdentifiers

#if os(OSX)

open class MIFilePanel
{
        public enum FileType: Int
        {
                case file
                case directory
        }
}

public class MIOpenPanel: MIFilePanel
{
        private var mSelected:          Bool
        private var mSelectedURL:       URL?

        public override init() {
                mSelected       = false
                mSelectedURL    = nil
        }

        public var selected: Bool { get {
                return mSelected
        }}

        public var selectedURL: URL? { get {
                return mSelectedURL
        }}

        public func show(title tl: String, type ftype: FileType, fileExtensions fexts: Array<String>)
        {
                Task {
                        mSelectedURL = await MIOpenPanel.showPanel(title: tl, type: ftype, fileExtensions: fexts)
                        mSelected    = true
                }
        }

        @MainActor
        public static func showPanel(title tl: String, type ftype: FileType, fileExtensions fexts: Array<String>) -> URL? {
                let panel = NSOpenPanel()
                panel.title = tl
                switch ftype {
                case .file:
                        panel.canChooseFiles       = true
                        panel.canChooseDirectories = false
                case .directory:
                        panel.canChooseFiles       = false
                        panel.canChooseDirectories = true
                }
                panel.allowsMultipleSelection = false

                var ctypes: Array<UTType> = []
                for fext in fexts {
                        if let utype = UTType(filenameExtension: fext) {
                                ctypes.append(utype)
                        } else {
                                NSLog("[Error] Unknown extension: \(fext) at \(#function) in \(#file)")
                        }
                }
                if ctypes.count > 0 {
                        panel.allowedContentTypes = ctypes
                }

                let result: URL?
                switch panel.runModal() {
                case .OK:
                        let urls = panel.urls
                        if urls.count >= 1 {
                                /* Bookmark this folder */
                                Task { await MIBookmark.shared.add(URL: urls[0]) }
                                result = urls[0]
                        } else {
                                result = nil
                        }
                case .cancel:
                        result = nil
                default:
                        NSLog("Unsupported result at \(#function) in \(#file)")
                        result = nil
                }
                return result
        }
}

public class MISavePanel: MIFilePanel
{
        private var mSelected:          Bool
        private var mSelectedURL:       URL?

        public override init() {
                mSelected       = false
                mSelectedURL    = nil
        }

        public var selected: Bool { get {
                return mSelected
        }}

        public var selectedURL: URL? { get {
                return mSelectedURL
        }}

        public func show(title tl: String, outputDirectory outdir: URL?)
        {
                Task {
                        mSelectedURL = await MISavePanel.showPanel(title: tl, outputDirectory: outdir)
                        mSelected    = true
                }
        }

        @MainActor
        public static func showPanel(title tl: String, outputDirectory outdir: URL?) -> URL?
        {
                let panel = NSSavePanel()
                panel.title = tl
                panel.canCreateDirectories = true
                panel.showsTagField = false
                if let odir = outdir {
                        panel.directoryURL = odir
                }
                let result: URL?
                switch panel.runModal() {
                case .OK:
                        if let newurl = panel.url {
                                if FileManager.default.fileExists(atPath: newurl.path) {
                                        /* Bookmark this URL */
                                        Task { await MIBookmark.shared.add(URL: newurl) }
                                }
                                result = newurl
                        } else {
                                result = nil
                        }
                case .cancel:
                        result = nil
                default:
                        NSLog("[Error] Unsupported result at \(#function) in \(#file)")
                        result = nil
                }
                return result
        }
}

#endif // os(OSX)

/*
public class MIPanel
{

        #if os(OSX)
        /*
        public static func asyncOpenPanel(title tl: String, type ftype: FileType, fileExtensions fexts: Array<String>) -> URL? {
                let semaphore = DispatchSemaphore(value: 0)
                var result: URL? = nil
                Task {
                        result = await syncOpenPanel(title: tl, type: ftype, fileExtensions: fexts)
                        semaphore.signal()
                }
                semaphore.wait()
                return result
        }*/





        #endif
}
*/


