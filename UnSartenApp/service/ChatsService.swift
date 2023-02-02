//
//  ChatsService.swift
//  UnSartenApp
//
//  Created by Ivan Nieto on 29/01/23.
//

import Foundation

class ChatPreview {
    var chatUserName: String = "John Doe"
    var chatMessagePreview: String = "Hola!"
}

class ChatsService: ObservableObject {
    @Published var chats: [ChatPreview] = [ChatPreview()]
}
