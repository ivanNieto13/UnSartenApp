//
//  ConfirmCode.swift
//  UnSartenApp
//
//  Created by Ivan Nieto on 09/01/23.
//

import SwiftUI

struct ConfirmCodeContentView: View {
    @StateObject private var verifyCodeViewModel = VerifyCodeViewModel()
    @StateObject private var saveUserModel = SaveUserDataViewModel()

    @State var showingLoginScreen = false
    @State var showingAlert = false
    @State var showAlert = false
    @State var showingSendButtonActive = false

    @Binding var path: NavigationPath
    @Binding var code: String
    @Binding var verifyNumber: VerifyNumber
    @Binding var verifyCode: VerifyCode

    @Binding var confirmCode: Bool

    @Environment(\.presentationMode) var presentation
    @FocusState private var keyboardFocused: Bool

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Ingresa el código de 4 dígitos que se te envió a \(verifyNumber.data.verifyNumber.phoneNumber)")
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
                DispatchQueue.main.async {
                    verifyCodeViewModel.isLoading = true
                    verifyCodeViewModel.verifyCode(code: code)
                }
                showingAlert = true
                // if user is not registered, register user
                // if user is registered, go to main screen
                // call api to fetch orders data and list them
                // path.append("MainScreen")
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
                confirmCode = false
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

            Button("Code") {

            }
                    .opacity(0)
                    .alert(isPresented: $showAlert) {
                        Alert(
                                title: Text("Codigo Invalido"),
                                message: Text("El codigo que ingresaste es incorrecto, intenta nuevamente."))
                    }
                    .onDisappear {
                        showAlert = false
                    }

            Spacer()

        }
                .onChange(of: verifyCodeViewModel.verifyCode.data.verifyCode.code != "" && saveUserModel.isLoading == false, perform: { value in
                    if value != nil {
                        verifyCode = verifyCodeViewModel.verifyCode
                        if verifyCode.data.verifyCode.isValid == true {
                            path.append("RegisterUser")
                        } else {
                            showAlert = true
                        }
                    }
                })
                .onAppear {
                    print("ConfirmCodeContentView onAppear", verifyNumber.data.verifyNumber)

                }
                .padding()
                .navigationBarBackButtonHidden(true)

    }
}

struct ConfirmCodeContentView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmCodeContentView(path: .constant(NavigationPath()),
                code: .constant(""),
                verifyNumber: .constant(VerifyNumber(data: DataClass(verifyNumber: VerifyNumberClass(phoneNumber: "", isVerified: false, userID: nil), error: nil))),
                verifyCode: .constant(VerifyCode(data: VCDataClass(verifyCode: VerifyCodeClass(code: "", isValid: true), error: nil))), confirmCode: .constant(false))
    }
}
