//
//  UnSartenAppApp.swift
//  UnSartenApp
//
//  Created by Ivan Nieto on 09/01/23.
//

import SwiftUI

@main
struct UnSartenApp: App {
    @StateObject var showNoInternetAlert = NoInternet()

    init() {
        showNoInternetAlert.checkConnectivity()
    }

    var body: some Scene {
        WindowGroup {
            if showNoInternetAlert.showNoInternetAlert {
                NoInternetContentView(showNoConnectionAlert: $showNoInternetAlert.showNoInternetAlert)
            } else {
                LoginContentView()
            }
        }
    }
}
