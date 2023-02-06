//
//  CoreDataManager.swift
//  UnSartenApp
//
//  Created by Ivan Nieto on 05/02/23.
//

import Foundation
import CoreData

class CoreDataManager {
    let persistenContainer: NSPersistentContainer
    
    init() {
        persistenContainer = NSPersistentContainer(name: "UnSartenApp")
        persistenContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core Data Store Failed \(error.localizedDescription)")
            }
            
        }
    }
    
    func getUserData() -> UserData? {
        let fetchRequest: NSFetchRequest<UserData> = UserData.fetchRequest()
        
        do {
            let userList = try persistenContainer.viewContext.fetch(fetchRequest)
            print("userList -> \(userList)")
            if userList.isEmpty {
                return nil
            } else {
                return userList[0]
            }
        } catch {
            return nil
        }
    }
    
    func saveUserData(userId: String, phoneNumber: String, firstName: String, lastName: String, email: String) {
        let user = UserData(context: persistenContainer.viewContext)
        user.userId = userId
        user.phoneNumber = phoneNumber
        user.firstName = firstName
        user.lastName = lastName
        user.email = email
        
        do {
            try persistenContainer.viewContext.save()
        } catch {
            print("Failed to save a movie \(error)")
        }
    }
    
    func deleteUserData() {
        let fetchRequest: NSFetchRequest<UserData> = UserData.fetchRequest()
        do {
            let userList = try persistenContainer.viewContext.fetch(fetchRequest)
            for user in userList {
                persistenContainer.viewContext.delete(user)
            }
            try persistenContainer.viewContext.save()
        } catch {
            print("Error at delete user")
        }
    }
    
}
