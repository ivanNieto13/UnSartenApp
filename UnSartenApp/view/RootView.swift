//
//  RootView.swift
//  UnSartenApp
//
//  Created by Ivan Nieto on 05/02/23.
//

import SwiftUI

struct RootView: View {
    @State var isActive : Bool = false
    @StateObject var showNoInternetAlert = NoInternet()

    let coreDM: CoreDataManager
    
    var body: some View {
        Group {
            if showNoInternetAlert.showNoInternetAlert {
                NoInternetContentView(showNoConnectionAlert: $showNoInternetAlert.showNoInternetAlert)
            } else {
                if getUserData() {
                    TabBar(coreDM: coreDM)
                } else {
                    LoginContentView(coreDM: coreDM)
                }
            }
        }.onAppear() {
            showNoInternetAlert.checkConnectivity()
        }
    }
    
    func getUserData() -> Bool {
        let user = coreDM.getUserData()
        if user != nil {
            return true
        } else {
            return false
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(coreDM: CoreDataManager())
    }
}
