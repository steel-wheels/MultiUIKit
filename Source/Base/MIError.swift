/*
 * @file MIErrpr.swift
 * @description Define MIError class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)


public class MIError
{
        private static let domain: String = "github.com.steel-wheels.MultiUIKit"
        
        class func errorLocationKey() -> String {
                return "errorLocation"
        }

        public enum ErrorCode: Int {
                case noError            = 0
                case bundleError
        }
        
        public static func error(errorCode ecode: ErrorCode, message msg: String?, location loc: String?) -> NSError {
                var uinfo: [String: Any] = [:]
                if let str = msg { uinfo[NSLocalizedDescriptionKey] = str }
                if let str = loc { uinfo[errorLocationKey()]        = str }
                return NSError(domain: MIError.domain, code: ecode.rawValue, userInfo: uinfo)
        }
        
        public static func error(errorCode ecode: ErrorCode, message msg: String) -> NSError {
                return error(errorCode: ecode, message: msg, location: nil)
        }

        public static func error(errorCode ecode: ErrorCode, message msg: String, file flstr: String, function fnstr: String) -> NSError {
                let location = "at " + fnstr + "in " + flstr
                return error(errorCode: ecode, message: msg, location: location)
        }
        
        public static func toString(error err: NSError) -> String {
                let dict : Dictionary = err.userInfo
                var message = err.localizedDescription
                let lockey : String = MIError.errorLocationKey()
                if let location = dict[lockey] as? String {
                        message = message + "in " + location
                }
                return message
        }
}

