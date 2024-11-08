/*
 * @file MIWebViewCore.swift
 * @description Define MIWebViewCore class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)
import WebKit

public class MIWebViewCore: MICoreView
{
        #if os(iOS)
        @IBOutlet weak var mWebView: WKWebView!
        #else
        @IBOutlet weak var mWebView: WKWebView!
        #endif

        open override func setup() {
                super.setup(coreView: mWebView)
                mWebView.navigationDelegate = self
        }

        public func load(_ request: URLRequest) -> WKNavigation? {
                return mWebView.load(request)
        }
}

extension MIWebViewCore: WKNavigationDelegate
{
}


