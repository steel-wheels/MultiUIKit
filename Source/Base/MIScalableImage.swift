/**
 * @file MIScalableImage.swift
 * @brief  Define MIScalableImage class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

import Foundation
#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

public class MIScalableImage
{
        private var mOriginalImage:     MIImage
        private var mResizeImage:       MIImage?

        public init(image img: MIImage) {
                self.mOriginalImage     = img
                self.mResizeImage       = nil
        }

        public var image: MIImage {
                if let rimg = mResizeImage {
                        return rimg
                } else {
                        return mOriginalImage
                }
        }

        public var size: CGSize {
                return self.image.size
        }

        public func resize(to newsize: CGSize) {
                self.mResizeImage = mOriginalImage.resize(to: newsize)
        }
}
