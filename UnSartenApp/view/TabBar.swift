//
//  TabBar.swift
//  UnSartenApp
//
//  Created by Ivan Nieto on 28/01/23.
//

import SwiftUI

struct TabBar: View {
    @State var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                Text("Chats")
            }
            .tabItem {
                Image(systemName: "message")
                Text("Chats")
            }
            .tag(0)
            
            NavigationView {
                Text("Ordenes")
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Ordenes")
            }
            .tag(1)
            
            NavigationView {
                NewOrder(newOrderService: NewOrderService())
            }
            .tabItem {
                Image(systemName: "plus.square")
                Text("Nueva orden")
            }
            .tag(2)
            
            NavigationView {
                Profile(userDataService: UserDataService())
            }
            .tabItem {
                Image(systemName: "person")
                Text("Perfil")
            }
            .tag(3)
        }
        .accentColor(.blue)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
