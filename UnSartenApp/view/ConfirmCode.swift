//
//  ConfirmCode.swift
//  UnSartenApp
//
//  Created by Ivan Nieto on 09/01/23.
//

import SwiftUI

struct ConfirmCodeContentView: View {
    @State var showingLoginScreen = false
    @State var showingAlert = false
    @State var showingSendButtonActive = false

    @Binding var path: NavigationPath
    @Binding var phoneNumber: String
    @Binding var code: String

    @Environment(\.presentationMode) var presentation
    @FocusState private var keyboardFocused: Bool

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Ingresa el código de 4 dígitos que se te envió a +52 \(phoneNumber)")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color("IconColor"))
                    .padding(.bottom)

            Text("Código de 4 dígitos")
                    .font(.title3)
                    .bold()
                    .frame(width: 300, alignment: .leading)
            TextField("1234", text: $code)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background()
                    .cornerRadius(10)
                    .textFieldStyle(.automatic)
                    .border(.red, width: CGFloat(0))
                    .keyboardType(.phonePad)
                    .lineLimit(4)
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
                    .onChange(of: code, perform: { value in
                        if value.count > 4 {
                            self.code = String(value.prefix(4))
                        } else {
                            self.showingSendButtonActive = false
                        }
                        if value.count == 4 {
                            self.showingSendButtonActive = true
                        }
                    })

            Button(action: {
                showingAlert = true
                path.append("RegisterUser")
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

            Button("Cambiar teléfono") {
                presentation.wrappedValue.dismiss()
            }
                    .fontWeight(.bold)
                    .font(.body)
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(Color("MainColor"))
                    .cornerRadius(10)
                    .foregroundColor(Color("PrimaryColor"))
                    .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("TertiaryColor"), lineWidth: 1)
                    )

            Spacer()

        }
                .padding()
                .navigationBarBackButtonHidden(true)

    }
}

struct ConfirmCodeContentView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmCodeContentView(path: .constant(NavigationPath()), phoneNumber: .constant(""), code: .constant(""))
    }
}
