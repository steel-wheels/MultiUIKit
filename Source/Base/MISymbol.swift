/**
 * @file MISymbol.swift
 * @brief  Define MISymbol class
 * @par Copyright
 *   Copyright (C) 2021-2025 Steel Wheels Project
 */

#if os(OSX)
import AppKit
#else
import UIKit
#endif
import Foundation

public enum MISymbolSize: Int, Comparable
{
        public static  let TypeName = "SymbolSize"

        case character  =  21
        case small      =  60
        case regular    =  90
        case large      = 120

        public func toPointSize() -> CGFloat {
                return CGFloat(self.rawValue)
        }

        public func toSize() -> CGSize {
                let ptsize = CGFloat(self.rawValue)
                return CGSize(width: ptsize, height: ptsize)
        }

        public static func < (lhs: MISymbolSize, rhs: MISymbolSize) -> Bool {
                return lhs.toPointSize() < rhs.toPointSize()
        }
}

public enum MISymbol: Int
{
        public static let EnumName      = "Symbols"
        public static let InterfaceName = "SymbolIF"

        case character
        case checkmarkSquare
        case chevronBackward
        case chevronDown
        case chevronForward
        case chevronUp
        case game
        case gearshape
        case handPointUp
        case handRaised
        case house
        case lineDiagonal
        case line_1p                // image in resource
        case line_2p                // image in resource
        case line_4p                // image in resource
        case line_8p                // image in resource
        case line_16p
        case magnifyingglass
        case moonStars
        case oval
        case ovalFill
        case paintbrush
        case pencil
        case pencilCircle
        case pencilCircleFill
        case play
        case questionmark
        case rainbow
        case rectangle
        case rectangleFill
        case square
        case sunMax
        case sunMin
        case terminal

        public static var allCases: Array<MISymbol> { get {
                return [
                        .character,
                        .checkmarkSquare,
                        .chevronBackward,
                        .chevronDown,
                        .chevronForward,
                        .chevronUp,
                        .game,
                        .gearshape,
                        .handPointUp,
                        .handRaised,
                        .house,
                        .lineDiagonal,
                        .line_1p,
                        .line_2p,
                        .line_4p,
                        .line_8p,
                        .line_16p,
                        .magnifyingglass,
                        .moonStars,
                        .oval,
                        .ovalFill,
                        .paintbrush,
                        .pencil,
                        .pencilCircle,
                        .pencilCircleFill,
                        .play,
                        .questionmark,
                        .rainbow,
                        .rectangle,
                        .rectangleFill,
                        .square,
                        .sunMax,
                        .sunMin,
                        .terminal
                ]
        }}

        /* Name of SF symbol */
        public var name: String { get {
                let result: String
                switch self {
                case .character:                result = "character"
                case .checkmarkSquare:          result = "checkmark.square"
                case .chevronBackward:          result = "chevron.backward"
                case .chevronDown:              result = "chevron.down"
                case .chevronForward:           result = "chevron.forward"
                case .chevronUp:                result = "chevron.up"
                case .game:                     result = "gamecontroller"
                case .gearshape:                result = "gearshape"
                case .handPointUp:              result = "hand.point.up"
                case .handRaised:               result = "hand.raised"
                case .house:                    result = "house"
                case .lineDiagonal:             result = "line.diagonal"
                case .line_1p:                  result = "line.1p"
                case .line_2p:                  result = "line.2p"
                case .line_4p:                  result = "line.4p"
                case .line_8p:                  result = "line.8p"
                case .line_16p:                 result = "line.16p"
                case .magnifyingglass:          result = "magnifyingglass"
                case .moonStars:                result = "moon.stars"
                case .oval:                     result = "oval"
                case .ovalFill:                 result = "oval.fill"
                case .paintbrush:               result = "paintbrush"
                case .pencil:                result = "pencil"
                case .pencilCircle:        result = "pencil.circle"
                case .pencilCircleFill:        result = "pencil.circle.fill"
                case .play:                result = "play"
                case .questionmark:        result = "questionmark"
                case .rainbow:          result = "rainbow"
                case .rectangle:        result = "rectangle"
                case .rectangleFill:        result = "rectangle.fill"
                case .square:                result = "square"
                case .sunMax:                result = "sun.max"
                case .sunMin:                result = "sun.min"
                case .terminal:                result = "apple.terminal"
                }
                return result
        }}

