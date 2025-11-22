/**
 * @file MIViewDumper.swift
 * @brief  Define MIViewDumper class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

#if os(OSX)
import AppKit
#else
import UIKit
#endif
import Foundation


public class MIViewDumper: MIVisitor
{
        private var mIndent: Int

        public override init() {
                mIndent         = 0
        }

        private func dump(interfaceView ifv: MIInterfaceView) {
                dump(view: ifv, prefix: "")

                for constr in ifv.constraints {
                        dump(view: ifv, constraint: constr, prefix: "-")
                }

                if let core: MICoreView = ifv.coreView() {
                        dump(view: core, prefix: " -")

                        for constr in core.constraints {
                                dump(view: core, constraint: constr, prefix: "  -")
                        }
                }
        }

        private func dump(view v: MIBaseView, prefix pfx: String) {
                let spaces    = generateSpaces()
                let className = String(describing: type(of: v))
                let tag       = v.tag
                let framestr  = v.frame.description
                let boundsstr = v.bounds.description
                NSLog(spaces + "\(pfx)\(className) tag:\(tag) frame:\(framestr) bounds:\(boundsstr)")
        }

        private func dump(view parent: MIBaseView, constraint constr: NSLayoutConstraint, prefix pfx: String) {
               let spaces    = generateSpaces()
               let classname = String(describing: type(of: constr))

              let fstitm    = objectToString(soource: constr.firstItem)
              let fstanc    = objectToString(soource: constr.firstAnchor)
              let fstattr   = constr.firstAttribute.toString()

              let secitm    = objectToString(soource: constr.secondItem)
              let secanc    = objectToString(soource: constr.secondAnchor)
              let secattr   = constr.secondAttribute.toString()

              let relstr = constr.relation.toString()
              let conststr = constr.constant

              NSLog(spaces + "\(pfx)\(classname) {item:\(fstitm) anc:\(fstanc) attr:\(fstattr)}, {item:\(secitm) anc:\(secanc) attr:\(secattr)}, relation:\(relstr) constant:\(conststr)")
        }

       private func objectToString(soource obj: AnyObject?) -> String {
              let result: String
              if let o = obj {
                     result = String(describing: type(of: o))
              } else {
                     result = "-"
              }
              return result
       }

        private func dump(image img: MIImage) {
                let spaces    = generateSpaces()
                let imgstr    = img.size.description
                NSLog(spaces + "[image] size \(imgstr)")
        }

        private func generateSpaces() -> String {
                var spaces = ""
                for _ in 0..<mIndent { spaces += "    " }
                return spaces
        }

        public override func visit(button src: MIButton) {
                dump(interfaceView: src)
        }

        public override func visit(collectionView src: MICollectionView) {
                dump(interfaceView: src)
        }

        public override func visit(dropView src: MIDropView) {
                dump(interfaceView: src)
                mIndent += 1
                src.contentsView.accept(visitor: self)
                mIndent -= 1
        }

        public override func visit(fileSelector src: MIFileSelector) {
                dump(interfaceView: src)
        }

        #if os(OSX)
        public override func visit(iconView src: MIIconView) {
                dump(interfaceView: src)
        }
        #endif

        public override func visit(imageView src: MIImageView) {
                dump(interfaceView: src)
                mIndent += 1
                if let img = src.image {
                        dump(image: img)
                }
                mIndent -= 1
        }

        public override func visit(label src: MILabel) {
                dump(interfaceView: src)
        }

        public override func visit(popupMenu src: MIPopupMenu) {
                dump(interfaceView: src)
        }

        public override func visit(segmentedControl src: MISegmentedControl) {
                dump(interfaceView: src)
        }

        public override func visit(stack src: MIStack) {
                dump(interfaceView: src)

                mIndent += 1
                for child in src.arrangedSubviews {
                        child.accept(visitor: self)
                }
                mIndent -= 1
        }

        public override func visit(switchView src: MISwitch) {
                dump(interfaceView: src)
        }

        public override func visit(table src: MITable) {
                dump(interfaceView: src)
        }

        public override func visit(textField src: MITextField) {
                dump(interfaceView: src)
        }

        public override func visit(textView src: MITextView) {
                dump(interfaceView: src)
        }

        public override  func visit(webView src: MIWebView) {
                dump(interfaceView: src)
        }
}

