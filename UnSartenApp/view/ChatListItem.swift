//
//  ChatListItem.swift
//  UnSartenApp
//
//  Created by Ivan Nieto on 29/01/23.
//

import SwiftUI

struct ChatListItem: View {
    var chatUserName: String
    var chatPreviewMessage: String
    
    var body: some View {
        return Group {
            HStack {
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text(chatUserName)
                        .font(.headline)
                        .foregroundColor(Color("IconColor"))
                    HStack {
                        Text(chatPreviewMessage)
                            .font(.subheadline)
                        Spacer()
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
        }
        
        .onTapGesture {
        }
    }
}

struct ChatListItem_Previews: PreviewProvider {
    static var previews: some View {
        ChatListItem(chatUserName: "John Doe", chatPreviewMessage: "Hola!")
    }
}
