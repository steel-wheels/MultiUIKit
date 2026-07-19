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

public class MIPanel
{
        public enum FileType: Int
        {
                case file
                case directory
        }

        #if os(OSX)
        public static func openPanel(title tl: String, type ftype: FileType, fileExtensions fexts: Array<String>) -> URL? {
                var result: URL? = nil
                Task {
                        result = await asyncOpenPanel(title: tl, type: ftype, fileExtensions: fexts)
                }
                return result
        }

        @MainActor
        private static func asyncOpenPanel(title tl: String, type ftype: FileType, fileExtensions fexts: Array<String>) -> URL? {
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

        @MainActor
        public static func savePanel(title tl: String, outputDirectory outdir: URL?, callback cbfunc: @escaping ((_: URL?) -> Void))
        {
                let panel = NSSavePanel()
                panel.title = tl
                panel.canCreateDirectories = true
                panel.showsTagField = false
                if let odir = outdir {
                        panel.directoryURL = odir
                }
                switch panel.runModal() {
                case .OK:
                        if let newurl = panel.url {
                                if FileManager.default.fileExists(atPath: newurl.path) {
                                        /* Bookmark this URL */
                                        Task { await MIBookmark.shared.add(URL: newurl) }
                                }
                                cbfunc(newurl)
                        } else {
                                cbfunc(nil)
                        }
                case .cancel:
                        cbfunc(nil)
                default:
                        NSLog("[Error] Unsupported result at \(#function) in \(#file)")
                        cbfunc(nil)
                }
        }

        #endif
}
