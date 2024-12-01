/*
 * @file MISegmentedControl.swift
 * @description Define MISegmentedControl class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

public class MISegmentedControlCore: MICoreView
{
        public typealias CallbackFunction = (_ item: MIMenuItem?) -> Void

#if os(iOS)
        @IBOutlet weak var mSegmentedControl: UISegmentedControl!

        @IBAction func mAction(_ sender: Any) { self.updated() }
#else
        @IBOutlet weak var mSegmentedControl: NSSegmentedControl!

        @IBAction func mAction(_ sender: Any) { self.updated() }
#endif

        private var mMenuItems: Array<MIMenuItem> = []
        private var mCallbackFunction:  CallbackFunction? = nil

        open override func setup() {
                super.setup(coreView: mSegmentedControl)
        }

        public func setCallback(_ cbfunc: @escaping CallbackFunction){
                mCallbackFunction = cbfunc
        }

        public var segmentCount: Int { get {
                #if os(iOS)
                        return mSegmentedControl.numberOfSegments
                #else
                        return mSegmentedControl.segmentCount
                #endif
        }}

        public func setMenuItems( items: Array<MIMenuItem>) {
                mMenuItems = items
                #if os(iOS)
                        let count = items.count
                        mSegmentedControl.removeAllSegments()
                        for i in 0..<count {
                                let item = items[i]
                                mSegmentedControl.insertSegment(withTitle: item.title, at: i, animated: false)
                        }
                #else
                        let count = items.count
                        mSegmentedControl.segmentCount = count
                        for i in 0..<count {
                                let item = items[i]
                                mSegmentedControl.setLabel(item.title, forSegment: i)
                        }
                #endif
                mSegmentedControl.invalidateIntrinsicContentSize()

                /* set default selection */
                selectSegment(index: 0)
        }

        public func selectSegment(index idx: Int) {
                if 0 <= idx && idx < mMenuItems.count {
                        #if os(iOS)
                                mSegmentedControl.selectedSegmentIndex = idx
                        #else
                                mSegmentedControl.setEnabled(true, forSegment: idx)
                        #endif
                }
        }

        public var selectedSegment: MIMenuItem? { get {
                #if os(iOS)
                let idx = mSegmentedControl.selectedSegmentIndex
                #else
                let idx = mSegmentedControl.selectedSegment
                #endif
                if 0 <= idx && idx < mMenuItems.count {
                        return mMenuItems[idx]
                } else {
                        return nil
                }
        }}

        private func updated() {
                if let cbfunc = mCallbackFunction {
                        cbfunc(self.selectedSegment)
                } else {
                        NSLog("updated at \(#function) in \(#file)")
                }
        }
}

