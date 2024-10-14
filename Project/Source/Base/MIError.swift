/*
 * @file MIErrpr.swift
 * @description Define MIError class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

import Foundation

public class MIError
{
        private static let domain: String = "github.com.steel-wheels.MultiUIKit"
        
        public enum ErrorCode: Int {
                case noError            = 0
                case bundleError
        }
        
        public static func error(errorCode ecode: ErrorCode, message msg: String) -> NSError {
                let uinfo: [String: Any] = [NSLocalizedDescriptionKey: msg]
                return NSError(domain: MIError.domain, code: ecode.rawValue, userInfo: uinfo)
        }

        public static func error(errorCode ecode: ErrorCode, message msg: String, file flstr: String, function fnstr: String) -> NSError {
                let allmsg = msg + " at function " + fnstr + "in file " + flstr
                return error(errorCode: ecode, message: allmsg)
        }
}
