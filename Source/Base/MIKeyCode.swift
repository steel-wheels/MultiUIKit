/*
 * @file MIKeyCode.swift
 * @description Define MIKeCode type
 * @par Copyright
 *   Copyright (C) 2026 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

public enum MIKeyCode
{
        case string(String)
        case command(String)
        case funcCode(Int)
        case backspaceCode
        case backtabCode
        case beginCode
        case breakCode
        case carriageReturnCode
        case clearDisplayCode
        case clearLineCode
        case deleteCode
        case deleteCharacterCode
        case deleteForwardCode
        case deleteLineCode
        case downArrowCode
        case endCode
        case enterCode
        case executeCode
        case findCode
        case formfeedCode
        case helpCode
        case homeCode
        case insertCode
        case insertCharacterCode
        case insertLineCode
        case leftArrowCode
        case lineSeparatorCode
        case menuCode
        case menuSwitchCode
        case newlineCode
        case nextCode
        case pageDownCode
        case pageUpCode
        case paragraphSeparatorCode
        case pauseCode
        case prevCode
        case printCode
        case printScreenCode
        case redoCode
        case resetCode
        case rightArrowCode
        case scrollLockCode
        case selectCode
        case stopCode
        case sysReqCode
        case systemCode
        case tabCode
        case undoCode
        case upArrowCode
        case userCode

        static private let ESC                          = "\u{1b}"

        static private let FuncPrefix:     Character    = "#"
        static private let CommandPrefix:  Character    = "["
        static private let CommandPostfix: Character    = "]"

        static private let BackspaceStr                 = "BKS"
        static private let BacktabStr                   = "BKT"
        static private let BeginStr                     = "BGN"
        static private let BreakStr                     = "BRK"
        static private let CarriageReturnStr            = "CR-"
        static private let ClearDisplayStr              = "CD-"
        static private let ClearLineStr                 = "CL-"
        static private let DeleteStr                    = "D--"
        static private let DeleteCharacterStr           = "DC-"
        static private let DeleteForwardStr             = "DF-"
        static private let DeleteLineStr                = "DL-"
        static private let DownArrowStr                 = "DA-"
        static private let EndStr                       = "END"
        static private let EnterStr                     = "ENT"
        static private let ExecuteStr                   = "EXE"
        static private let FindStr                      = "FND"
        static private let FormFeedStr                  = "FFD"
        static private let HelpStr                      = "HLP"
        static private let HomeStr                      = "HME"
        static private let InsertCharacterStr           = "ISC"
        static private let InsertStr                    = "INS"
        static private let InsertLineStr                = "ISL"
        static private let LeftArrowStr                 = "LA-"
        static private let LineSeparatorStr             = "LS-"
        static private let MenuStr                      = "MEN"
        static private let MenuSwitchStr                = "MNS"
        static private let NewlineStr                   = "NL-"
        static private let NextStr                      = "NXT"
        static private let PageDownStr                  = "PDN"
        static private let PageUpStr                    = "PUP"
        static private let ParagraphSeparatorStr        = "PS-"
        static private let PauseStr                     = "PAU"
        static private let PrevStr                      = "PRV"
        static private let PrintStr                     = "PRT"
        static private let PrintScreenStr               = "PRS"
        static private let RedoStr                      = "RDO"
        static private let ResetStr                     = "RST"
        static private let RightArrowStr                = "RA-"
        static private let ScrollLockStr                = "SCL"
        static private let SelectStr                    = "SEL"
        static private let StopStr                      = "STP"
        static private let SysReqStr                    = "SYR"
        static private let SystemStr                    = "SYS"
        static private let TabStr                       = "TAB"
        static private let UndoStr                      = "UND"
        static private let UpArrowStr                   = "UA-"
        static private let UserStr                      = "USR"

        public var description: String { get {
                let result: String
                switch self {
                case .string(let str):          result = "string(\(str))"
                case .command(let str):         result = "command(\(str))"
                case .funcCode(let num):        result = "func(\(num))"
                case .backspaceCode:            result = "backspace"
                case .backtabCode:              result = "backtab"
                case .beginCode:                result = "begin"
                case .breakCode:                result = "break"
                case .carriageReturnCode:       result = "carriageReturn"
                case .clearDisplayCode:         result = "clearDisplay"
                case .clearLineCode:            result = "clearLine"
                case .deleteCharacterCode:      result = "deleteCharacter"
                case .deleteCode:               result = "delete"
                case .deleteForwardCode:        result = "deleteForward"
                case .deleteLineCode:           result = "deleteLine"
                case .downArrowCode:            result = "downArrow"
                case .endCode:                  result = "end"
                case .enterCode:                result = "enter"
                case .executeCode:              result = "execute"
                case .findCode:                 result = "find"
                case .formfeedCode:             result = "formfeed"
                case .helpCode:                 result = "help"
                case .homeCode:                 result = "home"
                case .insertCharacterCode:      result = "insertCharacter"
                case .insertCode:               result = "insert"
                case .insertLineCode:           result = "insertLine"
                case .leftArrowCode:            result = "leftArrow"
                case .lineSeparatorCode:        result = "lineSeparator"
                case .menuCode:                 result = "menu"
                case .menuSwitchCode:           result = "menuSwitch"
                case .newlineCode:              result = "newline"
                case .nextCode:                 result = "next"
                case .pageDownCode:             result = "pageDown"
                case .pageUpCode:               result = "pageUp"
                case .paragraphSeparatorCode:   result = "paragraphSeparator"
                case .pauseCode:                result = "pause"
                case .prevCode:                 result = "prev"
                case .printCode:                result = "print"
                case .printScreenCode:          result = "printScreen"
                case .redoCode:                 result = "redo"
                case .resetCode:                result = "reset"
                case .rightArrowCode:           result = "rightArrow"
                case .scrollLockCode:           result = "scrollLock"
                case .selectCode:               result = "select"
                case .stopCode:                 result = "stop"
                case .sysReqCode:               result = "sysReq"
                case .systemCode:               result = "system"
                case .tabCode:                  result = "tab"
                case .undoCode:                 result = "undo"
                case .upArrowCode:              result = "upArrow"
                case .userCode:                 result = "user"
                }
                return result
        }}

        public func encode() -> String {
                let result: String
                switch self {
                case .string(let str):          result = str
                case .command(let str):         result = MIKeyCode.ESC
                                                       + String(MIKeyCode.CommandPrefix)
                                                       + str
                                                       + String(MIKeyCode.CommandPostfix)
                case .funcCode(let num):
                        let f = String(MIKeyCode.FuncPrefix)
                        let numstr: String = num < 10 ? "\(f)0\(num)" : "\(f)\(num)"
                        result = MIKeyCode.ESC + numstr
                case .backspaceCode:            result = MIKeyCode.ESC + MIKeyCode.BackspaceStr
                case .backtabCode:              result = MIKeyCode.ESC + MIKeyCode.BacktabStr
                case .beginCode:                result = MIKeyCode.ESC + MIKeyCode.BeginStr
                case .breakCode:                result = MIKeyCode.ESC + MIKeyCode.BreakStr
                case .carriageReturnCode:       result = MIKeyCode.ESC + MIKeyCode.CarriageReturnStr
                case .clearDisplayCode:         result = MIKeyCode.ESC + MIKeyCode.ClearDisplayStr
                case .clearLineCode:            result = MIKeyCode.ESC + MIKeyCode.ClearLineStr
                case .deleteCode:               result = MIKeyCode.ESC + MIKeyCode.DeleteStr
                case .deleteCharacterCode:      result = MIKeyCode.ESC + MIKeyCode.DeleteCharacterStr
                case .deleteForwardCode:        result = MIKeyCode.ESC + MIKeyCode.DeleteForwardStr
                case .deleteLineCode:           result = MIKeyCode.ESC + MIKeyCode.DeleteLineStr
                case .downArrowCode:            result = MIKeyCode.ESC + MIKeyCode.DownArrowStr
                case .endCode:                  result = MIKeyCode.ESC + MIKeyCode.EndStr
                case .enterCode:                result = MIKeyCode.ESC + MIKeyCode.EnterStr
                case .executeCode:              result = MIKeyCode.ESC + MIKeyCode.ExecuteStr
                case .findCode:                 result = MIKeyCode.ESC + MIKeyCode.FindStr
                case .formfeedCode:             result = MIKeyCode.ESC + MIKeyCode.FormFeedStr
                case .helpCode:                 result = MIKeyCode.ESC + MIKeyCode.HelpStr
                case .homeCode:                 result = MIKeyCode.ESC + MIKeyCode.HomeStr
                case .insertCharacterCode:      result = MIKeyCode.ESC + MIKeyCode.InsertCharacterStr
                case .insertCode:               result = MIKeyCode.ESC + MIKeyCode.InsertStr
                case .insertLineCode:           result = MIKeyCode.ESC + MIKeyCode.InsertLineStr
                case .leftArrowCode:            result = MIKeyCode.ESC + MIKeyCode.LeftArrowStr
                case .lineSeparatorCode:        result = MIKeyCode.ESC + MIKeyCode.LineSeparatorStr
                case .menuCode:                 result = MIKeyCode.ESC + MIKeyCode.MenuStr
                case .menuSwitchCode:           result = MIKeyCode.ESC + MIKeyCode.MenuSwitchStr
                case .newlineCode:              result = MIKeyCode.ESC + MIKeyCode.NewlineStr
                case .nextCode:                 result = MIKeyCode.ESC + MIKeyCode.NextStr
                case .pageDownCode:             result = MIKeyCode.ESC + MIKeyCode.PageDownStr
                case .pageUpCode:               result = MIKeyCode.ESC + MIKeyCode.PageUpStr
                case .paragraphSeparatorCode:   result = MIKeyCode.ESC + MIKeyCode.ParagraphSeparatorStr
                case .pauseCode:                result = MIKeyCode.ESC + MIKeyCode.PauseStr
                case .prevCode:                 result = MIKeyCode.ESC + MIKeyCode.PrevStr
                case .printCode:                result = MIKeyCode.ESC + MIKeyCode.PrintStr
                case .printScreenCode:          result = MIKeyCode.ESC + MIKeyCode.PrintScreenStr
                case .redoCode:                 result = MIKeyCode.ESC + MIKeyCode.RedoStr
                case .resetCode:                result = MIKeyCode.ESC + MIKeyCode.ResetStr
                case .rightArrowCode:           result = MIKeyCode.ESC + MIKeyCode.RightArrowStr
                case .scrollLockCode:           result = MIKeyCode.ESC + MIKeyCode.ScrollLockStr
                case .selectCode:               result = MIKeyCode.ESC + MIKeyCode.SelectStr
                case .stopCode:                 result = MIKeyCode.ESC + MIKeyCode.StopStr

                case .sysReqCode:               result = MIKeyCode.ESC + MIKeyCode.SysReqStr
                case .systemCode:               result = MIKeyCode.ESC + MIKeyCode.SystemStr
                case .tabCode:                  result = MIKeyCode.ESC + MIKeyCode.TabStr
                case .undoCode:                 result = MIKeyCode.ESC + MIKeyCode.UndoStr
                case .upArrowCode:              result = MIKeyCode.ESC + MIKeyCode.UpArrowStr
                case .userCode:                 result = MIKeyCode.ESC + MIKeyCode.UserStr
                }
                return result
        }

        public static func decode(string str: String) -> Result<Array<MIKeyCode>, NSError> {
                var result: Array<MIKeyCode> = []
                var buffer = ""
                var idx    = str.startIndex
                let endidx = str.endIndex
                while idx < endidx {
                        let c = str[idx]
                        if c == Character(ESC) {
                                /* flush the buffer */
                                if !buffer.isEmpty {
                                        result.append(.string(buffer))
                                        buffer = ""
                                }
                                idx = str.index(after: idx)

                                switch decodeEscapeCode(index: &idx, string: str) {
                                case .success(let code):
                                        result.append(code)
                                case .failure(let err):
                                        return .failure(err)
                                }
                        } else {
                                buffer.append(c)
                                idx = str.index(after: idx)
                        }
                }
                if !buffer.isEmpty {
                        result.append(.string(buffer))
                        buffer = ""
                }
                return .success(result)
        }

        public static func decodeEscapeCode(index idx: inout String.Index, string str: String) -> Result<MIKeyCode, NSError> {
                let endidx = str.endIndex
                guard idx < endidx else {
                        let err = MIError.error(errorCode: .parseError,
                                message: "Unexpected end of string at \(#file)")
                        return .failure(err)
                }
                let c0 = str[idx]
                if c0 == MIKeyCode.CommandPrefix {
                        var decoded = false
                        var cmdstr: String = ""
                        idx = str.index(after: idx)
                        while !decoded {
                                if idx < endidx {
                                        let c1 = str[idx]
                                        if c1 == MIKeyCode.CommandPostfix {
                                                decoded = true
                                        } else {
                                                cmdstr.append(c1)
                                        }
                                } else {
                                        let err = MIError.error(errorCode: .parseError,
                                                message: "Unexpected end of string at \(#file)")
                                        return .failure(err)
                                }
                                idx = str.index(after: idx)
                        }
                        return .success(.command(cmdstr))
                } else {
                        /* collect 3 characters */
                        var codestr: Array<Character> = []
                        for _ in 0..<3 {
                                if idx < endidx {
                                        codestr.append(str[idx])
                                } else {
                                        let err = MIError.error(
                                                errorCode: .parseError,
                                                message: "Unexpected end of string at \(#file)")
                                        return .failure(err)
                                }
                                idx = str.index(after: idx)
                        }
                        switch decodeSpecialCode(string: codestr){
                        case .success(let code):
                                return .success(code)
                        case .failure(let err):
                                return .failure(err)
                        }
                }
        }

        public static func decodeSpecialCode(string str: Array<Character>) -> Result<MIKeyCode, NSError> {
                if str[0] == MIKeyCode.FuncPrefix {
                        if let v1 = Int(String(str[1])), let v0 = Int(String(str[2])) {
                                return .success(.funcCode(v1 * 10 + v0))
                        } else {
                                let err = MIError.error(errorCode: .parseError,
                                        message: "Integer is expected at \(#file)")
                                return .failure(err)
                        }
                } else {
                        let table: Dictionary<String, MIKeyCode> = [
                                BackspaceStr:           .backspaceCode,
                                BacktabStr:             .backtabCode,
                                BeginStr:               .beginCode,
                                BreakStr:               .breakCode,
                                CarriageReturnStr:      .carriageReturnCode,
                                ClearDisplayStr:        .clearDisplayCode,
                                ClearLineStr:           .clearLineCode,
                                DeleteStr:              .deleteCode,
                                DeleteCharacterStr:     .deleteCharacterCode,
                                DeleteForwardStr:       .deleteForwardCode,
                                DeleteLineStr:          .deleteLineCode,
                                DownArrowStr:           .downArrowCode,
                                EndStr:                 .endCode,
                                EnterStr:               .enterCode,
                                ExecuteStr:             .executeCode,
                                FindStr:                .findCode,
                                FormFeedStr:            .formfeedCode,
                                HelpStr:                .helpCode,
                                HomeStr:                .homeCode,
                                InsertCharacterStr:     .insertCharacterCode,
                                InsertStr:              .insertCode,
                                InsertLineStr:          .insertLineCode,
                                LeftArrowStr:           .leftArrowCode,
                                LineSeparatorStr:       .lineSeparatorCode,
                                MenuStr:                .menuCode,
                                MenuSwitchStr:          .menuSwitchCode,
                                NewlineStr:             .newlineCode,
                                NextStr:                .nextCode,
                                PageDownStr:            .pageDownCode,
                                PageUpStr:              .pageUpCode,
                                ParagraphSeparatorStr:  .paragraphSeparatorCode,
                                PauseStr:               .pauseCode,
                                PrevStr:                .prevCode,
                                PrintStr:               .printCode,
                                PrintScreenStr:         .printScreenCode,
                                RedoStr:                .redoCode,
                                ResetStr:               .resetCode,
                                RightArrowStr:          .rightArrowCode,
                                ScrollLockStr:          .scrollLockCode,
                                SelectStr:              .selectCode,
                                StopStr:                .stopCode,
                                SysReqStr:              .sysReqCode,
                                SystemStr:             .systemCode,
                                TabStr:                 .tabCode,
                                UndoStr:                .undoCode,
                                UpArrowStr:             .upArrowCode,
                                UserStr:                .userCode
                        ]
                        let keycode = String(str)
                        if let code = table[keycode] {
                                return .success(code)
                        } else {
                                let err = MIError.error(errorCode: .parseError,
                                        message: "Unknown key code \(keycode) at \(#file)")
                                return .failure(err)
                        }
                }
        }

        #if os(macOS)
        public static func generate(event evt: NSEvent) -> Array<MIKeyCode> {
                var result: Array<MIKeyCode> = []
                if let special = evt.specialKey {
                        let code: MIKeyCode
                        switch special {
                        case .backspace:        code = .backspaceCode
                        case .backTab:          code = .backtabCode
                        case .begin:            code = .beginCode
                        case .break:            code = .breakCode
                        case .carriageReturn:   code = .carriageReturnCode
                        case .clearDisplay:     code = .clearDisplayCode
                        case .clearLine:        code = .clearLineCode
                        case .delete:           code = .deleteCode
                        case .deleteCharacter:  code = .deleteCharacterCode
                        case .deleteForward:    code = .deleteForwardCode
                        case .deleteLine:       code = .deleteLineCode
                        case .downArrow:        code = .downArrowCode
                        case .end:              code = .endCode
                        case .enter:            code = .enterCode
                        case .execute:          code = .executeCode
                        case .f1:               code = .funcCode(1)
                        case .f2:               code = .funcCode(2)
                        case .f3:               code = .funcCode(3)
                        case .f4:               code = .funcCode(4)
                        case .f5:               code = .funcCode(5)
                        case .f6:               code = .funcCode(6)
                        case .f7:               code = .funcCode(7)
                        case .f8:               code = .funcCode(8)
                        case .f9:               code = .funcCode(9)
                        case .f10:              code = .funcCode(10)
                        case .f11:              code = .funcCode(11)
                        case .f12:              code = .funcCode(12)
                        case .f13:              code = .funcCode(13)
                        case .f14:              code = .funcCode(14)
                        case .f15:              code = .funcCode(15)
                        case .f16:              code = .funcCode(16)
                        case .f17:              code = .funcCode(17)
                        case .f18:              code = .funcCode(18)
                        case .f19:              code = .funcCode(19)
                        case .f20:              code = .funcCode(20)
                        case .f21:              code = .funcCode(21)
                        case .f22:              code = .funcCode(22)
                        case .f23:              code = .funcCode(23)
                        case .f24:              code = .funcCode(24)
                        case .f25:              code = .funcCode(25)
                        case .f26:              code = .funcCode(26)
                        case .f27:              code = .funcCode(27)
                        case .f28:              code = .funcCode(28)
                        case .f29:              code = .funcCode(29)
                        case .f30:              code = .funcCode(30)
                        case .f31:              code = .funcCode(31)
                        case .f32:              code = .funcCode(32)
                        case .f33:              code = .funcCode(33)
                        case .f34:              code = .funcCode(34)
                        case .f35:              code = .funcCode(35)
                        case .find:             code = .findCode
                        case .formFeed:         code = .formfeedCode
                        case .help:             code = .helpCode
                        case .home:             code = .homeCode
                        case .insert:           code = .insertCode
                        case .insertCharacter:  code = .insertCharacterCode
                        case .insertLine:       code = .insertLineCode
                        case .leftArrow:        code = .leftArrowCode
                        case .lineSeparator:    code = .lineSeparatorCode
                        case .menu:             code = .menuCode
                        case .modeSwitch:       code = .menuSwitchCode
                        case .newline:          code = .newlineCode
                        case .next:             code = .nextCode
                        case .pageDown:         code = .pageDownCode
                        case .pageUp:           code = .pageUpCode
                        case .paragraphSeparator:       code = .paragraphSeparatorCode
                        case .pause:            code = .pauseCode
                        case .prev:             code = .prevCode
                        case .print:            code = .printCode
                        case .printScreen:      code = .printScreenCode
                        case .redo:             code = .redoCode
                        case .reset:            code = .resetCode
                        case .rightArrow:       code = .rightArrowCode
                        case .scrollLock:       code = .scrollLockCode
                        case .select:           code = .selectCode
                        case .stop:             code = .stopCode
                        case .sysReq:           code = .sysReqCode
                        case .system:           code = .systemCode
                        case .tab:              code = .tabCode
                        case .undo:             code = .undoCode
                        case .upArrow:          code = .upArrowCode
                        case .user:             code = .userCode
                        default:
                                NSLog("[Error] Unknown code at \(#file)")
                                code = .systemCode
                        }
                        result.append(code)
                }

                /* check modification */
                if evt.modifierFlags.contains([.command]) {
                        if let str = evt.characters {
                                result.append(.command(str))
                        }
                } else {
                        if let str = evt.characters {
                                result.append(.string(str))
                        }
                }
                return result
        }
        #endif
}
