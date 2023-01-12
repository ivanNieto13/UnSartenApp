//
//  Login.swift
//  UnSartenApp
//
//  Created by Ivan Nieto on 09/01/23.
//

import SwiftUI

struct LoginContentView: View {
    @State var code = ""
    @State var phoneNumber = ""
    @State var name = ""
    @State var lastname = ""
    @State var email = ""

    @State var showingLoginScreen = false
    @State var showingAlert = false
    @State var showingSendButtonActive = false

    @State private var path = NavigationPath()
    @FocusState private var keyboardFocused: Bool

    var body: some View {
        NavigationStack(path: $path) {
            VStack(alignment: .center, spacing: 20) {
                Text("Inicia sesion o Registrate")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color("IconColor"))
                        .padding(.bottom)

                Text("Numero de telefono")
                        .font(.title3)
                        .bold()
                        .frame(width: 300, alignment: .leading)
                TextField("+52 5566001144", text: $phoneNumber)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background()
                        .cornerRadius(10)
                        .textFieldStyle(.automatic)
                        .border(.red, width: CGFloat(0))
                        .keyboardType(.phonePad)
                        .lineLimit(10)
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
                        .onChange(of: phoneNumber, perform: { value in
                            let fPhoneNumber = (value as NSString).floatValue
                            if fPhoneNumber == 0 {
                                self.phoneNumber = ""
                            }
                            if value.count > 10 {
                                self.phoneNumber = String(value.prefix(10))
                            } else {
                                self.showingSendButtonActive = false
                            }
                            if value.count == 10 {
                                self.showingSendButtonActive = true
                            }
                        })

                Button(action: {
                    showingAlert = true
                }) {
                    switch showingSendButtonActive {
                    case true:
                        Text("Enviar")
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
                        Text("Enviar")
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

                Divider()
                Spacer()
            }
                    .padding()
                    .alert("Confirma tu numero", isPresented: $showingAlert) {
                        Button("Editar", role: .cancel) {
                        }
                        Button("Confirmar", role: .destructive) {
                            path.append("ConfirmCode")
                        }
                    } message: {
                        let formatPhoneNumber = phoneNumber
                        Text("Tu numero es +52 " + formatPhoneNumber + " ?")
                    }
                    .navigationDestination(for: String.self) { view in
                        if view == "ConfirmCode" {
                            ConfirmCodeContentView(path: $path, phoneNumber: $phoneNumber, code: $code)
                        }
                        if view == "RegisterUser" {
                            RegisterUserContentView(path: $path, phoneNumber: $phoneNumber, code: $code,
                                    name: $name, lastname: $lastname, email: $email)
                        }
                    }
        }
    }
}

struct LoginContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginContentView()
    }
}
