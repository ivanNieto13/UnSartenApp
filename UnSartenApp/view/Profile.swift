//
//  Profile.swift
//  UnSartenApp
//
//  Created by Ivan Nieto on 29/01/23.
//

import SwiftUI

struct UserName : View {
    @Binding var name : String
    
    var body: some View {
        
        return Text(name)
            .font(.largeTitle)
            .padding(.bottom, 20)
            .foregroundColor(Color("IconColor"))
    }
}

struct UserEmail : View {
    @Binding var email : String
    
    var body: some View {
        return Text(email)
            .font(.title2)
            .padding(.bottom, 20)
            .foregroundColor(Color("IconColor"))
    }
}

struct Profile: View {
    @ObservedObject var userDataService: UserDataService
    let coreDM: CoreDataManager
    var body: some View {
        VStack {
            Text("Perfil")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color("IconColor"))
                    .padding(.bottom)
            Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())

            UserName(name: $userDataService.userFirstName.toUnwrapped(defaultValue: "John Doe"))

            UserEmail(email: $userDataService.userEmail.toUnwrapped(defaultValue: "user@email.com"))

            Spacer()

            /*Button(action: {
                coreDM.deleteUserData()
            }) {
                Text("Cerrar sesion")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color("PrimaryColor"))
                        .cornerRadius(10)
            }*/
        }
                .onAppear() {
                    let data = coreDM.getUserData()
                    userDataService.userFirstName = data?.firstName ?? ""
                    userDataService.userLastName = data?.lastName ?? ""
                    userDataService.userEmail = data?.email ?? ""
                }
        .padding()
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile(userDataService: UserDataService(),
                coreDM: CoreDataManager())
    }
}
