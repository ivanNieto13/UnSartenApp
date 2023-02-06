//
//  TabBar.swift
//  UnSartenApp
//
//  Created by Ivan Nieto on 28/01/23.
//

import SwiftUI

struct TabBar: View {
    @State var selectedTab = 0
    let coreDM: CoreDataManager
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                ChatList(chatsService: ChatsService())
            }
                    .tabItem {
                        Image(systemName: "message")
                        Text("Chats")
                    }
                    .tag(0)

            NavigationView {
                FetchOrders(fetchOrdersService: FetchOrdersService())
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
                Profile(userDataService: UserDataService(), coreDM: coreDM)
            }
                    .tabItem {
                        Image(systemName: "person")
                        Text("Perfil")
                    }
                    .tag(3)
        }
                .accentColor(.blue)
                .onAppear() {
                    print("TabBar - onAppear")
                }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(coreDM: CoreDataManager())
    }
}
