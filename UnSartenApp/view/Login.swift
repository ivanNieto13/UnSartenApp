//
//  Login.swift
//  UnSartenApp
//
//  Created by Ivan Nieto on 09/01/23.
//

import SwiftUI

struct LoginContentView: View {
    @StateObject private var verifyNumberViewModel = VerifyNumberViewModel()
    let coreDM: CoreDataManager
    @State private var verifyCodeViewModel = VerifyCodeViewModel()
    @State private var getUserByIdViewModel = GetUserByIdViewModel()

    @State var confirmButton = false
    @State var userData = SaveUserData(data: SUDataClass(saveUserData: SaveUserSUDataClass(userID: "", email: "", firstName: "", lastName: "", phoneNumber: ""), error: nil))

    @State var confirmCode = false

    @State var code = ""
    @State var phoneNumber = ""
    @State var name = ""
    @State var lastname = ""
    @State var email = ""
    @State var verifyNumber = VerifyNumber(data: DataClass(verifyNumber: VerifyNumberClass(phoneNumber: "", isVerified: true, userId: "", firstName: "", lastName: "", email: nil), error: nil))
    @State var verifyCode = VerifyCode(data: VCDataClass(verifyCode: VerifyCodeClass(code: "", isValid: false), error: nil))

    @State var showingLoginScreen = false
    @State var showingAlert = false
    @State var showingSendButtonActive = false

    @State private var path = NavigationPath()
    @FocusState private var keyboardFocused: Bool

    var body: some View {
        NavigationStack(path: $path) {
            if (verifyNumberViewModel.isLoading) {
                ZStack {
                    ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color("IconColor")))

                    // TODO - make color from assets colors
                    Color(.black)
                            // TODO - make this opacity from a constant
                            .opacity(0.1)
                            .ignoresSafeArea()
                }
            } else {
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
                                verifyNumberViewModel.confirmCode = false
                                DispatchQueue.main.async {
                                    verifyNumberViewModel.verifyPhone(phoneNumber: "+52\(phoneNumber)")
                                }
                            }
                        } message: {
                            let formatPhoneNumber = phoneNumber
                            Text("Tu numero es +52 " + formatPhoneNumber + " ?")
                        }
                        .navigationDestination(for: String.self) { view in
                            if view == "ConfirmCode" {
                                ConfirmCodeContentView(verifyCodeViewModel_: $verifyCodeViewModel, path: $path, code: $code, verifyNumber: $verifyNumber, verifyCode: $verifyCode, confirmCode: $confirmCode)
                            }
                            if view == "RegisterUser" {
                                RegisterUserContentView(path: $path, userData: $userData, verifyNumber: $verifyNumber, verifyCode: $verifyCode, email: $email, firstName: $name, lastName: $lastname, coreDM: coreDM)
                            }
                            if view == "Home" {
                                HomeContentView(path: $path, coreDM: coreDM)
                            }
                        }
            }

        }
                .onChange(of: verifyNumberViewModel.confirmCode, perform: { navigate in
                    if navigate {
                        verifyNumber = verifyNumberViewModel.verifyNumber
                        if verifyNumber.data.verifyNumber.userId != "" {
                            verifyCodeViewModel.userId = verifyNumber.data.verifyNumber.userId ?? ""
                            if verifyCodeViewModel.userId != "" {
                                saveUserData(verifyNumber: verifyNumber.data.verifyNumber)
                            }
                        }
                        path.append("ConfirmCode")
                    } else {
                        if verifyNumberViewModel.verifyNumber.data.verifyNumber.phoneNumber == "+52\(phoneNumber)" {
                            verifyNumberViewModel.confirmCode = true
                        }
                    }
                })
    }

    private func setDefaultValueVerifyNumber() -> VerifyNumber {
        VerifyNumber(data: DataClass(verifyNumber: VerifyNumberClass(phoneNumber: phoneNumber, isVerified: false, userId: nil, firstName: nil, lastName: nil, email: nil), error: nil))
    }

    private func saveUserData(verifyNumber: VerifyNumberClass) {
        let userId = verifyNumber.userId
        let email = verifyNumber.email
        let firstName = verifyNumber.firstName
        let lastName = verifyNumber.lastName
        let phoneNumber = verifyNumber.phoneNumber
        coreDM.saveUserData(
            userId: userId!,
            phoneNumber: phoneNumber,
            firstName: firstName!,
            lastName: lastName!,
            email: email!
        )
        
    }
}

struct LoginContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginContentView(coreDM: CoreDataManager())
    }
}
