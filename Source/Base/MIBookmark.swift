/*
 * @file MIBookmark.swift
 * @description Define MIBookmark class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)


public actor MIBookmark
{
        public let BookmarkItem                = "bookmark"

        public static var shared = MIBookmark()

        private var mURLTable: Dictionary<String, Data>

        private init() {
                mURLTable = [:]
        }

        public func add(URL url: URL) {
                let data = URLToData(URL: url)
                mURLTable[url.path] = data
        }

        public func search(pathString path: String) -> URL? {
                if let data = mURLTable[path] {
                        return dataToURL(bookmarkData: data)
                } else {
                        return nil
                }
        }

        public func clear() {
                mURLTable = [:]
        }

        private func URLToData(URL url: URL) -> Data {
                do {
                        #if os(OSX)
                                let data = try url.bookmarkData(options: .withSecurityScope, includingResourceValuesForKeys: nil, relativeTo: nil)
                        #else
                                let data = try url.bookmarkData(options: .suitableForBookmarkFile, includingResourceValuesForKeys: nil, relativeTo: nil)
                        #endif
                        return data
                } catch {
                        let err = error as NSError
                        fatalError("\(err.description)")
                }
        }

        private func dataToURL(bookmarkData bmdata: Data) -> URL? {
                do {
                        var isstale: Bool = false
                        #if os(OSX)
                                let newurl = try URL(resolvingBookmarkData: bmdata, options: .withSecurityScope, relativeTo: nil, bookmarkDataIsStale: &isstale)
                        #else
                                let newurl = try URL(resolvingBookmarkData: bmdata, options: .withoutUI, relativeTo: nil, bookmarkDataIsStale: &isstale)
                        #endif
                        return newurl
                }
                catch {
                        let err = error as NSError
                        NSLog("[Error] \(err.description) at \(#function) in \(#file))")
                        return nil
                }
        }
}
