/*
 * @file MIButton.swift
 * @description Define MIButton class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

import Foundation

public class MIButton: MIInterfaceView
{
        open override func setup(frame frm: CGRect) {
                super.setup(nibName: "MIButtonCore", frameSize: frm.size)
        }
}



