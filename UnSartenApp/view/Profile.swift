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
    }
}

struct Profile: View {
    @ObservedObject var userDataService: UserDataService
    var body: some View {
        VStack {
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
            
            UserName(name: $userDataService.userFirstName.toUnwrapped(defaultValue: "John Doe"))
            
            Spacer()
            
            Button(action: {
                // logout action
            }) {
                Text("Logout")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile(userDataService: UserDataService())
    }
}
