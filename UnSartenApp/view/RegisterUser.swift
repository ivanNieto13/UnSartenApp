//
//  RegisterUser.swift
//  UnSartenApp
//
//  Created by Ivan Nieto on 09/01/23.
//

import SwiftUI

struct RegisterUserContentView: View {
    @State var showingLoginScreen = false
    @State var showingAlert = false
    @State var showingSendButtonActive = false

    @State var validName = false
    @State var validLastname = false
    @State var validEmail = false

    @Binding var path: NavigationPath
    @Binding var phoneNumber: String
    @Binding var code: String
    @Binding var name: String
    @Binding var lastname: String
    @Binding var email: String

    @Environment(\.presentationMode) var presentation
    @FocusState private var keyboardFocused: Bool

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Ingresa tus datos")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color("IconColor"))
                    .padding(.bottom)

            // Names
            Text("Nombre(s)")
                    .font(.title3)
                    .bold()
                    .frame(width: 300, alignment: .leading)
            TextField("John H.", text: $name)
                    .autocapitalization(.words)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background()
                    .cornerRadius(10)
                    .textFieldStyle(.automatic)
                    .border(.red, width: CGFloat(0))
                    .keyboardType(.asciiCapable)
                    .lineLimit(100)
                    .foregroundColor(Color("TertiaryColor"))
                    .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("TertiaryColor"), lineWidth: 2)
                    )
                    .focused($keyboardFocused)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            keyboardFocused = true
                        }
                    }
                    .onChange(of: name, perform: { value in
                        let usernamePattern = #"^[a-zA-Z-]+ ?.*"#
                        let result = value.range(
                                of: usernamePattern,
                                options: .regularExpression
                        )

                        validName = (result != nil)
                        showingSendButtonActive = validEmail && validName && validLastname
                    })


            // Lastname
            Text("Apellido(s)")
                    .font(.title3)
                    .bold()
                    .frame(width: 300, alignment: .leading)
            TextField("Doe Ford", text: $lastname)
                    .autocapitalization(.words)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background()
                    .cornerRadius(10)
                    .textFieldStyle(.automatic)
                    .border(.red, width: CGFloat(0))
                    .keyboardType(.asciiCapable)
                    .lineLimit(100)
                    .foregroundColor(Color("TertiaryColor"))
                    .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("TertiaryColor"), lineWidth: 2)
                    )
                    .onChange(of: lastname, perform: { value in
                        let lastnamePattern = #"^[a-zA-Z-]+ ?.*"#
                        let result = value.range(
                                of: lastnamePattern,
                                options: .regularExpression
                        )

                        validLastname = (result != nil)
                        showingSendButtonActive = validEmail && validName && validLastname
                    })

            // Email
            Text("Email")
                    .font(.title3)
                    .bold()
                    .frame(width: 300, alignment: .leading)
            TextField("john.doe@provider.com", text: $email)
                    .autocapitalization(.none)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background()
                    .cornerRadius(10)
                    .textFieldStyle(.plain)
                    .border(.red, width: CGFloat(0))
                    .keyboardType(.emailAddress)
                    .lineLimit(100)
                    .foregroundColor(Color("TertiaryColor"))
                    .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("TertiaryColor"), lineWidth: 2)
                    )
                    .onChange(of: email, perform: { value in
                        let emailPattern = #"^\S+@\S+\.\S+$"#
                        let result = value.range(
                                of: emailPattern,
                                options: .regularExpression
                        )

                        validEmail = (result != nil)
                        showingSendButtonActive = validEmail && validName && validLastname
                    })

            Button(action: {
                showingAlert = true
                print("code \(code)")
                print("phoneNumber \(phoneNumber)")
                print("name \(name)")
                print("lastname \(lastname)")
                print("email \(email)")
            }) {
                switch showingSendButtonActive {
                case true:
                    Text("Siguiente")
                            .fontWeight(.bold)
                            .font(.title3)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color("PositiveButtonColor"))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color("PositiveButtonColor"), lineWidth: 5)
                            )
                case false:
                    Text("Siguiente")
                            .fontWeight(.bold)
                            .font(.title3)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color(.lightGray))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color(.lightGray), lineWidth: 5)
                            )
                }
            }
                    .padding(.top)
                    .disabled(!showingSendButtonActive)

            Spacer()

        }
                .padding()
                .navigationBarBackButtonHidden(true)
    }


}

struct RegisterUserContentView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterUserContentView(path: .constant(NavigationPath()), phoneNumber: .constant(""), code: .constant(""),
                name: .constant(""), lastname: .constant(""), email: .constant(""))
    }
}
