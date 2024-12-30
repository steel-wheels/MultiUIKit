//
//  TabViews.swift
//  TagViewTest_iOS
//
//  Created by Tomoo Hamada on 2024/12/26.
//

import MultiUIKit
import Foundation

public class TabView0: MIStack {
        public func setup(label lab: String) {
                let label = MILabel()
                label.title = lab
                super.addArrangedSubView(label)
        }
}

public class TabView1: MIStack {
        public func setup(label lab: String) {
                let label = MILabel()
                label.title = lab
                super.addArrangedSubView(label)
        }
}
