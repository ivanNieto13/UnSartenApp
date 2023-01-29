//
//  UserData.swift
//  UnSartenApp
//
//  Created by Ivan Nieto on 29/01/23.
//

import Foundation

class UserDataService: ObservableObject {
    @Published var userFirstName: String?
    @Published var userLastName: String?
    @Published var userEmail: String?
}
