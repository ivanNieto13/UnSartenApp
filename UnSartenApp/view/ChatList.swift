//
//  ChatList.swift
//  UnSartenApp
//
//  Created by Ivan Nieto on 29/01/23.
//

import SwiftUI

struct ChatList: View {
    @ObservedObject var chatsService: ChatsService
    var messages = [ChatPreview()]
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Mensajes")
                .font(.title)
                .bold()
                .foregroundColor(Color("IconColor"))
                .padding(.bottom)
            
            if true {
                ChatListItem(chatUserName: "Oliver", chatPreviewMessage: "Hola!")
            } else {
                Text("No tienes mensajes.")
                    .font(.body)
                    .bold()
                    .padding(.bottom)
            }
            Spacer()
        }
    }
}

struct ChatList_Previews: PreviewProvider {
    static var previews: some View {
        ChatList(chatsService: ChatsService())
    }
}
