/*
 * @file MITable.swift
 * @description Define MITable class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)


public class MITable: MIInterfaceView
{
        open override func setup(frame frm: CGRect) {
                super.setup(nibName: "MITableCore", frameSize: frm.size)
        }

        private func coreTableView() -> MITableCore {
                if let core: MITableCore = super.coreView() {
                        return core
                } else {
                        fatalError("Failed to get core view")
                }
        }

        public func setTableData(_ data: Array<String>) {
                coreTableView().setTableData(data)
        }

        public func setHeaderTitle(_ title: String?) {
                coreTableView().setHeaderTitle(title)
        }

        public func reload() {
                coreTableView().reload()
        }

        public override func accept(visitor vis: MIVisitor) {
                vis.visit(table: self)
        }
}






