/*
 * @file MIWebView.swift
 * @description Define MIWebView class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)
import WebKit

public class MIWebView: MIInterfaceView
{
        open override func setup(frame frm: CGRect) {
                super.setup(nibName: "MIWebViewCore", frameSize: frm.size)
        }

        private func coreWebView() -> MIWebViewCore {
                if let core: MIWebViewCore = super.coreView() {
                        return core
                } else {
                        fatalError("Failed to get core view")
                }
        }

        public func load(_ request: URLRequest) -> WKNavigation? {
                return coreWebView().load(request)
        }

        public override func accept(visitor vis: MIVisitor) {
                vis.visit(webView: self)
        }
}
