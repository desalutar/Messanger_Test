//
//  UserMessage.swift
//  Messanger_Test
//
//  Created by Ишхан Багратуни on 27.12.23.
//

import Foundation

enum MessageType {
    case send
    case received
}

struct UserMessages: Hashable {
    var messageType: MessageType
    var text = String()
}
