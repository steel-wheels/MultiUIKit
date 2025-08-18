/*
 * @file MICollectionViewCore.swift
 * @description Define MICollectionViewCore class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

#if os(OSX)
public typealias MICollectionViewDataSource = NSCollectionViewDataSource
#else
public typealias MICollectionViewDataSource = UICollectionViewDataSource
#endif

public class MICollectionViewCore: MICoreView, MICollectionViewDataSource
{
        #if os(OSX)
        @IBOutlet weak var mCollectionView: NSCollectionView!
        #else
        @IBOutlet weak var mCollectionView: UICollectionView!
        #endif

        private var mSymbols: Array<MISymbol> = []

        open override func setup() {
                super.setup(coreView: mCollectionView)
                mCollectionView.dataSource = self
        }

        public func set(symbols syms: Array<MISymbol>){
                mSymbols = syms
        }

        private func symbol(at index: Int) -> MISymbol {
                let symbol: MISymbol
                if 0 <= index && index < mSymbols.count {
                        symbol = mSymbols[index]
                } else {
                        symbol = .character
                }
                return symbol
        }

        #if os(OSX)
        public func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
                return mSymbols.count
        }

        public func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
                return MICollectionViewItem(symbol: symbol(at: indexPath.item))
        }
        #else

        public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                return mSymbols.count
        }

        public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                /* reference: https://www.toyship.org/2022/02/17/095834 */
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UICollectionViewListCell

                let sym = symbol(at: indexPath.item)
                let img = MIImage(symbolName: sym.name)

                var cellConfiguration = cell.defaultContentConfiguration()
                //cellConfiguration.text = info.title
                //cellConfiguration.secondaryText = info.subTitle
                cellConfiguration.image = img
                //UIImage(systemName: info.iconName)
                cell.contentConfiguration = cellConfiguration
                return cell
        }

        #endif
}

#if os(OSX)

public class MICollectionViewItem: NSCollectionViewItem
{
        private var mImageView:         MIImageView

        public init(symbol sym: MISymbol){
                mImageView = MIImageView()
                mImageView.set(symbol: sym, size: .regular)
                super.init(nibName: nil, bundle: nil)
                self.view = mImageView
        }

        required init?(coder: NSCoder) {
                fatalError("Do not call this constructor")
        }

        public var intrinsicContentsSize: CGSize { get {
                return mImageView.intrinsicContentSize
        }}

        public func setFrameSize(_ size: CGSize) {
                self.view.setFrameSize(size)
                mImageView.setFrameSize(size)
        }
}

#endif

/*
public class MICollectionViewItem: UICollectionViewCell
{
        public typealias CallbackFunction = (_ index: Int) -> Void
        public var buttonPressedCallback: CallbackFunction? = nil

        private var mImageView:         MIImageView? = nil

        public func set(symbol sym: MISymbol){
                let imgview = MIImageView()
                imgview.set(symbol: sym, size: .regular)
                mImageView = imgview
                self. = imgview
        }

        public var intrinsicContentsSize: CGSize { get {
                if let imgview = mImageView {
                        return imgview.intrinsicContentSize
                } else {
                        return CGSize.zero
                }
        }}
}

*/


