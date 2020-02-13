//
//  Event.swift
//  hackBCA Schedule
//
//  Created by Anthony Li on 2/11/20.
//  Copyright © 2020 Anthony Li. All rights reserved.
//

import Foundation

public enum EventType: String, Codable {
    case workshop = "workshop"
    case activity = "activity"
    case meal = "meal"
    case ceremony = "ceremony"
    case misc = "misc"
}

public struct Event: Decodable, Identifiable {
    public var id: String { name }
    
    public var type: EventType
    public var name: String
    public var presenter: String?
    public var description: String?
    public var start: Date
    public var end: Date?
    public var location: String?
    public var requirements: String?
}
