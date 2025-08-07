/*
 * @file MIEvent.swift
 * @description Define event types
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

#if os(OSX)
public typealias MIEvent = NSEvent
#else
public typealias MIEvent = UIEvent
#endif

@MainActor public class MIViewEvent
{
        public enum EventType {
                case rightMouseDown
        }

        private var mEventType: EventType
        private var mTagValue:  Int

        public var type: EventType { get { mEventType }}
        public var tag:  Int       { get { mTagValue  }}

        public init(eventType etype: EventType, tag tagval: Int){
                self.mEventType = etype
                self.mTagValue  = tagval
        }

        public func toString() -> String {
                var result = "ViewEvent{"
                switch mEventType {
                case .rightMouseDown:   result += "rightMouseDown"
                }
                result += "}"
                return result
        }
}

public protocol MIViewEventReceiver
{
        func acceptViewEvent(_ event: MIViewEvent)
}

extension MICoreView
{
        nonisolated public func notifyViewEvent(_ event: MIViewEvent) {
                var responderp: MIResponder? = self

                var docont = true
                while docont {
                        if let resp = responderp {
                                if let recv = resp as? MIViewEventReceiver {
                                        recv.acceptViewEvent(event)
                                }
                                #if os(OSX)
                                responderp = responderp?.nextResponder
                                #else
                                responderp = responderp?.next
                                #endif
                        } else {
                                docont = false
                        }
                }
        }
}
