//
//  Message.swift
//  Chat Demo
//
//  Created by Mei Yang on 28/3/23.
//

import Foundation


enum Role: String {
    case user
    case assistant
}

class Message: Identifiable {
    
    var id: UUID
    var content: String
    var role: Role
    var timestamp: Date
    
    init(id: UUID = UUID(), content: String, role: Role, timestamp: Date = Date()) {
        self.id = id
        self.content = content
        self.role = role
        self.timestamp = Date()
    }
}

extension Message: Equatable {
    static func ==(lhs: Message, rhs: Message) -> Bool {
        return lhs.id == rhs.id
    }
}
