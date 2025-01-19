/*
 * @file MITableCellView.swift
 * @description Define MITableCellView class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

#if os(iOS)

public class MITableCellView: UITableViewCell
{
        private var mTextField: UITextField

        public override init(style stl: UITableViewCell.CellStyle, reuseIdentifier ident: String?) {
                mTextField = UITextField()
                super.init(style: stl, reuseIdentifier: ident)
                setup()
        }

        required init?(coder: NSCoder) {
                mTextField = UITextField()
                super.init(coder: coder)
                setup()
        }

        private func setup() {
                self.addSubview(mTextField)
        }

        public func set(label lab: String) {
                mTextField.text = lab
        }
}

#else // os(iOS)

public class MITableCellView: NSTableCellView
{
        public override init(frame frameRect: NSRect) {
                super.init(frame: frameRect)
        }
        
        required init?(coder: NSCoder) {
                super.init(coder: coder)
        }

        public func set(label lab: String) {
                if let field = self.textField {
                        field.stringValue = lab
                } else {
                        NSLog("[Error] Failed to set label at \(#function)")
                }
        }
}

#endif // os(iOS)

