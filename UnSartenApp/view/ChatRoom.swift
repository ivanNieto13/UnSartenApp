//
//  ChatRoom.swift
//  UnSartenApp
//
//  Created by Ivan Nieto on 29/01/23.
//

import SwiftUI

struct ChatTopBar: View {
    var body: some View {
        return Group {
            HStack(alignment: .center) {
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text("John Doe")
                        .font(.headline)
                        .foregroundColor(Color("IconColor"))
                }
                
                Spacer()
                Button {
                    print("Edit button was tapped")
                } label: {
                    Image(systemName: "phone")
                        .scaledToFit()
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                        .foregroundColor(Color("IconColor"))
                        .background(Color("MainColor"))
                        .clipShape(Circle())
                    
                }
                .padding([.leading, .trailing], 30)
                
            }
            .padding()
            .background(Color.white)
        }
    }
}

struct ChatBottomBar: View {
    @State var messageInput: String = ""
    var body: some View {
        return Group {
            HStack(alignment: .center) {
                TextField("Hola!, como estas?", text: $messageInput)
                    .padding()
                    .frame(width: 250.0, height: 50)
                    .background()
                    .cornerRadius(10)
                    .textFieldStyle(.automatic)
                    .border(.red, width: CGFloat(0))
                    .keyboardType(.asciiCapable)
                    .foregroundColor(Color("TertiaryColor"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("TertiaryColor"), lineWidth: 2)
                    )
                    .onChange(of: messageInput, perform: { value in
                        messageInput = value
                    })
                Button {
                    print("Edit button was tapped")
                } label: {
                    Image(systemName: "paperclip")
                        .scaledToFit()
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                        .foregroundColor(Color("IconColor"))
                        .background(Color("MainColor"))
                        .clipShape(Circle())
                }
                Button {
                    print("Edit button was tapped")
                } label: {
                    Image(systemName: "paperplane")
                        .scaledToFit()
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                        .foregroundColor(.white)
                        .background(Color("PrimaryColor"))
                }
                
            }
        }
    }
}

struct ChatRoom: View {
    var body: some View {
        VStack {
            Group {
                Text("Mensajes de solicitud")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color("IconColor"))
                    .padding(.bottom)
                ChatTopBar()
                Divider()
                Spacer()
            }
            Group {
                // content (messages)
                
            }
            Group {
                // send message bar
                ChatBottomBar()
            }
        }
    }
}

struct ChatRoom_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoom()
    }
}
