/*
 * @file MITableCore.swift
 * @description Define MITableCore class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

#if os(iOS)
public typealias MITableDataSource      = UITableViewDataSource
public typealias MITableViewDelegate    = UITableViewDelegate
#else
public typealias MITableDataSource      = NSTableViewDataSource
public typealias MITableViewDelegate    = NSTableViewDelegate
#endif

public class MITableCore: MICoreView, MITableDataSource, MITableViewDelegate
{
        private static let CellIdentifier = "MITableCellView"

        #if os(iOS)
        @IBOutlet weak var mTableView: UITableView!
        #else
        @IBOutlet weak var mTableView: NSTableView!
        #endif

        private var mTableData: Array<String> = []

        open override func setup() {
                super.setup(coreView: mTableView)
                //NSLog("setup table view")
                mTableView.dataSource = self
                mTableView.delegate   = self
        }

        public func setTableData(_ data: Array<String>) {
                //NSLog("set table data")
                mTableData = data
                self.reload()
        }

        public func reload() {
                //NSLog("reload table data")
                mTableView.reloadData()
        }

        /*
         * DataSource
         */
        #if os(iOS)
        public func numberOfSections(in tableView: UITableView) -> Int {
                //NSLog("numberOfSections : 1")
                return 1
        }
        public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return mTableData.count
        }
        #else
        public func numberOfRows(in: NSTableView) -> Int {
                //NSLog("numberOfRows : \(mTableData.count)")
                return mTableData.count
        }
        #endif

        #if os(iOS)
        public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = UITableViewCell(style: .default, reuseIdentifier: MITableCore.CellIdentifier)
                let value: String
                if indexPath.section == 0 && indexPath.row < mTableData.count {
                        value = mTableData[indexPath.row]
                } else {
                        NSLog("[Error] Unsupported index: \(indexPath.section).\(indexPath.row)")
                        value = ""
                }
                if let label = cell.textLabel {
                        label.text = value
                }
                return cell
        }
        #else

        public func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
                //NSLog("table view for \(row)")
                if let view = mTableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: MITableCore.CellIdentifier), owner: mTableView) as? MITableCellView {
                        let value: String
                        if row < mTableData.count {
                                value = mTableData[row]
                        } else {
                                value = ""
                        }
                        //NSLog("tableView data \"\(value)\"")
                        view.set(label: value)
                        return view
                } else {
                        NSLog("[Error] Failed to allocate view at \(#function)")
                        return MITableCellView()
                }
        }

        #endif
}