        /* Name of Symbol enum */
        public var identifier: String { get {
                let result: String
                switch self {
                case .checkmarkSquare:        result = "checkmarkSquare"
                case .character:        result = "character"
                case .chevronBackward:        result = "chevronBackward"
                case .chevronDown:        result = "chevronDown"
                case .chevronForward:        result = "chevronForward"
                case .chevronUp:        result = "chevronUp"
                case .game:                result = "gamecontroller"
                case .gearshape:        result = "gearshape"
                case .handPointUp:        result = "handPointUp"
                case .handRaised:        result = "handRaised"
                case .house:                result = "house"
                case .lineDiagonal:        result = "lineDiagonal"
                case .line_1p:                result = "line1p"
                case .line_2p:                result = "line2p"
                case .line_4p:                result = "line4p"
                case .line_8p:                result = "line8p"
                case .line_16p:                result = "line16p"
                case .magnifyingglass:  result = "magnifyingglass"
                case .moonStars:        result = "moonStars"
                case .oval:                result = "oval"
                case .ovalFill:                result = "ovalFill"
                case .paintbrush:        result = "paintbrush"
                case .pencil:                result = "pencil"
                case .pencilCircle:        result = "pencilCircle"
                case .pencilCircleFill:        result = "pencilCircleFill"
                case .play:                result = "play"
                case .questionmark:        result = "questionmark"
                case .rainbow:          result = "rainbow"
                case .rectangle:        result = "rectangle"
                case .rectangleFill:        result = "rectangleFill"
                case .square:                result = "square"
                case .sunMax:                result = "sunMax"
                case .sunMin:                result = "sunMin"
                case .terminal:                result = "terminal"
                }
                return result
        }}

        public static func pencil(doFill fill: Bool) -> MISymbol {
                return fill ? .pencilCircleFill : .pencil
        }

        public static func path(doFill fill: Bool) -> MISymbol {
                return .lineDiagonal
        }

        public static func rectangle(doFill fill: Bool, hasRound round: Bool) -> MISymbol {
                return fill ? .rectangleFill : .rectangle
        }

        public static func oval(doFill fill: Bool) -> MISymbol {
                return fill ? .ovalFill : .oval
        }

        public static func decode(fromName name: String) -> MISymbol? {
                for sym in MISymbol.allCases {
                        if sym.name == name {
                                return sym
                        }
                }
                return nil
        }
}

private class MISymbolImage
{
        private var mSymbolName:    String
        private var mSymbolImages:  Dictionary<MISymbolSize, MIImage>

        public init(symbol sym: MISymbol) {
                mSymbolName   = sym.name
                mSymbolImages = [:]
        }

        public func load(size sz: MISymbolSize) -> MIImage {
                if let img = mSymbolImages[sz] {
                        return img
                } else if let img = loadSymbol(name: mSymbolName, size: sz) {
                        mSymbolImages[sz] = img
                        return img
                } else {
                        NSLog("[Error] Failed to load symbol: \(mSymbolName) atFunction: \(#function) in \(#file)")
                        return MIImage()
                }
        }

        private func loadSymbol(name nm: String, size sz: MISymbolSize) -> MIImage? {
                let conf = MIImage.SymbolConfiguration(pointSize: sz.toPointSize(), weight: .regular)
                #if os(OSX)
                        if let img = MIImage(symbolName: nm) {
                                if let cimg = img.withSymbolConfiguration(conf) {
                                        return cimg
                                } else {
                                        NSLog("[Error] Configuration failed at \(#function) in \(#file)")
                                }
                        }
                        return nil
                #else
                        return UIImage(systemName: nm, withConfiguration: conf)
                #endif
        }
}

@MainActor public class MISymbolTable
{
        public static var shared = MISymbolTable()

        private var mImageSymbols:      Dictionary<MISymbol, MISymbolImage>
        private var mMaxSymbolSizes:    Dictionary<MISymbolSize, CGSize>

        private init() {
                mImageSymbols   = [:]
                mMaxSymbolSizes = [:]
        }

        public func load(symbol sym: MISymbol, size sz: MISymbolSize) -> MIImage {
                let newimg: MISymbolImage
                if let img = mImageSymbols[sym] {
                        newimg = img
                } else {
                        let img = MISymbolImage(symbol: sym)
                        mImageSymbols[sym] = img
                        newimg = img
                }
                let img = newimg.load(size: sz)
                updateMaxSize(symbolSize: sz, imageSize: img.size)
                return img
        }

        public func maxSize(symbolSize sz: MISymbolSize) -> CGSize {
                if let z = mMaxSymbolSizes[sz] {
                        return z
                } else {
                        return CGSize.zero
                }
        }

        private func updateMaxSize(symbolSize ssize: MISymbolSize, imageSize isize: CGSize) {
                let cursize = maxSize(symbolSize: ssize)
                let maxwidth  = max(cursize.width,  isize.width)
                let maxheight = max(cursize.height, isize.height)
                mMaxSymbolSizes[ssize] = CGSize(width: maxwidth, height: maxheight)
        }
}


